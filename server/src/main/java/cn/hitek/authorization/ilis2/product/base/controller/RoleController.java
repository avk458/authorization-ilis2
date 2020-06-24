package cn.hitek.authorization.ilis2.product.base.controller;

import cn.hitek.authorization.ilis2.common.enums.HttpStatus;
import cn.hitek.authorization.ilis2.common.response.Response;
import cn.hitek.authorization.ilis2.common.validation.group.OnCreate;
import cn.hitek.authorization.ilis2.common.validation.group.OnUpdate;
import cn.hitek.authorization.ilis2.product.base.domain.Role;
import cn.hitek.authorization.ilis2.product.base.domain.vo.PostPermission;
import cn.hitek.authorization.ilis2.product.base.service.RoleService;
import lombok.AllArgsConstructor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import javax.validation.constraints.NotNull;
import java.util.List;

/**
 * @author chenlm
 */
@RestController
@RequestMapping("role")
@AllArgsConstructor
public class RoleController {

    private final RoleService roleService;


    @GetMapping("/list")
    public Response getRoles() {
        List<Role> roles = this.roleService.getRoleWithPermissions();
        return new Response().code(HttpStatus.OK).data(roles);
    }

    @PreAuthorize("hasAuthority('role:add')")
    @PostMapping
    public Response addRole(@Validated(OnCreate.class) @RequestBody Role role) {
        this.roleService.save(role);
        return new Response().code(HttpStatus.ADD);
    }

    @PreAuthorize("hasAuthority('role:update')")
    @PutMapping
    public Response updateRole(@Validated(OnUpdate.class) @RequestBody Role role) {
        this.roleService.updateById(role);
        return new Response().code(HttpStatus.OK);
    }

    @PreAuthorize("hasAuthority('role:del')")
    @DeleteMapping("/{roleId}")
    public Response deleteRole(@PathVariable String roleId) {
        this.roleService.deleteRole(roleId);
        return new Response().code(HttpStatus.DELETE);
    }

    @PreAuthorize("hasAuthority('role:active')")
    @PostMapping("/actions/update-active-state")
    public Response updateRoleActiveState(@NotNull(message = "请求参数有误") String roleId) {
        this.roleService.updateRoleActiveState(roleId);
        return new Response().code(HttpStatus.UPDATE);
    }

    @PreAuthorize("hasAuthority('role:perm')")
    @PostMapping("/permissions")
    public Response addRolePermissions(@Valid @RequestBody PostPermission postPermission) {
        this.roleService.addRolePermissions(postPermission);
        return new Response().code(HttpStatus.ADD);
    }
}
