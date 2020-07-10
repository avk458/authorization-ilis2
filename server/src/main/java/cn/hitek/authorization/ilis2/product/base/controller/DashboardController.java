package cn.hitek.authorization.ilis2.product.base.controller;

import cn.hitek.authorization.ilis2.common.constants.Constant;
import cn.hitek.authorization.ilis2.common.enums.HttpStatus;
import cn.hitek.authorization.ilis2.common.response.Response;
import cn.hitek.authorization.ilis2.product.base.helper.DashboardGenerateTool;
import cn.hitek.authorization.ilis2.product.data.script.service.DataScriptService;
import cn.hitek.authorization.ilis2.product.unit.service.UnitService;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Map;

/**
 * @author chenlm
 */
@RestController
@RequestMapping("dashboard")
@AllArgsConstructor
public class DashboardController {

    private final DataScriptService scriptService;
    private final UnitService unitService;

    @GetMapping("/info-cards")
    public Response getInfoCardsData() {
        Long lastDataScriptId = this.scriptService.getLastDataScriptId();
        Long totalUsers = this.unitService.combineUnitUsers(Constant.ILIS_LOGIN_TOTAL_PREFIX);
        Long onlineUsers = this.unitService.combineUnitUsers(Constant.ILIS_LOGIN_ONLINE_PREFIX);
        List<Map<String, Object>> cardsData = DashboardGenerateTool.generateInfoCardsData(lastDataScriptId, totalUsers, onlineUsers);
        return new Response().code(HttpStatus.OK).data(cardsData);
    }

    @GetMapping("/pie-data")
    public Response getUnitUserPie() {
        List<Map<String, Object>> pieData = this.unitService.getUnitUserPie();
        return new Response().code(HttpStatus.OK).data(pieData);
    }

    @GetMapping("/week-online")
    public Response getWeekOnlineStatisticData() {
        Map<String, Integer> data = this.unitService.getWeekOnlineStatisticData();
        return new Response().code(HttpStatus.OK).data(data);
    }

    @GetMapping("/current-online")
    public Response getCurrentOnlineData() {
        Map<String, int[]> data = this.unitService.getCurrentOnlineData();
        return new Response().code(HttpStatus.OK).data(data);
    }
}
