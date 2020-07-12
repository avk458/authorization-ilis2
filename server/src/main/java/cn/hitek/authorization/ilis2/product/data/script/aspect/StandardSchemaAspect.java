package cn.hitek.authorization.ilis2.product.data.script.aspect;


import cn.hitek.authorization.ilis2.product.data.script.service.DataScriptService;
import cn.hitek.authorization.ilis2.product.database.service.UnitDatabaseService;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.stereotype.Component;

/**
 * @author kano
 */
@Log4j2
@Aspect
@Component
@RequiredArgsConstructor
public class StandardSchemaAspect {

    private final UnitDatabaseService unitDatabaseService;
    private final DataScriptService scriptService;
    private Long dataVersion;

    @Pointcut("execution(public * cn.hitek.authorization.ilis2.product.data.script.controller.DataScriptController.uploadDataScript(..))")
    public void pointcut() {

    }

    @Before("pointcut()")
    public void before() {
        this.dataVersion = this.scriptService.getLastDataScriptId();
        log.info("获取到当前数据版本为：{}", dataVersion);
    }

    @AfterReturning("pointcut()")
    public void after() {
        dataVersion = dataVersion == null ? 0L : dataVersion;
        this.unitDatabaseService.updateStandardSchema(dataVersion);
        log.info("导入完毕！开始执行标准库升级");
    }
}
