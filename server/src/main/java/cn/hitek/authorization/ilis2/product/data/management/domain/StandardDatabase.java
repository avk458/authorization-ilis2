package cn.hitek.authorization.ilis2.product.data.management.domain;

import cn.hitek.authorization.ilis2.framework.web.entity.BaseEntity;
import com.baomidou.mybatisplus.annotation.FieldFill;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableLogic;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Getter;
import lombok.Setter;

/**
 * @author chenlm
 */
@TableName("t_standard_database")
@Getter
@Setter
public class StandardDatabase extends BaseEntity {

    @TableLogic
    @TableField(fill = FieldFill.INSERT, select = false)
    private Boolean isDelete;

    private String configId;

    private String schemaName;

    private String version;

    private String testTemplate;

    private String staticTables;

}
