package cn.hitek.authorization.ilis2.product.data.script.controller;

import cn.hitek.authorization.ilis2.common.enums.HttpStatus;
import cn.hitek.authorization.ilis2.common.response.Response;
import cn.hitek.authorization.ilis2.product.data.script.domain.DataScript;
import cn.hitek.authorization.ilis2.product.data.script.service.DataScriptService;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import lombok.AllArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.validation.Valid;

/**
 * @author chenlm
 */
@Validated
@RestController
@RequestMapping("/script")
@AllArgsConstructor
public class DataScriptController {

    private final DataScriptService dataScriptService;

    @PreAuthorize("hasAuthority('script:add')")
    @PostMapping
    public Response insertDataScript(@Valid @RequestBody DataScript script) {
        this.dataScriptService.save(script);
        return new Response().code(HttpStatus.ADD);
    }

    @PreAuthorize("hasAuthority('script:update')")
    @PutMapping
    public Response updateDataScript(@Valid @RequestBody DataScript script) {
        this.dataScriptService.updateById(script);
        return new Response().code(HttpStatus.UPDATE);
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
        String ver = this.dataScriptService.getLastDataScriptId();
        return new Response().code(HttpStatus.OK).data(ver);
    }

    @PreAuthorize("hasAuthority('script:upload')")
    @PostMapping("/file")
    public Response uploadDataScript(@RequestParam("file") MultipartFile multipartFile) {
        this.dataScriptService.importScriptFile(multipartFile);
        return new Response().code(HttpStatus.OK);
    }
}
