package cn.hitek.authorization.ilis2.product.init.file.domain;

import cn.hitek.authorization.ilis2.framework.web.entity.BaseEntity;
import com.baomidou.mybatisplus.annotation.TableField;
import lombok.Getter;
import lombok.Setter;

import java.io.File;

/**
 * @author chenlm
 */
@Getter
@Setter
public class InitFile extends BaseEntity {

    public static final int SQL_FILE = 10;
    public static final int LOG_FILE = 20;

    private String configId;

    private String configName;

    private String sqlFilePath;

    @TableField(exist = false)
    private boolean sqlFileExist;

    private String processLogPath;

    @TableField(exist = false)
    private boolean logFileExist;

    private String unitDatabaseId;

    private String unitDatabaseName;

    public boolean isSqlFileExist() {
        return new File(this.sqlFilePath).exists();
    }

    public boolean isLogFileExist() {
        return new File(this.processLogPath).exists();
    }
}
