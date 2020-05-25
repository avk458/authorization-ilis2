package cn.hitek.authorization.ilis2.product.data.management.controller;

import cn.hitek.authorization.ilis2.common.enums.HttpStatus;
import cn.hitek.authorization.ilis2.common.response.Response;
import cn.hitek.authorization.ilis2.product.data.management.domain.DatabaseInfo;
import cn.hitek.authorization.ilis2.product.data.management.domain.Schema;
import cn.hitek.authorization.ilis2.product.data.management.service.DataManageService;
import cn.hitek.authorization.ilis2.product.database.domain.UnitDatabase;
import cn.hitek.authorization.ilis2.product.database.service.UnitDatabaseService;
import cn.hitek.authorization.ilis2.product.init.configuration.domain.InitialConfig;
import cn.hitek.authorization.ilis2.product.init.configuration.service.InitialConfigService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;


/**
 * @author chenlm
 */
@RestController
@RequestMapping("data-manage")
public class DataManageController {

    private final DataManageService dataManageService;
    private final UnitDatabaseService unitDatabaseService;
    private final InitialConfigService configService;

    public DataManageController(DataManageService dataManageService,
                                UnitDatabaseService unitDatabaseService,
                                InitialConfigService configService) {
        this.dataManageService = dataManageService;
        this.unitDatabaseService = unitDatabaseService;
        this.configService = configService;
    }

    @GetMapping("/database/list")
    public Response getUnitDatabaseInfoList() {
        List<UnitDatabase> databaseList = this.unitDatabaseService.list();
        List<DatabaseInfo> list = this.dataManageService.getUnitDatabaseList(databaseList);
        return new Response().code(HttpStatus.OK).data(list);
    }


    @GetMapping("/schema/list")
    public Response getSourceSchemaList(String configId) throws SQLException {
        InitialConfig config = this.configService.getById(configId);
        Map<String, List<Schema>> result = this.dataManageService.getSourceSchemaList(config);
        return new Response().code(HttpStatus.OK).data(result);
    }
}