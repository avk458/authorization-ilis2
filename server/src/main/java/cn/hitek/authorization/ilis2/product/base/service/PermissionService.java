package cn.hitek.authorization.ilis2.product.base.service;

import cn.hitek.authorization.ilis2.framework.web.service.BaseService;
import cn.hitek.authorization.ilis2.product.base.domain.Permission;

import java.util.List;

/**
 * @author chenlm
 */
public interface PermissionService extends BaseService<Permission> {


    /**
     * 查询是否有使用的权限
     * @param perm 权限
     * @return 检查结果
     */
    boolean existsUsingPermission(List<Permission> perm);

    /**
     * 查询权限是否有重复
     * @param permissions 权限
     */
    void duplicationAuthority(List<Permission> permissions);
}
