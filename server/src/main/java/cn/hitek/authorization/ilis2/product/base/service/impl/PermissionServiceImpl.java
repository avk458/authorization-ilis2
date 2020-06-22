package cn.hitek.authorization.ilis2.product.base.service.impl;

import cn.hitek.authorization.ilis2.framework.web.service.impl.BaseServiceImpl;
import cn.hitek.authorization.ilis2.product.base.domain.Permission;
import cn.hitek.authorization.ilis2.product.base.mapper.PermissionMapper;
import cn.hitek.authorization.ilis2.product.base.service.PermissionService;
import org.springframework.stereotype.Service;

/**
 * @author chenlm
 */
@Service
public class PermissionServiceImpl extends BaseServiceImpl<PermissionMapper, Permission> implements PermissionService {
}
