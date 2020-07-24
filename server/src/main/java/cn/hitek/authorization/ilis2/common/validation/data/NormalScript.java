package cn.hitek.authorization.ilis2.common.validation.data;

import javax.validation.Constraint;
import javax.validation.Payload;
import java.lang.annotation.Documented;
import java.lang.annotation.Retention;
import java.lang.annotation.Target;

import static java.lang.annotation.ElementType.*;
import static java.lang.annotation.ElementType.TYPE_USE;
import static java.lang.annotation.RetentionPolicy.RUNTIME;

/**
 * @author chenlm
 */
@Target({ METHOD, FIELD, ANNOTATION_TYPE, CONSTRUCTOR, PARAMETER, TYPE_USE })
@Retention(RUNTIME)
@Documented
@Constraint(validatedBy = DangerousScriptValidator.class)
public @interface NormalScript {

    String message() default "非法脚本，请检查修改后再次提交";

    Class<?>[] groups() default { };

    Class<? extends Payload>[] payload() default { };
}
