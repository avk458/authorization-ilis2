package cn.hitek.authorization.ilis2.product.base.domain.vo;

import cn.hitek.authorization.ilis2.product.base.domain.Permission;
import lombok.Data;

import java.util.List;

/**
 * @author chenlm
 */
@Data
public class PostMenu {

    private String title;
    private String name;
    private String path;
    private String parentId;
    private String icon;
    private List<Permission> permissions;
}
