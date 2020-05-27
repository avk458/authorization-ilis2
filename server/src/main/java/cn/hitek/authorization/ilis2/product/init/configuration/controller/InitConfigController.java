package cn.hitek.authorization.ilis2.product.init.configuration.controller;

import cn.hitek.authorization.ilis2.common.enums.HttpStatus;
import cn.hitek.authorization.ilis2.common.response.Response;
import cn.hitek.authorization.ilis2.common.utils.EncryptUtils;
import cn.hitek.authorization.ilis2.common.validation.group.OnCreate;
import cn.hitek.authorization.ilis2.common.validation.group.OnUpdate;
import cn.hitek.authorization.ilis2.product.init.configuration.domain.InitialConfig;
import cn.hitek.authorization.ilis2.product.init.configuration.domain.vo.Folder;
import cn.hitek.authorization.ilis2.product.init.configuration.service.InitialConfigService;
import cn.hutool.core.util.StrUtil;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

/**
 * @author chenlm
 */
@RestController
@RequestMapping("init/config")
public class InitConfigController {

    private final InitialConfigService configService;

    public InitConfigController(InitialConfigService configService) {
        this.configService = configService;
    }

    @GetMapping("/file/path")
    public Response getSystemFilePath(String path) {
        List<Folder> systemFilePath = this.configService.getSystemFilePath(path);
        return new Response().code(HttpStatus.OK).data(systemFilePath);
    }

    @GetMapping("/table/list")
    public Response getTableListFormDatabase(InitialConfig config) throws SQLException {
        if (StrUtil.isNotBlank(config.getId())) {
            config = this.configService.getById(config.getId());
        } else {
            config.setPassword(EncryptUtils.encrypt(config.getPassword()));
        }
        List<Map<String, String>> list = this.configService.getTableList(config);
        return new Response().code(HttpStatus.OK).data(list);
    }

    @PostMapping("/info")
    public Response insertInitConfig(@Validated(OnCreate.class) @RequestBody InitialConfig config) {
        this.configService.saveInitialConfig(config);
        return new Response().code(HttpStatus.ADD);
    }

    @GetMapping("/list")
    public Response getInitConfigList() {
        List<InitialConfig> list = this.configService.list();
        return new Response().code(HttpStatus.OK).data(list);
    }

    @PutMapping("/active/{configId}")
    public Response activeChooseConfig(@PathVariable String configId) {
        this.configService.activeConfig(configId);
        return new Response().code(HttpStatus.OK);
    }

    @DeleteMapping("/{configId}")
    public Response deleteConfigInfo(@PathVariable String configId) {
        this.configService.removeById(configId);
        return new Response().code(HttpStatus.DELETE);
    }

    @PutMapping("/info")
    public Response updateConfigInfo(@Validated(OnUpdate.class) @RequestBody InitialConfig config) {
        this.configService.updateById(config);
        return new Response().code(HttpStatus.UPDATE);
    }
}
