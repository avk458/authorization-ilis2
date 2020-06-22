package cn.hitek.authorization.ilis2.product.base.domain;

import cn.hitek.authorization.ilis2.framework.web.entity.BaseEntity;
import com.baomidou.mybatisplus.annotation.TableLogic;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Getter;
import lombok.Setter;

/**
 * @author chenlm
 */
@Getter
@Setter
@TableName("t_s_user")
public class User extends BaseEntity {

    private String username;
    private String password;
    private String realName;
    private String avatar;
    @TableLogic
    private Boolean isDeleted;
}
