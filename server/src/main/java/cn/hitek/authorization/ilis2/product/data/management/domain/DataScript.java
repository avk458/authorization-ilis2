package cn.hitek.authorization.ilis2.product.data.management.domain;

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
    private LocalDateTime createTime;

    @TableField(jdbcType = JdbcType.VARCHAR)
    private Type type;

    @NotBlank(message = "数据库脚本不能为空")
    private String script;

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
