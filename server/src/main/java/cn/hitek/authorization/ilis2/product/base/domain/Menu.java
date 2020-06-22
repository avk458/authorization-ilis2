package cn.hitek.authorization.ilis2.product.base.domain;

import cn.hitek.authorization.ilis2.framework.web.entity.BaseEntity;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableLogic;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Getter;
import lombok.Setter;

import javax.validation.constraints.NotBlank;
import java.util.List;

/**
 * @author chenlm
 */
@Getter
@Setter
@TableName("t_s_menu")
public class Menu extends BaseEntity {

    @NotBlank(message = "菜单名称不能为空")
    private String title;

    @NotBlank(message = "路由名称不能为空")
    private String name;

    @NotBlank(message = "路由路径不能为空")
    private String path;

    private String parentId;

    private String icon;

    @TableLogic
    private Boolean isDeleted;

    @TableField(exist = false)
    private List<Menu> children;
}
