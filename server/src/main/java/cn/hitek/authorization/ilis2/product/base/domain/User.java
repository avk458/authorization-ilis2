package cn.hitek.authorization.ilis2.product.base.domain;

import cn.hitek.authorization.ilis2.common.validation.group.OnCreate;
import cn.hitek.authorization.ilis2.framework.web.entity.BaseEntity;
import com.baomidou.mybatisplus.annotation.FieldStrategy;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableLogic;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Getter;
import lombok.Setter;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.util.List;

/**
 * @author chenlm
 */
@Getter
@Setter
@TableName("t_s_user")
public class User extends BaseEntity {

    @NotBlank(message = "用户名不能为空")
    private String username;

    @NotBlank(message = "用户密码不能为空", groups = OnCreate.class)
    @TableField(updateStrategy = FieldStrategy.NOT_EMPTY)
    @JsonIgnore
    @JsonProperty(access = JsonProperty.Access.WRITE_ONLY)
    private String password;

    @NotBlank(message = "用户姓名/昵称不能为空")
    private String realName;

    private String avatar;

    @NotNull(message = "必须设置用户是否启用")
    private Boolean active;

    @TableLogic
    private Boolean isDeleted;

    @TableField(exist = false)
    private List<Role> roles;
}
