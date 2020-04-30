package cn.hitek.authorization.ilis2.product.database.controller;

import cn.hitek.authorization.ilis2.common.constants.RequestConstants;
import cn.hitek.authorization.ilis2.common.enums.HttpStatus;
import cn.hitek.authorization.ilis2.common.response.Response;
import cn.hitek.authorization.ilis2.common.validation.group.OnUpdate;
import cn.hitek.authorization.ilis2.product.database.domain.UnitDatabase;
import cn.hitek.authorization.ilis2.product.database.service.UnitDatabaseService;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.validation.constraints.NotBlank;
import java.util.List;

/**
 * @author chenlm
 */
@Validated
@RestController
@RequestMapping("database")
public class DatabaseController {

    private final UnitDatabaseService databaseService;

    public DatabaseController(UnitDatabaseService databaseService) {
        this.databaseService = databaseService;
    }

    @GetMapping("/list")
    public Response getDatabaseList() {
        List<UnitDatabase> list = this.databaseService.list();
        return new Response().code(HttpStatus.OK).data(list);
    }

    @PostMapping("/info")
    public Response insertUnitDatabase(@Validated @RequestBody UnitDatabase database) {
        this.databaseService.save(database);
        return new Response().code(HttpStatus.ADD);
    }

    @PutMapping("/info")
    public Response updateUnitDatabase(@Validated(OnUpdate.class)
                                       @RequestBody UnitDatabase database) {
        this.databaseService.updateById(database);
        return new Response().code(HttpStatus.UPDATE);
    }

    @DeleteMapping("/{unitDatabaseId}")
    public Response deleteUnitDatabase(@NotBlank(message = RequestConstants.PARAM_ERROR)
                                       @PathVariable String unitDatabaseId) {
        this.databaseService.removeById(unitDatabaseId);
        return new Response().code(HttpStatus.DELETE);
    }

    @PostMapping("/init/{unitDatabaseId}")
    public Response initUnitDatabase(@NotBlank(message = RequestConstants.PARAM_ERROR)
                                     @PathVariable String unitDatabaseId) {
        this.databaseService.initUnitDatabase(unitDatabaseId);
        return new Response().code(HttpStatus.OK);
    }

    @GetMapping("/initialized/{unitId}")
    public Response isUnitDatabaseInitialized(@NotBlank(message = RequestConstants.PARAM_ERROR)
                                              @PathVariable String unitId) {
        boolean initialized = this.databaseService.isUnitDatabaseInitialized(unitId);
        return new Response().code(HttpStatus.OK).data(initialized);
    }

    @GetMapping("/name-illegally")
    public Response isDatabaseNameIllegally(@NotBlank(message = RequestConstants.PARAM_ERROR) String name) {
        boolean isIllegal = this.databaseService.isDatabaseNameIllegally(name);
        return new Response().code(HttpStatus.OK).data(isIllegal);
    }
}
