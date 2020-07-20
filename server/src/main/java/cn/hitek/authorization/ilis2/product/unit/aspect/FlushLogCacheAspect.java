package cn.hitek.authorization.ilis2.product.unit.aspect;

import cn.hitek.authorization.ilis2.product.unit.service.UnitUserLogger;
import lombok.RequiredArgsConstructor;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.stereotype.Component;

/**
 * @author chenlm
 */
@Aspect
@Component
@RequiredArgsConstructor
public class FlushLogCacheAspect {

    private final UnitUserLogger unitUserLogger;

    @Pointcut("@annotation(cn.hitek.authorization.ilis2.common.annotations.FlushLogs)")
    public void pointcut() {

    }

    @Before("pointcut()")
    public void flushLogIfPresent() {
        this.unitUserLogger.flushLogIfPresent();
    }
}
