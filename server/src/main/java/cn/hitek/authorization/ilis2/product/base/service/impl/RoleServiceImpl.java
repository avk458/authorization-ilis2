package cn.hitek.authorization.ilis2.product.base.service.impl;

import cn.hitek.authorization.ilis2.framework.web.service.impl.BaseServiceImpl;
import cn.hitek.authorization.ilis2.product.base.domain.Role;
import cn.hitek.authorization.ilis2.product.base.mapper.RoleMapper;
import cn.hitek.authorization.ilis2.product.base.service.RoleService;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;


/**
 * @author chenlm
 */
@Service
@AllArgsConstructor
public class RoleServiceImpl extends BaseServiceImpl<RoleMapper, Role> implements RoleService {
}
