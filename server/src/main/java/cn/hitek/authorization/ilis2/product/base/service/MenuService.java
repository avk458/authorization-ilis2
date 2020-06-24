package cn.hitek.authorization.ilis2.product.base.service;

import cn.hitek.authorization.ilis2.framework.web.service.BaseService;
import cn.hitek.authorization.ilis2.product.base.domain.Menu;
import cn.hitek.authorization.ilis2.product.base.domain.dto.CascadeMenu;
import cn.hitek.authorization.ilis2.product.base.domain.vo.PostMenu;

import java.util.List;
import java.util.Map;

/**
 * @author chenlm
 */
public interface MenuService extends BaseService<Menu> {

    /**
     * 新增菜单和菜单下的权限
     * @param menu po
     */
    void addMenusAndPermissions(PostMenu menu);

    /**
     * 获取菜单视图属性对象
     * 作为以代码处理属性关系的演示
     * @return tree list
     */
    List<PostMenu> getMenuTreeList();

    /**
     * 获取级联菜单
     * @param pId 父id
     * @return 级联菜单
     */
    List<CascadeMenu> getCascadeMenus(String pId);

    /**
     * 更新菜单
     * @param menu vo
     */
    void updateMenu(PostMenu menu);

    /**
     * 删除菜单
     * @param menuId 菜单id
     */
    void deleteMenu(String menuId);

    /**
     * 获取顶级菜单下的权限
     * @return 菜单下的权限
     */
    List<Map<String, Object>> getMenuPermissions();
}
