package cn.hitek.authorization.ilis2.product.data.management.controller;

import cn.hitek.authorization.ilis2.common.enums.HttpStatus;
import cn.hitek.authorization.ilis2.common.response.Response;
import cn.hitek.authorization.ilis2.product.configuration.service.ConfigService;
import cn.hitek.authorization.ilis2.product.data.management.domain.DataScript;
import cn.hitek.authorization.ilis2.product.data.management.domain.DatabaseInfo;
import cn.hitek.authorization.ilis2.product.data.management.service.DataManageService;
import cn.hitek.authorization.ilis2.product.database.domain.UnitDatabase;
import cn.hitek.authorization.ilis2.product.database.service.UnitDatabaseService;
import lombok.AllArgsConstructor;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import javax.validation.constraints.NotBlank;
import java.util.List;


/**
 * @author chenlm
 */
@Validated
@RestController
@RequestMapping("data-manage")
@AllArgsConstructor
public class DataManageController {

    private final DataManageService dataManageService;
    private final UnitDatabaseService unitDatabaseService;
    private final ConfigService configService;

    @GetMapping("/database/list")
    public Response getUnitDatabaseInfoList() {
        List<UnitDatabase> databaseList = this.unitDatabaseService.list();
        List<DatabaseInfo> list = this.dataManageService.getUnitDatabaseList(databaseList);
        return new Response().code(HttpStatus.OK).data(list);
    }

    @PostMapping("/actions/sync-columns")
    public Response syncSchemasColumns(@NotBlank(message = "配置参数有误") String mainProfileId,
                                       @NotBlank(message = "配置参数有误") String targetProfileId,
                                       @NotBlank(message = "Source Schema不能为空") String sourceSchema,
                                       @NotBlank(message = "Target Schemas不能为空") String targetSchemas) {
        this.dataManageService.sync(mainProfileId, targetProfileId, sourceSchema, targetSchemas);
        return new Response().code(HttpStatus.OK);
    }

    @PostMapping("/data/script")
    public Response insertDataScript(@Valid @RequestBody DataScript script) {
        this.dataManageService.insertDataScript(script);
        return new Response().code(HttpStatus.ADD);
    }
}
