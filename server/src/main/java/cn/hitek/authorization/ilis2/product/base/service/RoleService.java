package cn.hitek.authorization.ilis2.product.base.service;

import cn.hitek.authorization.ilis2.framework.web.service.BaseService;
import cn.hitek.authorization.ilis2.product.base.domain.Role;

/**
 * @author chenlm
 */
public interface RoleService extends BaseService<Role> {

    /**
     * 根据角色id删除角色，若角色有关联用户则不允许删除
     * @param roleId 角色id
     */
    void deleteRole(String roleId);
}
