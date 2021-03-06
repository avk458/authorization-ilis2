package cn.hitek.authorization.ilis2.product.data.management.controller;

import cn.hitek.authorization.ilis2.common.enums.HttpStatus;
import cn.hitek.authorization.ilis2.common.response.Response;
import cn.hitek.authorization.ilis2.product.data.management.domain.DatabaseInfo;
import cn.hitek.authorization.ilis2.product.data.management.service.DataManageService;
import cn.hitek.authorization.ilis2.product.database.domain.UnitDatabase;
import cn.hitek.authorization.ilis2.product.database.service.UnitDatabaseService;
import lombok.AllArgsConstructor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

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

    @GetMapping("/databases")
    public Response getUnitDatabases() {
        List<UnitDatabase> databaseList = this.unitDatabaseService.list();
        List<DatabaseInfo> list = this.dataManageService.getUnitDatabaseList(databaseList);
        return new Response().code(HttpStatus.OK).data(list);
    }

    @PreAuthorize("hasAuthority('database:sync')")
    @PostMapping("/actions/sync-columns")
    public Response syncSchemasColumns(@NotBlank(message = "配置参数有误") String mainProfileId,
                                       @NotBlank(message = "配置参数有误") String targetProfileId,
                                       @NotBlank(message = "Source Schema不能为空") String sourceSchema,
                                       @NotBlank(message = "Target Schemas不能为空") String targetSchemas) {
        this.dataManageService.sync(mainProfileId, targetProfileId, sourceSchema, targetSchemas);
        return new Response().code(HttpStatus.OK);
    }
}
