package cn.hitek.authorization.ilis2.product.base.domain;

import cn.hitek.authorization.ilis2.framework.web.entity.BaseEntity;
import lombok.*;
import org.springframework.security.core.GrantedAuthority;

/**
 * @author chenlm
 */
@Getter
@Setter
@RequiredArgsConstructor
@AllArgsConstructor
@NoArgsConstructor
public class Permission extends BaseEntity implements GrantedAuthority {

    private static final long serialVersionUID = -3228742050105342067L;
    @NonNull
    private String authority;
    private String desc;
}
