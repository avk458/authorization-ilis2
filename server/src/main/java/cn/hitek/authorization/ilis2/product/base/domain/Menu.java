package cn.hitek.authorization.ilis2.product.base.domain;

import cn.hitek.authorization.ilis2.framework.web.entity.BaseEntity;
import cn.hitek.authorization.ilis2.product.base.domain.vo.PostMenu;
import com.baomidou.mybatisplus.annotation.TableLogic;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.validation.constraints.NotBlank;

/**
 * @author chenlm
 */
@Getter
@Setter
@TableName("t_s_menu")
@NoArgsConstructor
public class Menu extends BaseEntity {

    @NotBlank(message = "菜单名称不能为空")
    private String title;

    @NotBlank(message = "路由名称不能为空")
    private String name;

    @NotBlank(message = "路由路径不能为空")
    private String path;

    private String parentId;

    private String parentTitle;

    private String icon;

    @TableLogic
    private Boolean isDeleted;

    public Menu(PostMenu postMenu) {
        this.setId(postMenu.getId());
        this.title = postMenu.getTitle();
        this.name = postMenu.getName();
        this.path = postMenu.getPath();
        this.parentId = postMenu.getParentId();
        this.parentTitle = postMenu.getParentTitle();
        this.icon = postMenu.getIcon();
    }
}
