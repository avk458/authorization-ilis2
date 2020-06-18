package cn.hitek.authorization.ilis2.framework.web.entity;

import cn.hitek.authorization.ilis2.common.validation.group.OnUpdate;
import com.baomidou.mybatisplus.annotation.FieldFill;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.Getter;
import lombok.Setter;

import javax.validation.constraints.NotBlank;
import java.time.LocalDateTime;

/**
 * 基类
 * @author chenlm
 */
@Getter
@Setter
public class BaseEntity {

    public static final boolean DELETED = true;

    @TableId
    @NotBlank(groups = OnUpdate.class, message = "id不能为空")
    private String id;

    /**
     * 创建日期
     */
    @TableField(fill = FieldFill.INSERT)
    private LocalDateTime createTime;

    /**
     * 创建人
     */
    @TableField(fill = FieldFill.INSERT)
    private String createBy;

    /**
     * 创建人姓名
     */
    @TableField(fill = FieldFill.INSERT)
    private String createName;

    /**
     * 修改日期
     */
    @TableField(fill = FieldFill.UPDATE)
    private LocalDateTime updateTime;

    /**
     * 修改人
     */
    @TableField(fill = FieldFill.UPDATE)
    private String updateBy;

    /**
     * 修改人姓名
     */
    @TableField(fill = FieldFill.UPDATE)
    private String updateName;
}
