package cn.hitek.authorization.ilis2.product.base.service.impl;

import cn.hitek.authorization.ilis2.common.exception.BusinessException;
import cn.hitek.authorization.ilis2.framework.web.service.impl.BaseServiceImpl;
import cn.hitek.authorization.ilis2.product.base.domain.Menu;
import cn.hitek.authorization.ilis2.product.base.domain.Permission;
import cn.hitek.authorization.ilis2.product.base.domain.dto.CascadeMenu;
import cn.hitek.authorization.ilis2.product.base.domain.vo.PostMenu;
import cn.hitek.authorization.ilis2.product.base.mapper.MenuMapper;
import cn.hitek.authorization.ilis2.product.base.service.MenuService;
import cn.hitek.authorization.ilis2.product.base.service.PermissionService;
import cn.hutool.core.util.StrUtil;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.function.Function;

import static java.util.stream.Collectors.*;

/**
 * @author chenlm
 */
@Service
@AllArgsConstructor
public class MenuServiceImpl extends BaseServiceImpl<MenuMapper, Menu> implements MenuService {

    private final PermissionService permissionService;

    @Transactional(rollbackFor = Exception.class)
    @Override
    public void addMenusAndPermissions(PostMenu postMenu) {
        Menu menu = new Menu(postMenu);
        save(menu);
        List<Permission> permissions = postMenu.getPermissions();
        this.permissionService.duplicationAuthority(permissions);
        permissions.forEach(p -> p.setMenuId(menu.getId()));
        this.permissionService.saveBatch(permissions);
    }

    @Override
    public List<PostMenu> getMenuTreeList() {
        List<Menu> menus = query().list();
        List<Permission> permissions = this.permissionService.list();
        Map<String, List<Permission>> permsMap = permissions
                .stream()
                .collect(groupingBy(Permission::getMenuId,
                        mapping(Function.identity(), toList())));
        return buildMenuTree(menus, permsMap);
    }

    private List<PostMenu> buildMenuTree(List<Menu> menus, Map<String, List<Permission>> permsMap) {
        List<PostMenu> roots = new ArrayList<>(0);
        List<PostMenu> children = new ArrayList<>(0);
        for (Menu menu : menus) {
            PostMenu postMenu = new PostMenu(menu);
            postMenu.setPermissions(permsMap.get(menu.getId()));
            if (StrUtil.isBlank(menu.getParentId())) {
                roots.add(postMenu);
            } else {
                children.add(postMenu);
            }
        }
        Map<String, List<PostMenu>> childrenMap = children
                .parallelStream()
                .collect(groupingBy(PostMenu::getParentId, mapping(Function.identity(), toList())));
        roots.forEach(p -> fillChildren(p, childrenMap));
        return roots;
    }

    private void fillChildren(PostMenu superior, Map<String, List<PostMenu>> childrenMap) {
        List<PostMenu> subMenus = childrenMap.get(superior.getId());
        if (!CollectionUtils.isEmpty(subMenus)) {
            superior.setChildren(subMenus);
            subMenus.forEach(s -> fillChildren(s, childrenMap));
        }
    }

    @Override
    public List<CascadeMenu> getCascadeMenus(String pId) {
        List<Menu> menus = query()
                .eq(StrUtil.isNotBlank(pId), Menu::getParentId, pId)
                .eq(StrUtil.isBlank(pId), Menu::getParentId, "").list();
        return menus.stream().map(m -> new CascadeMenu(m.getId(), m.getTitle())).collect(toList());
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public void updateMenu(PostMenu menu) {
        if (menu.getId().equals(menu.getParentId())) {
            throw new BusinessException("父级菜单不能设置为当前菜单");
        }
        saveOrUpdate(new Menu(menu));
        List<Permission> detachedPermissions = menu.getPermissions();
        List<Permission> currentPermissions = this.permissionService.query().eq(Permission::getMenuId, menu.getId()).list();
        List<Permission> deletePerms = currentPermissions
                .stream()
                .filter(p -> !detachedPermissions.contains(p))
                .collect(toList());
        checkPermissionsIsUsing(deletePerms);
        deletePerms.forEach(dp -> this.permissionService.removeById(dp.getId()));
        detachedPermissions.removeIf(currentPermissions::contains);
        detachedPermissions.forEach(p -> p.setMenuId(menu.getId()));
        this.permissionService.saveOrUpdateBatch(detachedPermissions);
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public void deleteMenu(String menuId) {
        ArrayList<Menu> menuContainer = new ArrayList<>(0);
        getSubMenus(menuId, menuContainer);
        menuContainer.add(getById(menuId));
        List<Permission> menuPermissions = this.permissionService
                .query()
                .in(Permission::getMenuId, menuContainer.stream().map(Menu::getId).collect(toList()))
                .list();
        checkPermissionsIsUsing(menuPermissions);
        menuContainer.forEach(m -> removeById(m.getId()));
        menuPermissions.forEach(p -> this.permissionService.removeById(p.getId()));
    }

    private void getSubMenus(String menuId, List<Menu> menuContainer) {
        List<Menu> menus = query().eq(Menu::getParentId, menuId).list();
        if (!CollectionUtils.isEmpty(menus)) {
            menuContainer.addAll(menus);
            menus.forEach(m -> getSubMenus(m.getId(), menuContainer));
        }
    }

    private void checkPermissionsIsUsing(List<Permission> permissions) {
        boolean using = this.permissionService.existsUsingPermission(permissions);
        if (using) {
            throw new BusinessException("检测到有正在使用的权限，请先取消角色关联再删除权限");
        }
    }

    @Override
    public List<Map<String, Object>> getMenuPermissions() {
        List<Menu> menus = query().eq(Menu::getParentId, "").list();
        ArrayList<Map<String, Object>> menuPermissions = new ArrayList<>(menus.size());
        for (Menu menu : menus) {
            HashMap<String, Object> root = new HashMap<>();
            root.put("title", menu.getTitle());
            ArrayList<Menu> sibling = new ArrayList<>(0);
            getSubMenus(menu.getId(), sibling);
            sibling.add(menu);
            List<Permission> permissions = getMenusPermissions(sibling);
            List<HashMap<String, Object>> perms = permissions.stream().map(p -> {
                HashMap<String, Object> perm = new HashMap<>();
                perm.put("title", p.getAuthority());
                perm.put("id", p.getId());
                perm.put("description", p.getDescription());
                return perm;
            }).collect(toList());
            if (!perms.isEmpty()) {
                root.put("children", perms);
                root.put("loading", false);
            }
            menuPermissions.add(root);
        }
        return menuPermissions;
    }

    private List<Permission> getMenusPermissions(ArrayList<Menu> sibling) {
        return this.permissionService
                .query()
                .in(Permission::getMenuId, sibling.stream().map(Menu::getId).collect(toList()))
                .list();
    }
}
