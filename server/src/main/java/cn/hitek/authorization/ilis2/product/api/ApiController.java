package cn.hitek.authorization.ilis2.product.api;

import cn.hitek.authorization.ilis2.common.annotations.Limit;
import cn.hitek.authorization.ilis2.common.constants.RequestConstants;
import cn.hitek.authorization.ilis2.common.enums.HttpStatus;
import cn.hitek.authorization.ilis2.common.response.Response;
import cn.hitek.authorization.ilis2.product.api.vo.Feedback;
import cn.hitek.authorization.ilis2.product.data.script.domain.DataScript;
import cn.hitek.authorization.ilis2.product.data.script.service.DataScriptService;
import cn.hitek.authorization.ilis2.product.database.service.UnitDatabaseService;
import cn.hitek.authorization.ilis2.product.unit.domain.LoginInfo;
import cn.hitek.authorization.ilis2.product.unit.domain.Unit;
import cn.hitek.authorization.ilis2.product.unit.service.UnitService;
import lombok.AllArgsConstructor;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.validation.constraints.NotBlank;
import java.util.List;
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

    @Limit(name = "单位用户登录", key = "clientLogin", prefix = "limit", period = 60, count = 10)
    @GetMapping("/unit/info")
    public String getUnitInfo(HttpServletRequest req, @RequestParam @NotBlank(message = RequestConstants.PARAM_ERROR) String code) {
        String host = req.getHeader("host");
        String remoteAddr = req.getRemoteAddr();
        String remoteHost = req.getRemoteHost();
        return this.unitService.getUnitInfo(code);
    }

    @PostMapping("/login/log")
    public void logUserLogin(@RequestBody LoginInfo loginInfo) {
        this.unitService.logUserLogin(loginInfo);
    }

    @Limit(name = "获取数据库数据版本", key = "dataVersion", prefix = "limit", period = 60, count = 20)
    @GetMapping("/data/version")
    public Long getDatabaseVersionAndScriptVersion(@RequestParam @NotBlank(message = RequestConstants.PARAM_ERROR)String code) {
        Unit unit = this.unitService.query().eq(Unit::getUniqCode, code).getOne();
        Objects.requireNonNull(unit, "未获取到对应单位信息");
        return this.dataScriptService.getLastDataScriptId();
    }

    @Limit(name = "获取数据库数据脚本", key = "dataScript", prefix = "limit", period = 60, count = 20)
    @GetMapping("/data/script/{startVer}/{updateVer}")
    public Response getDataScriptRange(@RequestParam @NotBlank(message = RequestConstants.PARAM_ERROR)String code,
                                       @PathVariable Long startVer,
                                       @PathVariable Long updateVer) {
        Unit unit = this.unitService.query().eq(Unit::getUniqCode, code).getOne();
        Objects.requireNonNull(unit, "未获取到对应单位信息");
        List<DataScript> scripts = this.dataScriptService.getScriptRange(startVer, updateVer);
        return new Response().code(HttpStatus.OK).data(scripts);
    }

    @PostMapping("/update/feedback")
    public void updateFeedback(@RequestBody Feedback feedback) {
        Unit unit = this.unitService.query().eq(Unit::getUniqCode, feedback.getCode()).getOne();
        this.databaseService.updateDatabaseDataVersion(unit.getId(), feedback.getVersion());
    }

    @GetMapping("/online-status/{sessionId}")
    public boolean getSessionOnlineStatus(@PathVariable String sessionId, String code) {
        return unitService.isUnitSessionOnline(sessionId, code);
    }
}
