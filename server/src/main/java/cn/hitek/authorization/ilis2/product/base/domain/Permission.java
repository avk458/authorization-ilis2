package cn.hitek.authorization.ilis2.product.base.domain;

import cn.hitek.authorization.ilis2.framework.web.entity.BaseEntity;
import lombok.Getter;
import lombok.NonNull;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import org.springframework.security.core.GrantedAuthority;

/**
 * @author chenlm
 */
@Getter
@Setter
@RequiredArgsConstructor
public class Permission extends BaseEntity implements GrantedAuthority {

    private static final long serialVersionUID = -3228742050105342067L;
    @NonNull
    private String authority;
    private String desc;
}
