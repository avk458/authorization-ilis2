package cn.hitek.authorization.ilis2.product.base.domain;


import cn.hitek.authorization.ilis2.framework.web.entity.BaseEntity;
import com.baomidou.mybatisplus.annotation.TableLogic;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Getter;
import lombok.Setter;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

/**
 * @author chenlm
 */
@Getter
@Setter
@TableName("t_s_role")
public class Role extends BaseEntity {

    @NotBlank(message = "角色名称不能为空")
    private String roleName;

    @NotBlank(message = "角色标识不能为空")
    private String role;

    private String description;

    @NotNull(message = "必须设置角色是否启用")
    private Boolean active;

    @TableLogic
    private Boolean isDeleted;

}
