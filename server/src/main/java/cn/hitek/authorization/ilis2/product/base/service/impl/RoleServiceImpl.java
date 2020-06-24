package cn.hitek.authorization.ilis2.product.base.service.impl;

import cn.hitek.authorization.ilis2.common.exception.BusinessException;
import cn.hitek.authorization.ilis2.framework.web.service.impl.BaseServiceImpl;
import cn.hitek.authorization.ilis2.product.base.domain.Role;
import cn.hitek.authorization.ilis2.product.base.domain.vo.PostPermission;
import cn.hitek.authorization.ilis2.product.base.mapper.RoleMapper;
import cn.hitek.authorization.ilis2.product.base.service.RoleService;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;


/**
 * @author chenlm
 */
@Service
@AllArgsConstructor
public class RoleServiceImpl extends BaseServiceImpl<RoleMapper, Role> implements RoleService {


    @Transactional(rollbackFor = Exception.class)
    @Override
    public void deleteRole(String roleId) {
        Integer rows = baseMapper.roleReference(roleId);
        if (rows > 0) {
            throw new BusinessException("当前角色有关联用户，不能删除");
        }
        removeById(roleId);
        baseMapper.deletePermissionByRoleId(roleId);
    }

    @Override
    public void updateRoleActiveState(String roleId) {
        Role role = getById(roleId);
        role.setActive(!role.getActive());
        updateById(role);
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public void addRolePermissions(PostPermission postPermission) {
        String roleId = postPermission.getRoleId();
        baseMapper.deletePermissionByRoleId(roleId);
        List<String> permissionIds = postPermission.getPermissionIds();
        if (!permissionIds.isEmpty()) {
            baseMapper.insertRolePermissions(roleId, permissionIds);
        }
    }

    @Override
    public List<Role> getRoleWithPermissions() {
        return baseMapper.getRolePermissionsBatch();
    }
}
