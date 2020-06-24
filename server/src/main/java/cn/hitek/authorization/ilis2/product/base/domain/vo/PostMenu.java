package cn.hitek.authorization.ilis2.product.base.domain.vo;

import cn.hitek.authorization.ilis2.product.base.domain.Menu;
import cn.hitek.authorization.ilis2.product.base.domain.Permission;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.NotBlank;
import java.util.List;

/**
 * @author chenlm
 */
@Data
@NoArgsConstructor
public class PostMenu {

    private String id;

    @NotBlank(message = "菜单名称不能为空")
    private String title;

    @NotBlank(message = "路由名称不能为空")
    private String name;

    @NotBlank(message = "路由路径不能为空")
    private String path;
    private String parentTitle;
    private String parentId;
    private String icon;
    private List<Permission> permissions;

    private List<PostMenu> children;

    public PostMenu(Menu menu) {
        this.id = menu.getId();
        this.title = menu.getTitle();
        this.name = menu.getName();
        this.path = menu.getPath();
        this.parentId = menu.getParentId();
        this.parentTitle = menu.getParentTitle();
        this.icon = menu.getIcon();
    }
}
