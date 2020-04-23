package cn.hitek.authorization.ilis2.product.database.domain;

import cn.hitek.authorization.ilis2.framework.web.entity.BaseEntity;
import cn.hitek.authorization.ilis2.product.constants.DatabaseType;
import com.baomidou.mybatisplus.annotation.FieldFill;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableLogic;
import lombok.Getter;
import lombok.Setter;

import javax.validation.constraints.Max;
import javax.validation.constraints.Min;
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
    /**
     * 是否删除
     */
    @TableLogic
    @TableField(fill = FieldFill.INSERT)
    private Boolean isDeleted;

    /**
     * 所属单位
     */
    @NotBlank(message = "所属单位不能为空")
    private String unitId;

    private String unitName;

    /**
     * 数据库名
     */
    @NotBlank(message = "数据库名不能为空")
    private String databaseName;

    /**
     * 数据库ip
     */
    @NotBlank(message = "数据库地址不能为空")
    private String host;

    /**
     * 数据库端口
     */
    @Min(value = 20, message = "数据库端口太小")
    @Max(value = 65535, message = "数据库端口不能超过65535")
    private Integer port;

    /**
     * 连接参数
     */
    private String params;

    /**
     * 数据库用户名
     */
    @NotBlank(message = "数据库地址不能为空")
    private String databaseUsername;

    /**
     * 数据库密码
     */
    @NotBlank(message = "数据库地址不能为空")
    private String databasePwd;

    /**
     * 数据库版本
     */
    private String databaseVersion;

    /**
     * 数据库类型
     */
    @Min(value = 211, message = "数据库类型不合法")
    @Min(value = 233, message = "数据库类型不合法")
    private Integer databaseType;

    /**
     * 是否已初始化
     */
    private Boolean isInitialized;

    public DatabaseType getDatabaseType() {
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
