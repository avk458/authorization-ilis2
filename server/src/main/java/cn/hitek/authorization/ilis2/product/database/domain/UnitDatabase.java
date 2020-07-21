package cn.hitek.authorization.ilis2.product.database.domain;

import cn.hitek.authorization.ilis2.common.enums.DatabaseType;
import cn.hitek.authorization.ilis2.common.validation.group.OnCreate;
import cn.hitek.authorization.ilis2.common.validation.group.OnUpdate;
import cn.hitek.authorization.ilis2.framework.web.entity.BaseEntity;
import com.baomidou.mybatisplus.annotation.FieldFill;
import com.baomidou.mybatisplus.annotation.FieldStrategy;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableLogic;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Getter;
import lombok.Setter;

import javax.validation.constraints.Digits;
import javax.validation.constraints.NotBlank;
import java.io.Serializable;

/**
 * @author chenlm
 * 单位数据库信息
 */
@Getter
@Setter
public class UnitDatabase extends BaseEntity implements Serializable {

    public static final boolean INITIALIZED = true;
    public static final boolean MANAGE_ABLE = true;
    private static final long serialVersionUID = 4651993794161153629L;
    /**
     * 是否删除
     */
    @TableLogic
    @TableField(fill = FieldFill.INSERT, select = false)
    private Boolean isDeleted;

    /**
     * 所属单位
     */
    @NotBlank(message = "所属单位不能为空", groups = {OnCreate.class, OnUpdate.class})
    private String unitId;

    private String unitName;

    /**
     * 数据库名
     */
    @NotBlank(message = "数据库名不能为空", groups = {OnCreate.class, OnUpdate.class})
    private String databaseName;

    /**
     * 数据库ip
     */
    @NotBlank(message = "数据库地址不能为空", groups = {OnCreate.class, OnUpdate.class})
    private String host;

    /**
     * 数据库端口
     */
    @Digits(integer = 1025, fraction = 65535, message = "数据库端口不合规", groups = {OnCreate.class, OnUpdate.class})
    private Integer port;

    /**
     * 连接参数
     */
    private String params;

    /**
     * 数据库用户名
     */
    @NotBlank(message = "数据库用户名不能为空", groups = OnCreate.class)
    @TableField(updateStrategy = FieldStrategy.NOT_EMPTY)
    @JsonIgnore
    @JsonProperty(access = JsonProperty.Access.WRITE_ONLY)
    private String databaseUsername;

    /**
     * 数据库密码
     */
    @NotBlank(message = "数据库密码不能为空", groups = OnCreate.class)
    @TableField(updateStrategy = FieldStrategy.NOT_EMPTY)
    @JsonIgnore
    @JsonProperty(access = JsonProperty.Access.WRITE_ONLY)
    private String databasePwd;

    /**
     * 数据库版本
     */
    private String databaseVersion;

    /**
     * 数据库类型
     */
    @Digits(integer = 211, fraction = 233, message = "数据库类型不合法", groups = {OnCreate.class, OnUpdate.class})
    private Integer databaseType;

    private Boolean manageAble;

    /**
     * 是否已初始化
     */
    private Boolean isInitialized;

    private String mainProfileId;

    private String targetProfileId;

    private String targetProfile;

    private Long dataVersion;

    /**
     * 用于构建标准库
     */
    @TableField(exist = false)
    @JsonIgnore
    private boolean standardSchema;


    public DatabaseType getDatabaseEnum() {
        switch (databaseType) {
            case 222:
                return DatabaseType.POSTGRE_SQL;
            case 233:
                return DatabaseType.MICROSOFT_SQL;
            default:
                return DatabaseType.MYSQL;
        }
    }
}
