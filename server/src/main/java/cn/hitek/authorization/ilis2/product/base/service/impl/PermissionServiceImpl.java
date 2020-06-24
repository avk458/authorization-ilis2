package cn.hitek.authorization.ilis2.product.base.service.impl;

import cn.hitek.authorization.ilis2.common.exception.BusinessException;
import cn.hitek.authorization.ilis2.framework.web.service.impl.BaseServiceImpl;
import cn.hitek.authorization.ilis2.product.base.domain.Permission;
import cn.hitek.authorization.ilis2.product.base.mapper.PermissionMapper;
import cn.hitek.authorization.ilis2.product.base.service.PermissionService;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

/**
 * @author chenlm
 */
@Service
public class PermissionServiceImpl extends BaseServiceImpl<PermissionMapper, Permission> implements PermissionService {

    @Override
    public boolean existsUsingPermission(List<Permission> permissions) {
        if (permissions.size() > 0) {
            List<String> perms = permissions.stream().map(Permission::getAuthority).collect(Collectors.toList());
            return baseMapper.existsUsingPermission(perms) > 0;
        } else {
            return false;
        }
    }

    @Override
    public void duplicationAuthority(List<Permission> permissions) {
        for (Permission permission : permissions) {
            boolean exist = query().eq(Permission::getAuthority, permission.getAuthority()).exist();
            if (exist) {
                throw new BusinessException("检测到有重复的权限编码");
            }
        }
    }
}
