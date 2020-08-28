package cn.hitek.authorization.ilis2.product.unit.service.impl;

import cn.hitek.authorization.ilis2.common.constants.Constant;
import cn.hitek.authorization.ilis2.framework.socket.manager.SocketManager;
import cn.hitek.authorization.ilis2.framework.web.service.impl.BaseServiceImpl;
import cn.hitek.authorization.ilis2.product.unit.domain.LoginInfo;
import cn.hitek.authorization.ilis2.product.unit.helper.UnitOnlineBucket;
import cn.hitek.authorization.ilis2.product.unit.mapper.LoginInfoMapper;
import cn.hitek.authorization.ilis2.product.unit.service.UnitUserLogger;
import cn.hutool.core.codec.Base64;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.StringPool;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.redis.core.BoundSetOperations;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.ValueOperations;
import org.springframework.lang.Nullable;
import org.springframework.scheduling.annotation.Async;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import javax.annotation.PreDestroy;
import java.io.IOException;
import java.time.LocalDateTime;
import java.util.*;
import java.util.concurrent.TimeUnit;
import java.util.stream.Collectors;

/**
 * @author chenlm
 */
@Slf4j
@Service
@AllArgsConstructor
public class UnitUserLoggerImpl extends BaseServiceImpl<LoginInfoMapper, LoginInfo> implements UnitUserLogger {

    private final RedisTemplate<String, Object> redisTemplate;

    private ValueOperations<String, Object> sessionStorage() {
        return this.redisTemplate.opsForValue();
    }

    private BoundSetOperations<String, Object> unitTotalClientStorage(String unitCode) {
        return this.redisTemplate.boundSetOps(getTotalUsersKey(unitCode));
    }

    private BoundSetOperations<String, Object> loginBuffer(String key) {
        return this.redisTemplate.boundSetOps(key);
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
        unitTotalClientStorage(loginInfo.getUnitCode()).add(loginInfo.getUserId());
        final String key = generateOnlineKey(loginInfo.getUnitCode(), loginInfo.getSessionId());
        if (loginInfo.getLogin()) {
            set(key, loginInfo);
            UnitOnlineBucket.put(this.redisTemplate, loginInfo);
        } else {
            try {
                SocketManager.destroySession(encodeWsToken(loginInfo.getSessionId(), loginInfo.getUnitCode()));
            } catch (IOException e) {
                log.warn("尝试销毁ilis用户长连接失败， {}", loginInfo.toString());
                e.printStackTrace();
            } finally {
                this.redisTemplate.delete(key);
            }
        }
    }

    private String generateOnlineKey(String unitCode, String sessionId) {
        return Constant.ILIS_LOGIN_ONLINE_PREFIX + unitCode + "." + sessionId;
    }

    private String generateOfflineKey(String unitCode, String sessionId) {
        return Constant.ILIS_LOGIN_OFFLINE_PREFIX + unitCode + "." + sessionId;
    }

    @Override
    public String getTotalUsersKey(String unitCode) {
        return Constant.ILIS_LOGIN_TOTAL_PREFIX + unitCode;
    }

    @Override
    public void addOnlineUser(String token) {
        String wsToken = decodeWsToken(token);
        if (StrUtil.isBlank(wsToken)) {
            return;
        }
        if (wsToken.contains(StringPool.COMMA)) {
            String[] split = wsToken.split(StringPool.COMMA);
            final String offlineKey = generateOfflineKey(split[1], split[0]);
            LoginInfo info = get(offlineKey);
            Optional.ofNullable(info).ifPresent(i -> {
                String key = generateOnlineKey(i.getUnitCode(), i.getSessionId());
                set(key, i);
                this.redisTemplate.delete(offlineKey);
                UnitOnlineBucket.put(this.redisTemplate, i);
            });
        }
    }

    @Override
    public void removeOnlineUser(String token) {
        String wsToken = decodeWsToken(token);
        if (StrUtil.isBlank(wsToken)) {
            return;
        }
        SocketManager.remove(token);
        if (wsToken.contains(StringPool.COMMA)) {
            String[] split = wsToken.split(StringPool.COMMA);
            final String key = generateOnlineKey(split[1], split[0]);
            LoginInfo info = get(key);
            Optional.ofNullable(info).ifPresent(i -> {
                final String offlineKey = generateOfflineKey(i.getUnitCode(), i.getSessionId());
                set(offlineKey, i);
                this.redisTemplate.delete(key);
            });
        }
    }

    @Nullable
    private String decodeWsToken(String rawToken) {
        return rawToken == null ? null : Base64.decodeStr(rawToken);
    }

    private String encodeWsToken(String sessionId, String unitCode) {
        return Base64.encode(sessionId + "," + unitCode);
    }

    @Override
    public Integer getUnitOnlineUsers(String uniqCode) {
        Set<String> keys = this.redisTemplate.keys(Constant.ILIS_LOGIN_ONLINE_PREFIX + uniqCode + ".*");
        return Optional.ofNullable(keys).orElse(Collections.emptySet()).size();
    }

    @Override
    public IPage<LoginInfo> getLogsViaUnitCode(String unitCode, Page<LoginInfo> page) {
        return baseMapper.selectPage(page, Wrappers.lambdaQuery(LoginInfo.class)
                .eq(LoginInfo::getUnitCode, unitCode)
                .orderByDesc(LoginInfo::getOperationTime));
    }

    @Override
    public IPage<LoginInfo> getUnitOnlineAccounts(String unitCode, Page<LoginInfo> page) {
        Set<String> keys = this.redisTemplate.keys(Constant.ILIS_LOGIN_ONLINE_PREFIX + unitCode + ".*");
        List<Object> objects = sessionStorage().multiGet(Optional.ofNullable(keys).orElse(Collections.emptySet()));
        objects = Optional.ofNullable(objects).orElse(Collections.emptyList());
        List<LoginInfo> infos = objects
                .stream()
                .map(o -> (LoginInfo) o)
                .skip((page.getCurrent() - 1) * page.getSize())
                .limit(page.getSize())
                .collect(Collectors.toList());
        Page<LoginInfo> infoPage = new Page<>();
        infoPage.setRecords(infos);
        infoPage.setTotal(objects.size());
        return infoPage;
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
    public void updateStatus(String token) {
        String wsToken = decodeWsToken(token);
        if (StrUtil.isBlank(wsToken)) {
            return;
        }
        if (wsToken.contains(StringPool.COMMA)) {
            String[] split = wsToken.split(StringPool.COMMA);
            final String key = generateOnlineKey(split[1], split[0]);
            LoginInfo info = get(key);
            if (info == null) {
                String offlineKey = generateOfflineKey(split[1], split[0]);
                info = get(offlineKey);
            }
            if (info != null) {
                info.setOperationTime(LocalDateTime.now());
                set(key, info);
            }
        }
    }

    private void set(String key, LoginInfo loginInfo) {
        sessionStorage().set(key, loginInfo, 13, TimeUnit.HOURS);
    }

    @Nullable
    private LoginInfo get(String key) {
        Object obj = sessionStorage().get(key);
        return (LoginInfo) Optional.ofNullable(obj).orElse(null);
    }

    @PreDestroy
    public void inactiveAccounts() {
        log.info("Starting inactive accounts");
        Set<String> onlineKeys = this.redisTemplate.keys(Constant.ILIS_LOGIN_ONLINE_PREFIX + "*");
        Optional.ofNullable(onlineKeys)
                .ifPresent(keys -> {
                    for (String key : keys) {
                        final String newKey = Constant.ILIS_LOGIN_OFFLINE_PREFIX + key.substring(Constant.ILIS_LOGIN_ONLINE_PREFIX.length());
                        this.redisTemplate.rename(key, newKey);
                    }
                    log.info("Set {} accounts offline", keys.size());
                });
    }
}
