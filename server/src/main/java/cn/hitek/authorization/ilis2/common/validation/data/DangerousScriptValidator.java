package cn.hitek.authorization.ilis2.common.validation.data;

import com.baomidou.mybatisplus.core.toolkit.StringPool;

import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;
import java.util.Arrays;
import java.util.List;

/**
 * 简单过滤一下不带条件的 UPDATE DELETE 和 DROP TRUNCATE TABLE
 * @author chenlm
 */
public class DangerousScriptValidator implements ConstraintValidator<NormalScript, String> {

    private final List<String> rejectStatements = Arrays.asList("DROP", "TRUNCATE");
    private final List<String> validateStatements = Arrays.asList("UPDATE", "DELETE");

    @Override
    public boolean isValid(String value, ConstraintValidatorContext context) {
        String s = detectStatement(value);
        if (rejectStatements.contains(s)) {
            return false;
        } else if (validateStatements.contains(s)) {
            String condition = "FROM";
            return !value.contains(condition) && !value.contains(condition.toLowerCase());
        } else {
            return true;
        }
    }

    private String detectStatement(String script) {
        return script.substring(0, script.indexOf(StringPool.SPACE)).toUpperCase();
    }
}
