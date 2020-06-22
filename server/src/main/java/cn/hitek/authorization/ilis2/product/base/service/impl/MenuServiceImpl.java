package cn.hitek.authorization.ilis2.product.base.service.impl;

import cn.hitek.authorization.ilis2.framework.web.service.impl.BaseServiceImpl;
import cn.hitek.authorization.ilis2.product.base.domain.Menu;
import cn.hitek.authorization.ilis2.product.base.mapper.MenuMapper;
import cn.hitek.authorization.ilis2.product.base.service.MenuService;
import org.springframework.stereotype.Service;

/**
 * @author chenlm
 */
@Service
public class MenuServiceImpl extends BaseServiceImpl<MenuMapper, Menu> implements MenuService {
}
