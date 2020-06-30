package cn.hitek.authorization.ilis2.product.api;

import cn.hitek.authorization.ilis2.common.constants.RequestConstants;
import cn.hitek.authorization.ilis2.common.enums.HttpStatus;
import cn.hitek.authorization.ilis2.common.response.Response;
import cn.hitek.authorization.ilis2.product.api.vo.Feedback;
import cn.hitek.authorization.ilis2.product.data.script.domain.DataScript;
import cn.hitek.authorization.ilis2.product.data.script.service.DataScriptService;
import cn.hitek.authorization.ilis2.product.database.domain.UnitDatabase;
import cn.hitek.authorization.ilis2.product.database.service.UnitDatabaseService;
import cn.hitek.authorization.ilis2.product.unit.domain.LoginInfo;
import cn.hitek.authorization.ilis2.product.unit.domain.Unit;
import cn.hitek.authorization.ilis2.product.unit.service.UnitService;
import lombok.AllArgsConstructor;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.validation.constraints.NotBlank;
import java.util.List;
import java.util.Map;
import java.util.Objects;

/**
 * @author chenlm
 */
@RequestMapping("auth")
@RestController
@AllArgsConstructor
@Validated
public class ApiController {

    private final UnitService unitService;
    private final UnitDatabaseService databaseService;
    private final DataScriptService dataScriptService;

    @GetMapping("/unit/info")
    public String getUnitInfo(@RequestParam @NotBlank(message = RequestConstants.PARAM_ERROR) String code) {
        return this.unitService.getUnitInfo(code);
    }

    @PostMapping("/login/log")
    public void logUserLogin(@RequestBody LoginInfo loginInfo) {
        this.unitService.logUserLogin(loginInfo);
    }

    @GetMapping("/data/version")
    public Response getDatabaseVersionAndScriptVersion(@RequestParam @NotBlank(message = RequestConstants.PARAM_ERROR)String code) {
        Unit unit = this.unitService.query().eq(Unit::getUniqCode, code).getOne();
        Objects.requireNonNull(unit, "未获取到对应单位信息");
        Map<String, String> result = this.databaseService.getDatabaseVersionAndScriptVersion(unit);
        return new Response().code(HttpStatus.OK).data(result);
    }

    @GetMapping("/data/script")
    public Response getDataScriptRange(@RequestParam @NotBlank(message = RequestConstants.PARAM_ERROR)String code) {
        Unit unit = this.unitService.query().eq(Unit::getUniqCode, code).getOne();
        Objects.requireNonNull(unit, "未获取到对应单位信息");
        UnitDatabase database = this.databaseService.query().eq(UnitDatabase::getUnitId, unit.getId()).getOne();
        List<DataScript> scripts = this.dataScriptService.getScriptRange(database.getDataVersion());
        return new Response().code(HttpStatus.OK).data(scripts);
    }

    @PostMapping("/update/feedback")
    public void updateFeedback(@RequestBody Feedback feedback) {
        Unit unit = this.unitService.query().eq(Unit::getUniqCode, feedback.getCode()).getOne();
        this.databaseService.updateDatabaseDataVersion(unit.getId(), feedback.getVersion());
    }
}