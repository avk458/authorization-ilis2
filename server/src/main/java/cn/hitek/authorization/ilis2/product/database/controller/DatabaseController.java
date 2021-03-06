package cn.hitek.authorization.ilis2.product.database.controller;

import cn.hitek.authorization.ilis2.common.constants.RequestConstants;
import cn.hitek.authorization.ilis2.common.enums.HttpStatus;
import cn.hitek.authorization.ilis2.common.response.Response;
import cn.hitek.authorization.ilis2.common.validation.group.OnCreate;
import cn.hitek.authorization.ilis2.common.validation.group.OnUpdate;
import cn.hitek.authorization.ilis2.product.database.domain.UnitDatabase;
import cn.hitek.authorization.ilis2.product.database.domain.vo.UpdateEchoLog;
import cn.hitek.authorization.ilis2.product.database.service.UnitDatabaseService;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.springframework.security.access.prepost.PreAuthorize;
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
    public IPage<UnitDatabase> getDatabaseList(Page<UnitDatabase> page) {
        return this.databaseService.getPageRecords(page);
    }

    @PreAuthorize("hasAuthority('database:add')")
    @PostMapping
    public Response insertUnitDatabase(@Validated(OnCreate.class) @RequestBody UnitDatabase database) {
        this.databaseService.save(database);
        return new Response().code(HttpStatus.ADD);
    }

    @PreAuthorize("hasAuthority('database:update')")
    @PutMapping
    public Response updateUnitDatabase(@Validated(OnUpdate.class)
                                       @RequestBody UnitDatabase database) {
        this.databaseService.updateById(database);
        return new Response().code(HttpStatus.UPDATE);
    }

    @PreAuthorize("hasAuthority('database:del')")
    @DeleteMapping("/{unitDatabaseId}")
    public Response deleteUnitDatabase(@NotBlank(message = RequestConstants.PARAM_ERROR)
                                       @PathVariable String unitDatabaseId) {
        this.databaseService.removeById(unitDatabaseId);
        return new Response().code(HttpStatus.DELETE);
    }

    @PreAuthorize("hasAuthority('database:init')")
    @PostMapping("/init/{unitDatabaseId}")
    public Response initUnitDatabase(@NotBlank(message = RequestConstants.PARAM_ERROR)
                                     @PathVariable String unitDatabaseId) {
        this.databaseService.initUnitDatabase(unitDatabaseId);
        return new Response().code(HttpStatus.OK);
    }

    @PreAuthorize("hasAuthority('database:active')")
    @GetMapping("/initialization/status/{unitId}")
    public Response isUnitDatabaseInitialized(@NotBlank(message = RequestConstants.PARAM_ERROR)
                                              @PathVariable String unitId) {
        boolean initialized = this.databaseService.isUnitDatabaseInitialized(unitId);
        return new Response().code(HttpStatus.OK).data(initialized);
    }

    @PostMapping("/actions/validate-schema-name")
    public Response isDatabaseNameIllegally(@NotBlank(message = RequestConstants.PARAM_ERROR) String name) {
        boolean isIllegal = this.databaseService.isDatabaseNameIllegally(name);
        return new Response().code(HttpStatus.OK).data(isIllegal);
    }

    @PreAuthorize("hasAuthority('database:update')")
    @PostMapping("/actions/update/{id}/{updateVersion}")
    public Response updateDatabase(@PathVariable String id, @PathVariable Long updateVersion) {
        List<UpdateEchoLog> results = this.databaseService.updateDatabase(id, updateVersion);
        return new Response().code(HttpStatus.OK).data(results);
    }

    @PostMapping("/actions/batch-update")
    public Response batchUpdateDatabase() {
        List<UpdateEchoLog> logs = this.databaseService.batchUpdateDatabase();
        return new Response().code(HttpStatus.OK).code(HttpStatus.UPDATE).data(logs);
    }
}
