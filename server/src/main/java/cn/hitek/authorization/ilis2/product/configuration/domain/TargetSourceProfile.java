package cn.hitek.authorization.ilis2.product.configuration.domain;

import cn.hitek.authorization.ilis2.common.validation.group.OnCreate;
import cn.hitek.authorization.ilis2.common.validation.group.OnUpdate;
import cn.hitek.authorization.ilis2.framework.web.entity.BaseEntity;
import com.baomidou.mybatisplus.annotation.*;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Getter;
import lombok.Setter;

import javax.validation.constraints.Digits;
import javax.validation.constraints.NotBlank;

/**
 * @author chenlm
 */
@Getter
@Setter
@TableName("t_target_source_profile")
public class TargetSourceProfile extends BaseEntity {

    @NotBlank(message = "配置名称不能为空", groups = {OnUpdate.class, OnCreate.class})
    private String profileName;

    @NotBlank(message = "连接地址不能为空", groups = {OnUpdate.class, OnCreate.class})
    private String host;

    @Digits(integer = 1025, fraction = 65535, message = "数据库端口不合规", groups = {OnUpdate.class, OnCreate.class})
    private Integer port;

    @NotBlank(message = "用户名不能为空", groups = {OnUpdate.class, OnCreate.class})
    private String username;

    @NotBlank(message = "密码不能为空", groups = OnCreate.class)
    @TableField(updateStrategy = FieldStrategy.NOT_EMPTY)
    @JsonIgnore
    @JsonProperty(access = JsonProperty.Access.WRITE_ONLY)
    private String password;

    private Boolean available;

    @TableLogic
    @TableField(fill = FieldFill.INSERT, select = false)
    private Boolean isDeleted;
}
