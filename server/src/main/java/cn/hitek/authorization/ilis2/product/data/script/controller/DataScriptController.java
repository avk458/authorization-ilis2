package cn.hitek.authorization.ilis2.product.data.script.controller;

import cn.hitek.authorization.ilis2.common.constants.RequestConstants;
import cn.hitek.authorization.ilis2.common.enums.HttpStatus;
import cn.hitek.authorization.ilis2.common.response.Response;
import cn.hitek.authorization.ilis2.common.validation.group.OnCreate;
import cn.hitek.authorization.ilis2.common.validation.group.OnUpdate;
import cn.hitek.authorization.ilis2.product.data.script.domain.DataScript;
import cn.hitek.authorization.ilis2.product.data.script.service.DataScriptService;
import cn.hitek.authorization.ilis2.product.database.service.UnitDatabaseService;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import lombok.AllArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.validation.constraints.NotBlank;

/**
 * @author chenlm
 */
@Validated
@RestController
@RequestMapping("/script")
@AllArgsConstructor
public class DataScriptController {

    private final DataScriptService dataScriptService;
    private final UnitDatabaseService unitDatabaseService;

    @PreAuthorize("hasAuthority('script:add')")
    @PostMapping
    public Response insertDataScript(@Validated(OnCreate.class) @RequestBody DataScript script) {
        this.unitDatabaseService.insertScriptIfExecuted(script);
        return new Response().code(HttpStatus.ADD);
    }

    @PreAuthorize("hasAuthority('script:update')")
    @PutMapping
    public Response updateDataScript(@Validated(OnUpdate.class) @RequestBody DataScript script) {
        Response res = new Response();
        boolean executeSuccess = this.unitDatabaseService.executeInStandardSchemas(script);
        if (executeSuccess) {
            this.dataScriptService.updateById(script);
            res.code(HttpStatus.UPDATE);
        } else {
            res.code(HttpStatus.FAIL).message("脚本执行失败，请检查");
        }
        return res;
    }

    @PreAuthorize("hasAuthority('script:del')")
    @DeleteMapping("/{id}")
    public Response deleteDataScript(@PathVariable String id) {
        this.dataScriptService.removeById(id);
        return new Response().code(HttpStatus.DELETE);
    }

    @GetMapping("/list")
    public IPage<DataScript> getDataScripts(Page<DataScript> page) {
        return this.dataScriptService.selectPage(page);
    }

    @PreAuthorize("hasAuthority('script:export')")
    @GetMapping("/actions/export")
    public ResponseEntity<Object> exportScript() {
        return this.dataScriptService.exportScript();
    }

    @GetMapping("/last/version")
    public Response getLastVersion() {
        String ver = this.dataScriptService.getLastDataScriptVersion();
        return new Response().code(HttpStatus.OK).data(ver);
    }

    @PreAuthorize("hasAuthority('script:upload')")
    @PostMapping("/file")
    public Response uploadDataScript(@RequestParam("file") MultipartFile multipartFile) {
        this.dataScriptService.importScriptFile(multipartFile);
        return new Response().code(HttpStatus.OK);
    }

    @PostMapping("/actions/exchange")
    public Response changeScript(@NotBlank(message = RequestConstants.PARAM_ERROR) String id1,
                                 @NotBlank(message = RequestConstants.PARAM_ERROR) String id2) {
        this.dataScriptService.scriptExchange(id1, id2);
        return new Response().code(HttpStatus.UPDATE);
    }
}
