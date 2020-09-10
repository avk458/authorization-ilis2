package cn.hitek.authorization.ilis2.product.unit.service.impl;

import cn.hitek.authorization.ilis2.common.constants.Constant;
import cn.hitek.authorization.ilis2.framework.socket.manager.SocketManager;
import cn.hitek.authorization.ilis2.framework.socket.manager.WsToken;
import cn.hitek.authorization.ilis2.framework.web.service.impl.BaseServiceImpl;
import cn.hitek.authorization.ilis2.product.unit.domain.ClientAccount;
import cn.hitek.authorization.ilis2.product.unit.domain.LoginInfo;
import cn.hitek.authorization.ilis2.product.unit.helper.UnitOnlineBucket;
import cn.hitek.authorization.ilis2.product.unit.mapper.ClientAccountMapper;
import cn.hitek.authorization.ilis2.product.unit.mapper.LoginInfoMapper;
import cn.hitek.authorization.ilis2.product.unit.service.UnitUserLogger;
import cn.hutool.core.map.MapUtil;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.redis.core.BoundHashOperations;
import org.springframework.data.redis.core.BoundSetOperations;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.scheduling.annotation.Async;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.*;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.stream.Collectors;

/**
 * @author chenlm
 */
@Slf4j
@Service
@AllArgsConstructor
public class UnitUserLoggerImpl extends BaseServiceImpl<LoginInfoMapper, LoginInfo> implements UnitUserLogger {

    private final RedisTemplate<String, Object> redisTemplate;
    private final RedisTemplate<String, ClientAccount> accountRedis;
    private final ClientAccountMapper accountMapper;

    private BoundSetOperations<String, Object> loginBuffer(String key) {
        return this.redisTemplate.boundSetOps(key);
    }

    private BoundHashOperations<String, String, ClientAccount> accountHashOps(String unitCode) {
        final String clientTotalAccountsKey = Constant.ILIS_CLIENT_ACCOUNTS_PREFIX + unitCode;
        return this.accountRedis.boundHashOps(clientTotalAccountsKey);
    }

    private ClientAccount accountGetter(String unitCode, String userId) {
        return accountHashOps(unitCode).get(userId);
    }

    private void accountSetter(String unitCode, ClientAccount account) {
        accountHashOps(unitCode).put(account.getUserId(), account);
    }

    @Async
    @Override
    public void handleLoginLog(LoginInfo loginInfo) {
        String key = Constant.ILIS_LOGIN_BUFFER_PREFIX + loginInfo.getUnitCode();
        loginBuffer(key).add(loginInfo);
    }

    @Async
    @Override
    public void handleLoginStatisticLog(LoginInfo loginInfo) {
        String userId = loginInfo.getUserId();
        String unitCode = loginInfo.getUnitCode();
        String sessionId = loginInfo.getSessionId();
        LocalDateTime now = LocalDateTime.now();
        ClientAccount account = accountGetter(unitCode, userId);
        if (account == null) {
            account = new ClientAccount(loginInfo);
            account.setLoginTimes(1L);
        }
        account.setLastOperations(now);
        Map<String, LocalDateTime> sessions = account.getSessions();
        if (LoginInfo.LOGIN == loginInfo.getOperationType()) {
            UnitOnlineBucket.put(this.redisTemplate, loginInfo);
            account.setLoginTimes(account.getLoginTimes() + 1);
            sessions.put(sessionId, now);
        } else {
            sessions.remove(sessionId);
            if (LoginInfo.KICK_OUT == loginInfo.getOperationType()) {
                try {
                    SocketManager.destroySession(sessionId);
                } catch (IOException e) {
                    log.warn("销毁被踢出用户连接失败");
                    e.printStackTrace();
                }
            }
        }
        persistentAccount(account);
        accountSetter(unitCode, account);
    }

    private void persistentAccount(ClientAccount account) {
        Long accountId = account.getId();
        if (accountId != null) {
            this.accountMapper.updateById(account);
        } else {
            this.accountMapper.insert(account);
        }
    }

    @Override
    public void addAccountSession(WsToken token) {
        ClientAccount account = accountGetter(token.getUnitCode(), token.getUserId());
        if (account != null) {
            account.getSessions().put(token.getSessionId(), LocalDateTime.now());
            account.setLastOperations(LocalDateTime.now());
            accountSetter(token.getUnitCode(), account);
        }
    }

    @Override
    public void removeAccountSession(WsToken token) {
        ClientAccount account = accountGetter(token.getUnitCode(), token.getUserId());
        if (account != null) {
            account.getSessions().remove(token.getSessionId());
            account.setLastOperations(LocalDateTime.now());
            accountSetter(token.getUnitCode(), account);
        }
    }

    @Override
    public Integer getUnitOnlineAccounts(String uniqCode) {
        BoundHashOperations<String, String, ClientAccount> ops = accountHashOps(uniqCode);
        Map<String, ClientAccount> entries = ops.entries();
        entries = Optional.ofNullable(entries).orElse(MapUtil.empty());
        return entries.values().stream()
                .map(ClientAccount::getSessions)
                .map(Map::size)
                .reduce(Integer::sum)
                .orElse(0);
    }

    @Override
    public IPage<LoginInfo> getUnitAccountLogs(String unitCode, Page<LoginInfo> page) {
        return baseMapper.selectPage(page, Wrappers.lambdaQuery(LoginInfo.class)
                .eq(LoginInfo::getUnitCode, unitCode)
                .orderByDesc(LoginInfo::getOperationTime));
    }

    @Override
    public IPage<LoginInfo> getUnitOnlineAccounts(String unitCode, String userId, String sessionIds, Page<LoginInfo> page) {
        return baseMapper.selectPage(page, Wrappers.lambdaQuery(LoginInfo.class)
                .eq(LoginInfo::getUnitCode, unitCode)
                .eq(LoginInfo::getUserId, userId)
                .in(LoginInfo::getSessionId, Arrays.asList(sessionIds.split(",")))
                .orderByDesc(LoginInfo::getOperationTime));
    }

    @Scheduled(cron = "0 0 0/1 * * ? ")
    @Override
    public void flushLogIfPresent() {
        Set<String> keys = this.redisTemplate.keys(Constant.ILIS_LOGIN_BUFFER_PREFIX + "*");
        keys = Optional.ofNullable(keys).orElse(new HashSet<>());
        for (String key : keys) {
            BoundSetOperations<String, Object> ops = loginBuffer(key);
            Set<Object> members = ops.members();
            Optional.ofNullable(members).ifPresent(m -> {
                m.stream().map(o -> (LoginInfo) o).forEach(this::save);
                ops.getOperations().delete(key);
            });
        }
    }

    @Override
    public Boolean isUserOnline(String userId, String code) {
        ClientAccount account = accountGetter(code, userId);
        account = Optional.ofNullable(account).orElse(new ClientAccount());
        return account.getSessions().size() > 0;
    }

    @Override
    public int getUnitTotalAccounts(String unitCode) {
        BoundHashOperations<String, String, ClientAccount> ops = accountHashOps(unitCode);
        Map<String, ClientAccount> entries = ops.entries();
        return Optional.ofNullable(entries).orElse(MapUtil.empty()).size();
    }

    @Override
    public IPage<ClientAccount> getClientAccounts(String unitCode, Page<ClientAccount> page) {
        BoundHashOperations<String, String, ClientAccount> hashOps = accountHashOps(unitCode);
        Map<String, ClientAccount> entries = hashOps.entries();
        entries = Optional.ofNullable(entries).orElse(MapUtil.empty());
        Page<ClientAccount> data = new Page<>();
        data.setTotal(entries.size());
        List<ClientAccount> accounts = entries.values()
                .stream()
                .sorted(Comparator
                        .nullsLast(Comparator.comparing(ClientAccount::getLastOperations))
                        .thenComparing(ClientAccount::isOnline)
                        .reversed())
                .skip((page.getCurrent() - 1) * page.getSize())
                .limit(page.getSize())
                .collect(Collectors.toList());
        data.setRecords(accounts);
        return data;
    }

    @Override
    public IPage<LoginInfo> getAccountLogs(String unitCode, String userId, Page<LoginInfo> page) {
        return baseMapper.selectPage(page, Wrappers.lambdaQuery(LoginInfo.class)
                .eq(LoginInfo::getUnitCode, unitCode)
                .eq(LoginInfo::getUserId, userId)
                .orderByDesc(LoginInfo::getOperationTime));
    }

    @Override
    public Map<String, Integer> combineAccounts() {
        HashMap<String, Integer> result = new HashMap<>(0);
        Set<String> keys = this.redisTemplate.keys(Constant.ILIS_CLIENT_ACCOUNTS_PREFIX + "*");
        keys = Optional.ofNullable(keys).orElse(Collections.emptySet());
        AtomicInteger totalCounter = new AtomicInteger(0);
        AtomicInteger onlineCounter = new AtomicInteger(0);
        keys.forEach(key -> {
            BoundHashOperations<String, String, ClientAccount> ops = this.accountRedis.boundHashOps(key);
            Map<String, ClientAccount> entries = ops.entries();
            entries = Optional.ofNullable(entries).orElse(MapUtil.empty());
            totalCounter.addAndGet(entries.size());
            onlineCounter.addAndGet(entries
                    .values()
                    .stream()
                    .map(ClientAccount::getSessions)
                    .map(Map::size)
                    .reduce(Integer::sum)
                    .orElse(0));
        });
        result.put("total", totalCounter.intValue());
        result.put("online", onlineCounter.intValue());
        return result;
    }
}
