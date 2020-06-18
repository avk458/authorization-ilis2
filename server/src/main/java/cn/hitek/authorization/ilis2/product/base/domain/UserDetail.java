package cn.hitek.authorization.ilis2.product.base.domain;


import com.baomidou.mybatisplus.annotation.TableField;
import lombok.Data;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.io.Serializable;
import java.util.Collection;

/**
 * @author chenlm
 */
@Data
public class UserDetail implements UserDetails, Serializable {

    private static final long serialVersionUID = 1643580155199215915L;
    private String realName;
    private String username;
    private String password;
    @TableField(exist = false)
    private Collection<? extends GrantedAuthority> authorities;
    private boolean accountNonExpired;
    private boolean accountNonLocked;
    private boolean credentialsNonExpired;
    private boolean enabled;

    public UserDetail(User user) {
        this.username = user.getUsername();
        this.password = user.getPassword();
        this.realName = user.getRealName();
        this.accountNonExpired = true;
        this.accountNonLocked = true;
        this.credentialsNonExpired = true;
        this.enabled = true;
    }

    public UserDetail(User user, Collection<? extends GrantedAuthority> authorities) {
        this.username = user.getUsername();
        this.password = user.getPassword();
        this.realName = user.getRealName();
        this.authorities = authorities;
        this.accountNonExpired = true;
        this.accountNonLocked = true;
        this.credentialsNonExpired = true;
        this.enabled = true;
    }
}
