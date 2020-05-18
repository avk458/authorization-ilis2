package cn.hitek.authorization.ilis2.product.data.management.controller;

import cn.hitek.authorization.ilis2.common.enums.HttpStatus;
import cn.hitek.authorization.ilis2.common.response.Response;
import cn.hitek.authorization.ilis2.product.data.management.domain.DatabaseInfo;
import cn.hitek.authorization.ilis2.product.data.management.service.DataManageService;
import cn.hitek.authorization.ilis2.product.database.domain.UnitDatabase;
import cn.hitek.authorization.ilis2.product.database.service.UnitDatabaseService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;


/**
 * @author chenlm
 */
@RestController
@RequestMapping("data-manage")
public class DataManageController {

    private final DataManageService dataManageService;
    private final UnitDatabaseService unitDatabaseService;

    public DataManageController(DataManageService dataManageService, UnitDatabaseService unitDatabaseService) {
        this.dataManageService = dataManageService;
        this.unitDatabaseService = unitDatabaseService;
    }

    @GetMapping("database/list")
    public Response getUnitDatabaseInfoList() {
        List<UnitDatabase> databaseList = this.unitDatabaseService.list();
        List<DatabaseInfo> list = this.dataManageService.getUnitDatabaseList(databaseList);
        return new Response().code(HttpStatus.OK).data(list);
    }
}
