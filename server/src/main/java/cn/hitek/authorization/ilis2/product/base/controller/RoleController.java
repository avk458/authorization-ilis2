package cn.hitek.authorization.ilis2.product.base.controller;

import cn.hitek.authorization.ilis2.common.enums.HttpStatus;
import cn.hitek.authorization.ilis2.common.response.Response;
import cn.hitek.authorization.ilis2.common.validation.group.OnCreate;
import cn.hitek.authorization.ilis2.common.validation.group.OnUpdate;
import cn.hitek.authorization.ilis2.product.base.domain.Role;
import cn.hitek.authorization.ilis2.product.base.service.RoleService;
import lombok.AllArgsConstructor;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

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
        List<Role> roles = this.roleService.list();
        return new Response().code(HttpStatus.OK).data(roles);
    }

    @PostMapping
    public Response addRole(@Validated(OnCreate.class) @RequestBody Role role) {
        this.roleService.save(role);
        return new Response().code(HttpStatus.ADD);
    }

    @PutMapping
    public Response updateRole(@Validated(OnUpdate.class) @RequestBody Role role) {
        this.roleService.updateById(role);
        return new Response().code(HttpStatus.OK);
    }

    @DeleteMapping("/{roleId}")
    public Response deleteRole(@PathVariable String roleId) {
        this.roleService.deleteRole(roleId);
        return new Response().code(HttpStatus.DELETE);
    }
}
