package cn.hitek.authorization.ilis2.product.unit.controller;

import cn.hitek.authorization.ilis2.common.constants.RequestConstants;
import cn.hitek.authorization.ilis2.common.enums.HttpStatus;
import cn.hitek.authorization.ilis2.common.response.Response;
import cn.hitek.authorization.ilis2.common.validation.group.OnUpdate;
import cn.hitek.authorization.ilis2.product.unit.domain.Unit;
import cn.hitek.authorization.ilis2.product.unit.service.UnitService;
import com.baomidou.mybatisplus.annotation.FieldFill;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
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
public class UnitController {

    private final UnitService unitService;

    public UnitController(UnitService unitService) {
        this.unitService = unitService;
    }

    @GetMapping("/list")
    public Response getUnitList() {
        List<Unit> list = this.unitService
                .list(Wrappers.lambdaQuery(Unit.class).select(i -> i.getFieldFill().equals(FieldFill.DEFAULT)));
        return new Response().code(HttpStatus.OK).data(list);
    }

    @PostMapping("/info")
    public Response createUnit(@RequestBody Unit unit) {
        this.unitService.save(unit);
        return new Response().code(HttpStatus.ADD);
    }

    @PutMapping("/info")
    public Response updateUnit(@Validated(OnUpdate.class) @RequestBody Unit unit) {
        this.unitService.updateById(unit);
        return new Response().code(HttpStatus.UPDATE);
    }

    @DeleteMapping("/{unitId}")
    public Response deleteUnit(@PathVariable String unitId) {
        this.unitService.removeUnitInfoAndDatabaseInfoViaUnitId(unitId);
        return new Response().code(HttpStatus.DELETE);
    }

    @GetMapping("/validate/code")
    public Response validateUniqCode(@NotBlank(message = RequestConstants.PARAM_ERROR) String code) {
        boolean exists = this.unitService.validateCode(code);
        return new Response().code(HttpStatus.OK).data(exists);
    }
}
