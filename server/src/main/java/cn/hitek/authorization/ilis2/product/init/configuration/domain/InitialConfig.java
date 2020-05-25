package cn.hitek.authorization.ilis2.product.init.configuration.domain;

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
import org.apache.commons.lang3.StringUtils;
import org.springframework.util.CollectionUtils;

import javax.validation.constraints.Digits;
import javax.validation.constraints.NotBlank;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

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

    @NotBlank(message = "数据库名不能为空", groups = {OnUpdate.class, OnCreate.class})
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
    @TableField(fill = FieldFill.INSERT, select = false)
    private Boolean isDeleted;

    /**
     * 该属性用于存储需要初始化数据的表名，用半角逗号分隔
     */
    private String carryDataTables;

    /**
     * 该属性用于前端交互和数据库字段拼接
     */
    @TableField(exist = false)
    private List<String> initDataTableSet;

    /**
     * 该属性用作各exporter判断是否需要生成多个命令行
     */
    @TableField(exist = false)
    private boolean needSecondCommands;

    @NotBlank(message = "目标数据库连接地址不能为空", groups = {OnUpdate.class, OnCreate.class})
    private String targetDatabaseHost;

    @Digits(integer = 1025, fraction = 65535, message = "数据库端口不合规", groups = {OnUpdate.class, OnCreate.class})
    private Integer targetDatabasePort;

    @NotBlank(message = "目标数据库用户名不能为空", groups = OnCreate.class)
    @TableField(updateStrategy = FieldStrategy.NOT_EMPTY)
    @JsonIgnore
    @JsonProperty(access = JsonProperty.Access.WRITE_ONLY)
    private String targetDatabaseUsername;

    @NotBlank(message = "目标数据库密码不能为空", groups = OnCreate.class)
    @TableField(updateStrategy = FieldStrategy.NOT_EMPTY)
    @JsonIgnore
    @JsonProperty(access = JsonProperty.Access.WRITE_ONLY)
    private String targetDatabasePwd;

    @JsonIgnore
    public String getDecryptPassword() {
        return EncryptUtils.decrypt(password);
    }

    @JsonIgnore
    public String getDecryptTargetDatabaseUsername() {
        return EncryptUtils.decrypt(targetDatabaseUsername);
    }

    @JsonIgnore
    public String getDecryptTargetDatabasePwd() {
        return EncryptUtils.decrypt(targetDatabasePwd);
    }

    public void setInitDataTableSet(List<String> initDataTableSet) {
        if (!CollectionUtils.isEmpty(initDataTableSet)) {
            setCarryDataTables(String.join(",", initDataTableSet));
        } else {
            this.carryDataTables = "";
        }
        this.initDataTableSet = initDataTableSet;
    }

    public List<String> getInitDataTableSet() {
        if (StringUtils.isNotBlank(carryDataTables)) {
            this.initDataTableSet = new ArrayList<>(Arrays.asList(carryDataTables.split(",")));
        }
        return initDataTableSet;
    }
}
