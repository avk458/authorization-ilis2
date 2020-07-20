package cn.hitek.authorization.ilis2.product.unit.helper;

import cn.hitek.authorization.ilis2.common.constants.Constant;
import cn.hitek.authorization.ilis2.product.unit.domain.LoginInfo;
import org.springframework.data.redis.core.BoundHashOperations;
import org.springframework.data.redis.core.RedisTemplate;

import java.util.HashSet;
import java.util.Map;

/**
 * @author chenlm
 */
public class UnitOnlineBucket {

    public static void put(RedisTemplate<String, Object> redisTemplate, LoginInfo loginInfo) {
        final String bucketKey = Constant.ILIS_ONLINE_BUCKET_PREFIX + loginInfo.getUnitCode();
        BoundHashOperations<String, String, HashSet<LoginInfo>> bucket = redisTemplate.boundHashOps(bucketKey);
        int hour = loginInfo.getOperationTime().getHour();
        HashSet<LoginInfo> loginInfos = bucket.get(hour + "");
        if (loginInfos == null) {
            loginInfos = new HashSet<>();
        }
        loginInfos.add(loginInfo);
        bucket.put(loginInfo.getOperationTime().getHour() + "", loginInfos);
    }

    public static Map<String, HashSet<LoginInfo>> get(RedisTemplate<String, Object> redisTemplate, String key) {
        BoundHashOperations<String, String, HashSet<LoginInfo>> bucket = redisTemplate.boundHashOps(key);
        return bucket.entries();
    }
}
