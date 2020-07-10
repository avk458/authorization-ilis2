package cn.hitek.authorization.ilis2.product.unit.service.impl;

import cn.hitek.authorization.ilis2.common.constants.Constant;
import cn.hitek.authorization.ilis2.common.utils.AddressUtil;
import cn.hitek.authorization.ilis2.framework.web.service.impl.BaseServiceImpl;
import cn.hitek.authorization.ilis2.product.unit.domain.LoginInfo;
import cn.hitek.authorization.ilis2.product.unit.mapper.LoginInfoMapper;
import cn.hitek.authorization.ilis2.product.unit.service.UnitUserLogger;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.StringPool;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import lombok.AllArgsConstructor;
import org.springframework.data.redis.core.BoundSetOperations;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.ValueOperations;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

import java.util.Set;
import java.util.concurrent.TimeUnit;

/**
 * @author chenlm
 */
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

    @Async
    @Override
    public void handleLoginLog(LoginInfo loginInfo) {
        String loginIp = loginInfo.getLoginIp();
        if (StrUtil.isNotBlank(loginIp)) {
            loginInfo.setLoginRegion(AddressUtil.getCityInfo(loginIp));
        }
        this.save(loginInfo);
    }

    @Async
    @Override
    public void handleLoginStatisticLog(LoginInfo loginInfo) {
        unitTotalClientStorage(loginInfo.getUnitCode()).add(loginInfo.getUserId());
        final String key = generateOnlineKey(loginInfo.getUnitCode(), loginInfo.getSessionId());
        if (loginInfo.getLogin()) {
            sessionStorage().set(key, loginInfo, 13, TimeUnit.HOURS);
        } else {
            this.redisTemplate.delete(key);
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
        if (StrUtil.isNotBlank(token) && token.contains(StringPool.COMMA)) {
            String[] split = token.split(StringPool.COMMA);
            final String offlineKey = generateOfflineKey(split[1], split[0]);
            Object obj = sessionStorage().get(offlineKey);
            if (obj instanceof LoginInfo) {
                LoginInfo info = (LoginInfo) obj;
                String key = generateOnlineKey(info.getUnitCode(), info.getSessionId());
                sessionStorage().set(key, info, 13, TimeUnit.HOURS);
                this.redisTemplate.delete(offlineKey);
            }
        }
    }

    @Override
    public void removeOnlineUser(String token) {
        if (StrUtil.isNotBlank(token) && token.contains(StringPool.COMMA)) {
            String[] split = token.split(StringPool.COMMA);
            final String key = generateOnlineKey(split[1], split[0]);
            Object obj = sessionStorage().get(key);
            if (obj instanceof LoginInfo) {
                LoginInfo info = (LoginInfo) obj;
                final String offlineKey = generateOfflineKey(info.getUnitCode(), info.getSessionId());
                sessionStorage().set(offlineKey, info, 13, TimeUnit.HOURS);
                this.redisTemplate.delete(key);
            }
        }
    }

    @Override
    public Integer getUnitOnlineUsers(String uniqCode) {
        Set<String> keys = this.redisTemplate.keys(Constant.ILIS_LOGIN_ONLINE_PREFIX + uniqCode + ".*");
        if (keys != null && !keys.isEmpty()) {
            return keys.size();
        } else {
            return 0;
        }
    }

    @Override
    public IPage<LoginInfo> getLogsViaUnitCode(String unitCode, Page<LoginInfo> page) {
        return baseMapper.selectPage(page, Wrappers.lambdaQuery(LoginInfo.class)
                .eq(LoginInfo::getUnitCode, unitCode)
                .orderByDesc(LoginInfo::getOperationTime));
    }
}
