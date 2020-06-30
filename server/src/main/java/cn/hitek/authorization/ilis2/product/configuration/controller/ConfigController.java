package cn.hitek.authorization.ilis2.product.configuration.controller;

import cn.hitek.authorization.ilis2.common.enums.HttpStatus;
import cn.hitek.authorization.ilis2.common.response.Response;
import cn.hitek.authorization.ilis2.common.utils.EncryptUtil;
import cn.hitek.authorization.ilis2.common.validation.group.OnCreate;
import cn.hitek.authorization.ilis2.common.validation.group.OnUpdate;
import cn.hitek.authorization.ilis2.product.configuration.domain.MainSourceProfile;
import cn.hitek.authorization.ilis2.product.configuration.domain.TargetSourceProfile;
import cn.hitek.authorization.ilis2.product.configuration.domain.vo.Folder;
import cn.hitek.authorization.ilis2.product.configuration.service.ConfigService;
import cn.hitek.authorization.ilis2.product.data.management.domain.Schema;
import cn.hutool.core.util.StrUtil;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.validation.constraints.NotBlank;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

/**
 * @author chenlm
 */
@RestController
@RequestMapping("config")
public class ConfigController {

    private final ConfigService configService;

    public ConfigController(ConfigService configService) {
        this.configService = configService;
    }

    @GetMapping("/file/path")
    public Response getSystemFilePath(String path) {
        List<Folder> systemFilePath = this.configService.getSystemFilePath(path);
        return new Response().code(HttpStatus.OK).data(systemFilePath);
    }

    @GetMapping("/tables")
    public Response getTableListFormDatabase(MainSourceProfile config) throws SQLException {
        if (StrUtil.isNotBlank(config.getId())) {
            config = this.configService.getById(config.getId());
        } else {
            config.setPassword(EncryptUtil.encrypt(config.getPassword()));
        }
        List<Map<String, String>> list = this.configService.getTableList(config);
        return new Response().code(HttpStatus.OK).data(list);
    }

    @PreAuthorize("hasAuthority('profile:main:add')")
    @PostMapping("/main/profile")
    public Response insertMainProfile(@Validated(OnCreate.class) @RequestBody MainSourceProfile profile) {
        this.configService.saveMainProfile(profile);
        return new Response().code(HttpStatus.ADD);
    }

    @GetMapping("/main/profiles")
    public Response getMainProfiles() {
        List<MainSourceProfile> list = this.configService.list();
        return new Response().code(HttpStatus.OK).data(list);
    }

    @PreAuthorize("hasAuthority('profile:main:active')")
    @PutMapping("/actions/active/{profileId}")
    public Response activeMainProfile(@PathVariable String profileId) {
        this.configService.activeProfile(profileId);
        return new Response().code(HttpStatus.OK);
    }

    @PreAuthorize("hasAuthority('profile:main:del')")
    @DeleteMapping("/main/{profileId}")
    public Response deleteConfigInfo(@PathVariable String profileId) {
        this.configService.removeById(profileId);
        return new Response().code(HttpStatus.DELETE);
    }

    @PreAuthorize("hasAuthority('profile:main:update')")
    @PutMapping("/main/profile")
    public Response updateMainProfile(@Validated(OnUpdate.class) @RequestBody MainSourceProfile profile) {
        this.configService.updateById(profile);
        return new Response().code(HttpStatus.UPDATE);
    }

    @GetMapping("/connection/databases")
    public Response getDatabases(MainSourceProfile config) {
        config.setPassword(EncryptUtil.encrypt(config.getPassword()));
        List<Map<String, String>> databases = this.configService.getDatabases(config);
        return new Response().code(HttpStatus.OK).data(databases);
    }

    @GetMapping("/target/profiles")
    public Response getTargetProfiles() {
        List<TargetSourceProfile> list = this.configService.getTargetProfiles();
        return new Response().code(HttpStatus.OK).data(list);
    }

    @PreAuthorize("hasAuthority('profile:target:add')")
    @PostMapping("/target/profile")
    public Response insertTargetProfile(@Validated(OnCreate.class) @RequestBody TargetSourceProfile targetProfile) {
        this.configService.insertTargetProfile(targetProfile);
        return new Response().code(HttpStatus.ADD);
    }

    @PreAuthorize("hasAuthority('profile:target:update')")
    @PutMapping("/target/profile")
    public Response updateTargetProfile(@Validated(OnUpdate.class) @RequestBody TargetSourceProfile targetProfile) {
        this.configService.updateTargetProfile(targetProfile);
        return new Response().code(HttpStatus.UPDATE);
    }

    @PreAuthorize("hasAuthority('profile:target:del')")
    @DeleteMapping("/target/{profileId}")
    public Response deleteTargetProfile(@PathVariable String profileId) {
        this.configService.deleteTargetProfile(profileId);
        return new Response().code(HttpStatus.DELETE);
    }

    @PostMapping("/target/actions/valid-connection")
    public Response validateTargetSourceConnection(@RequestBody TargetSourceProfile profile) {
        boolean connected = this.configService.validateConnection(profile);
        return new Response().code(HttpStatus.OK).data(connected);
    }

    @GetMapping("/main-source/schemas")
    public Response getMainSourceSchemas(@NotBlank(message = "请求参数有误") String mainProfileId) {
        List<Schema> schemas = this.configService.getMainSourceSchemas(mainProfileId);
        return new Response().code(HttpStatus.OK).data(schemas);
    }

    @GetMapping("/target-source/schemas")
    public Response getTargetSourceSchemas(@NotBlank(message = "请求参数有误") String targetProfileId) {
        List<Schema> schemas = this.configService.getTargetSourceSchemas(targetProfileId);
        return new Response().code(HttpStatus.OK).data(schemas);
    }
}
