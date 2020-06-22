package cn.hitek.authorization.ilis2.product.base.domain.dto;

import cn.hitek.authorization.ilis2.product.base.domain.UserDetail;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

/**
 * @author chenlm
 */
@Data
@NoArgsConstructor
public class UserInfo {

    private String userId;
    private String name;
    private String username;
    private List<String> access;
    private String avatar;

    public UserInfo(UserDetail userDetail) {
        this.userId = userDetail.getUserId();
        this.name = userDetail.getRealName();
        this.username = userDetail.getUsername();
        this.access = userDetail.getRoles();
        this.avatar = userDetail.getAvatar();
    }
}
