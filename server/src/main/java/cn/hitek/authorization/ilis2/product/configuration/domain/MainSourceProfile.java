package cn.hitek.authorization.ilis2.product.configuration.domain;

import cn.hitek.authorization.ilis2.common.utils.EncryptUtils;
import cn.hitek.authorization.ilis2.common.validation.group.OnCreate;
import cn.hitek.authorization.ilis2.common.validation.group.OnUpdate;
import cn.hitek.authorization.ilis2.framework.web.entity.BaseEntity;
import com.baomidou.mybatisplus.annotation.*;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.validation.constraints.Digits;
import javax.validation.constraints.NotBlank;

/**
 * 主数据源配置信息
 *
 * @author chenlm
 */
@Getter
@Setter
@NoArgsConstructor
@TableName(value = "t_main_source_profile")
public class MainSourceProfile extends BaseEntity {

    public static final boolean ACTIVE = true;
    /**
     * 配置名称
     */
    @NotBlank(message = "配置名称不能为空", groups = {OnUpdate.class, OnCreate.class})
    private String profileName;

    /**
     * 地址
     */
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

    /**
     * 数据库文件存放地址
     */
    @NotBlank(message = "文件存放地址不能为空", groups = {OnUpdate.class, OnCreate.class})
    private String path;

    /**
     * 启用标记
     */
    @TableField(value = "active")
    private Boolean active;

    @TableLogic
    @TableField(fill = FieldFill.INSERT, select = false)
    private Boolean isDeleted;

    @NotBlank(message = "SourceSchema不能为空", groups = {OnUpdate.class, OnCreate.class})
    private String sourceSchema;

    @NotBlank(message = "StandardSchema不能为空", groups = {OnUpdate.class, OnCreate.class})
    private String standardSchema;

    @JsonIgnore
    public String getDecryptPassword() {
        return EncryptUtils.decrypt(password);
    }
}
