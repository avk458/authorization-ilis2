package cn.hitek.authorization.ilis2.product.unit.controller;

import cn.hitek.authorization.ilis2.common.annotations.FlushLogs;
import cn.hitek.authorization.ilis2.common.constants.RequestConstants;
import cn.hitek.authorization.ilis2.common.enums.HttpStatus;
import cn.hitek.authorization.ilis2.common.response.Response;
import cn.hitek.authorization.ilis2.common.validation.group.OnCreate;
import cn.hitek.authorization.ilis2.common.validation.group.OnUpdate;
import cn.hitek.authorization.ilis2.product.unit.domain.ClientAccount;
import cn.hitek.authorization.ilis2.product.unit.domain.LoginInfo;
import cn.hitek.authorization.ilis2.product.unit.domain.Unit;
import cn.hitek.authorization.ilis2.product.unit.domain.vo.UnitAccount;
import cn.hitek.authorization.ilis2.product.unit.service.UnitService;
import cn.hitek.authorization.ilis2.product.unit.service.UnitUserLogger;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import lombok.RequiredArgsConstructor;
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
@RequestMapping("/unit")
@RequiredArgsConstructor
public class UnitController {

    private final UnitService unitService;
    private final UnitUserLogger userLogger;

    @GetMapping("/list")
    public IPage<Unit> getUnitList(Page<Unit> page) {
        return this.unitService.getPageRecords(page);
    }

    @PreAuthorize("hasAuthority('unit:add')")
    @PostMapping
    public Response createUnit(@Validated(OnCreate.class) @RequestBody Unit unit) {
        String unitDatabaseId = this.unitService.insertUnitInfo(unit);
        return new Response().code(HttpStatus.ADD).data(unitDatabaseId);
    }

    @PreAuthorize("hasAuthority('unit:update')")
    @PutMapping
    public Response updateUnit(@Validated(OnUpdate.class) @RequestBody Unit unit) {
        this.unitService.updateById(unit);
        return new Response().code(HttpStatus.UPDATE);
    }

    @PreAuthorize("hasAuthority('unit:del')")
    @DeleteMapping("/{unitId}")
    public Response deleteUnit(@PathVariable String unitId) {
        this.unitService.removeUnitInfoAndDatabaseInfoViaUnitId(unitId);
        return new Response().code(HttpStatus.DELETE);
    }

    @PostMapping("/actions/validate-uniq-code")
    public Response validateUniqCode(@NotBlank(message = RequestConstants.PARAM_ERROR) String code) {
        boolean exists = this.unitService.validateCode(code);
        return new Response().code(HttpStatus.OK).data(exists);
    }

    @PostMapping("/actions/unit/login-policy")
    public Response updateUnitLoginPolicy(@NotBlank(message = RequestConstants.PARAM_ERROR) String unitId) {
        this.unitService.updateUnitLoginPolicy(unitId);
        return new Response().code(HttpStatus.UPDATE);
    }

    @GetMapping("/accounts")
    public Response getUnitAccountData() {
        List<UnitAccount> data = this.unitService.getUnitAccountData();
        return new Response().code(HttpStatus.OK).data(data);
    }

    @GetMapping("/{unitCode}/accounts")
    public Response getUnitTotalAccounts(@PathVariable String unitCode, Page<ClientAccount> page) {
        IPage<ClientAccount> accounts = this.userLogger.getClientAccounts(unitCode, page);
        return new Response().code(HttpStatus.OK).data(accounts);
    }

    @FlushLogs
    @GetMapping("/login/log/{unitCode}")
    public Response getUnitLoginLog(@PathVariable String unitCode, Page<LoginInfo> page) {
        IPage<LoginInfo> logs = this.userLogger.getUnitAccountLogs(unitCode, page);
        return new Response().code(HttpStatus.OK).data(logs);
    }

    @FlushLogs
    @GetMapping("/{unitCode}/{userId}/sessions")
    public Response getUnitOnlineAccounts(@PathVariable String unitCode,
                                          @PathVariable String userId,
                                          @NotBlank(message = RequestConstants.PARAM_ERROR) String sessionIds,
                                          Page<LoginInfo> page) {
        IPage<LoginInfo> sessionLogs = this.userLogger.getUnitOnlineAccounts(unitCode, userId, sessionIds, page);
        return new Response().code(HttpStatus.OK).data(sessionLogs);
    }

    @FlushLogs
    @GetMapping("/{unitCode}/{userId}/log")
    public Response getAccountLoginLog(@PathVariable String unitCode,
                                       @PathVariable String userId,
                                       Page<LoginInfo> page) {
        IPage<LoginInfo> logs = this.userLogger.getAccountLogs(unitCode, userId, page);
        return new Response().code(HttpStatus.OK).data(logs);
    }
}
