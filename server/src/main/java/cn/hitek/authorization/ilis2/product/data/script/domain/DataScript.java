package cn.hitek.authorization.ilis2.product.data.script.domain;

import cn.hitek.authorization.ilis2.common.validation.data.NormalScript;
import cn.hitek.authorization.ilis2.common.validation.group.OnCreate;
import cn.hitek.authorization.ilis2.common.validation.group.OnUpdate;
import com.baomidou.mybatisplus.annotation.*;
import lombok.Getter;
import lombok.Setter;
import org.apache.ibatis.type.JdbcType;

import javax.validation.constraints.NotBlank;
import java.time.LocalDateTime;

/**
 * @author chenlm
 */
@Getter
@Setter
@TableName("t_data_script")
public class DataScript {

    @TableId(type = IdType.AUTO)
    private Long id;

    @TableField(fill = FieldFill.INSERT)
    private String createBy;

    @TableField(fill = FieldFill.INSERT)
    private String createName;

    @TableField(fill = FieldFill.INSERT)
    private LocalDateTime createTime;

    @TableField(fill = FieldFill.UPDATE)
    private String updateBy;

    @TableField(fill = FieldFill.UPDATE)
    private String updateName;

    @TableField(fill = FieldFill.UPDATE)
    private LocalDateTime updateTime;

    @TableField(jdbcType = JdbcType.VARCHAR)
    private Type type;

    @NotBlank(message = "数据库脚本不能为空")
    @NormalScript(groups = {OnCreate.class, OnUpdate.class})
    private String script;

    private String remark;

    @TableLogic
    @TableField(fill = FieldFill.INSERT, select = false)
    private Boolean isDeleted;

    public enum Type {
        /**
         * dml
         */
        DML,
        /**
         * ddl
         */
        DDL
    }
}
