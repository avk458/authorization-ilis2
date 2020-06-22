package cn.hitek.authorization.ilis2.product.base.domain;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.io.Serializable;
import java.util.Collection;
import java.util.List;

/**
 * @author chenlm
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class UserDetail implements UserDetails, Serializable {

    private static final long serialVersionUID = 1643580155199215915L;
    private String userId;
    private String realName;
    private String username;
    private List<String> roles;
    private String avatar;
    private String password;
    private Collection<? extends GrantedAuthority> authorities;
    private boolean accountNonExpired;
    private boolean accountNonLocked;
    private boolean credentialsNonExpired;
    private boolean enabled;

    public UserDetail(User user, Collection<? extends GrantedAuthority> authorities, List<String> roles) {
        this.userId = user.getId();
        this.username = user.getUsername();
        this.realName = user.getRealName();
        this.password = user.getPassword();
        this.roles = roles;
        this.avatar = user.getAvatar();
        this.authorities = authorities;
        this.accountNonExpired = true;
        this.accountNonLocked = true;
        this.credentialsNonExpired = true;
        this.enabled = true;
    }
}
