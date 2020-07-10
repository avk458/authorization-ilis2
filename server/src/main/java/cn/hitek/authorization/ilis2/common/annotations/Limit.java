package cn.hitek.authorization.ilis2.common.annotations;

import cn.hitek.authorization.ilis2.common.enums.LimitType;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * @author chenlm
 */
@Target(ElementType.METHOD)
@Retention(RetentionPolicy.RUNTIME)
public @interface Limit {

    /**
     * 用于描述接口功能
     * @return definition
     */
    String name() default "";

    /**
     * resource key
     * @return key
     */
    String key() default "";

    /**
     * resource key prefix
     * @return prefix
     */
    String prefix() default "";

    /**
     * 持续时间 /秒
     * @return sec
     */
    int period();

    /**
     * 限制次数
     * @return 次数
     */
    int count();

    LimitType limitType() default LimitType.CUSTOMER;
}
