package cn.hitek.authorization.ilis2.product.base.controller;

import cn.hitek.authorization.ilis2.common.enums.HttpStatus;
import cn.hitek.authorization.ilis2.common.response.Response;
import cn.hitek.authorization.ilis2.product.base.domain.Menu;
import cn.hitek.authorization.ilis2.product.base.domain.vo.PostMenu;
import cn.hitek.authorization.ilis2.product.base.service.MenuService;
import cn.hitek.authorization.ilis2.product.base.service.PermissionService;
import lombok.AllArgsConstructor;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * @author chenlm
 */
@RestController
@RequestMapping("menu")
@AllArgsConstructor
public class MenuController {

    private final MenuService menuService;
    private final PermissionService permissionService;

    @GetMapping("/list")
    public Response getMenus() {
        List<Menu> menus = this.menuService.list();
        return new Response().code(HttpStatus.OK).data(menus);
    }

    @PostMapping
    public Response addMenu(@Validated @RequestBody PostMenu menu) {
        // this.permissionService.saveBatch(permissions);
        return new Response().code(HttpStatus.ADD);
    }
}
