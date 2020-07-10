package cn.hitek.authorization.ilis2.common.aspect;

import cn.hitek.authorization.ilis2.common.annotations.Limit;
import cn.hitek.authorization.ilis2.common.enums.LimitType;
import cn.hitek.authorization.ilis2.common.exception.LimitAccessException;
import cn.hitek.authorization.ilis2.common.utils.IPUtil;
import cn.hutool.core.util.StrUtil;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.aspectj.lang.reflect.MethodSignature;
import org.springframework.context.annotation.Profile;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.script.DefaultRedisScript;
import org.springframework.data.redis.core.script.RedisScript;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import java.io.Serializable;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

/**
 * @author chenlm
 */
@Log4j2
@Aspect
@Component
@AllArgsConstructor
@Profile("prod")
public class LimitAspect {

    private final RedisTemplate<String, Serializable> redis;

    @Pointcut("@annotation(cn.hitek.authorization.ilis2.common.annotations.Limit)")
    public void pointcut() {

    }

    @Around("pointcut()")
    public Object around(ProceedingJoinPoint joinPoint) throws Throwable {
        HttpServletRequest request = ((ServletRequestAttributes) Objects
                .requireNonNull(RequestContextHolder.getRequestAttributes())).getRequest();
        MethodSignature signature = (MethodSignature) joinPoint.getSignature();
        Method method = signature.getMethod();
        Limit limitAnnotation = method.getAnnotation(Limit.class);
        String name = limitAnnotation.name();
        LimitType limitType = limitAnnotation.limitType();
        String key;
        String ip = IPUtil.getIpAddr(request);
        switch (limitType) {
            case IP:
                key = ip;
                break;
            case CUSTOMER:
                key = limitAnnotation.key();
                break;
            default:
                key = method.getName().toUpperCase();
        }
        List<String> keys = new ArrayList<>();
        keys.add(StrUtil.join(limitAnnotation.prefix() + "_", key, ip));
        String luaScript = buildLuaScript();
        RedisScript<Number> script = new DefaultRedisScript<>(luaScript, Number.class);
        int period = limitAnnotation.period();
        int limitCount = limitAnnotation.count();
        Number count = this.redis.execute(script, keys, limitCount, period);
        log.info("IP:{} 第 {} 次访问key为 {}，描述为[{}]的接口", ip, count, keys, name);
        if (count != null && count.intValue() <= limitCount) {
            return joinPoint.proceed();
        } else {
            throw new LimitAccessException("接口访问频率超出限制");
        }
    }

    private String buildLuaScript() {
        return "local c" +
                "\nc = redis.call('get',KEYS[1])" +
                "\nif c and tonumber(c) > tonumber(ARGV[1]) then" +
                "\nreturn c;" +
                "\nend" +
                "\nc = redis.call('incr',KEYS[1])" +
                "\nif tonumber(c) == 1 then" +
                "\nredis.call('expire',KEYS[1],ARGV[2])" +
                "\nend" +
                "\nreturn c;";
    }
}
