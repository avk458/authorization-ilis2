package cn.hitek.authorization.ilis2.product.base.service;

import cn.hitek.authorization.ilis2.framework.web.service.BaseService;
import cn.hitek.authorization.ilis2.product.base.domain.Role;
import cn.hitek.authorization.ilis2.product.base.domain.vo.PostPermission;

import java.util.List;

/**
 * @author chenlm
 */
public interface RoleService extends BaseService<Role> {

    /**
     * 根据角色id删除角色，若角色有关联用户则不允许删除
     * @param roleId 角色id
     */
    void deleteRole(String roleId);

    /**
     * 更新角色启用权限
     * @param roleId 角色id
     */
    void updateRoleActiveState(String roleId);

    /**
     * 添加角色权限
     * @param postPermission 参数封装对象
     */
    void addRolePermissions(PostPermission postPermission);

    /**
     * 获取角色以及角色权限列表
     * @return 角色/权限集合
     */
    List<Role> getRoleWithPermissions();
}
