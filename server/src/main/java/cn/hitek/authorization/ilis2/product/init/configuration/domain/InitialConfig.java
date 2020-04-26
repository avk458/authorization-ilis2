package cn.hitek.authorization.ilis2.product.init.configuration.domain;

import cn.hitek.authorization.ilis2.framework.web.entity.BaseEntity;
import com.baomidou.mybatisplus.annotation.FieldFill;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableLogic;
import com.baomidou.mybatisplus.annotation.TableName;
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
@TableName(value = "t_initial_config")
public class InitialConfig extends BaseEntity {

    public static final boolean ACTIVE = true;
    /**
     * 配置名称
     */
    @NotBlank(message = "配置名称不能为空")
    private String name;

    /**
     * 地址
     */
    @NotBlank(message = "连接地址不能为空")
    private String host;

    @Digits(integer = 1025, fraction = 65535, message = "数据库端口不合规")
    private Integer port;

    @NotBlank(message = "用户名不能为空")
    private String username;

    @NotBlank(message = "密码不能为空")
    private String password;

    /**
     * 数据库文件存放地址
     */
    @NotBlank(message = "文件存放地址不能为空")
    private String path;

    @NotBlank(message = "数据库名不能为空")
    private String schemaName;

    /**
     * 启用标记
     */
    @TableField(value = "active")
    private Boolean active;

    /**
     * 否：仅同步数据结构，是：同步数据结构和数据
     */
    private Boolean initWithData;

    @TableLogic
    @TableField(fill = FieldFill.INSERT)
    private Boolean isDeleted;
}
