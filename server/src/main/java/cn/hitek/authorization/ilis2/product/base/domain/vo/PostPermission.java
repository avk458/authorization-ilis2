package cn.hitek.authorization.ilis2.product.base.domain.vo;

import lombok.Data;

import javax.validation.constraints.NotBlank;
import java.util.List;

/**
 * @author chenlm
 */
@Data
public class PostPermission {

    @NotBlank(message = "请求参数有误")
    private String roleId;
    private List<String> permissionIds;
}
