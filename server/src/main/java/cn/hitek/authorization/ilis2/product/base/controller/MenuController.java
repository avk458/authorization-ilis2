package cn.hitek.authorization.ilis2.product.base.controller;

import cn.hitek.authorization.ilis2.common.enums.HttpStatus;
import cn.hitek.authorization.ilis2.common.response.Response;
import cn.hitek.authorization.ilis2.product.base.domain.dto.CascadeMenu;
import cn.hitek.authorization.ilis2.product.base.domain.vo.PostMenu;
import cn.hitek.authorization.ilis2.product.base.service.MenuService;
import lombok.AllArgsConstructor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

/**
 * @author chenlm
 */
@RestController
@RequestMapping("menu")
@AllArgsConstructor
public class MenuController {

    private final MenuService menuService;

    @GetMapping("/tree")
    public Response getMenuTree() {
        List<PostMenu> menus = this.menuService.getMenuTreeList();
        return new Response().code(HttpStatus.OK).data(menus);
    }

    @GetMapping("/list")
    public Response getMenus(String pId) {
        List<CascadeMenu> menus = this.menuService.getCascadeMenus(pId);
        return new Response().code(HttpStatus.OK).data(menus);
    }

    @PreAuthorize("hasAuthority('menu:add')")
    @PostMapping
    public Response addMenu(@Validated @RequestBody PostMenu menu) {
        this.menuService.addMenusAndPermissions(menu);
        return new Response().code(HttpStatus.ADD);
    }

    @PreAuthorize("hasAuthority('menu:update')")
    @PutMapping
    public Response updateMenu(@Validated @RequestBody PostMenu menu) {
        this.menuService.updateMenu(menu);
        return new Response().code(HttpStatus.UPDATE);
    }

    @PreAuthorize("hasAuthority('menu:del')")
    @DeleteMapping("/{menuId}")
    public Response deleteMenu(@PathVariable String menuId) {
        this.menuService.deleteMenu(menuId);
        return new Response().code(HttpStatus.DELETE);
    }

    @GetMapping("/menu-permissions")
    public Response getMenuPermissions() {
        List<Map<String, Object>> menuPermissions = this.menuService.getMenuPermissions();
        return new Response().code(HttpStatus.OK).data(menuPermissions);
    }
}
