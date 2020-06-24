package cn.hitek.authorization.ilis2.product.base.domain.vo;

import lombok.Data;

import javax.validation.constraints.NotBlank;
import java.util.List;

/**
 * @author chenlm
 */
@Data
public class PostUserRoles {

    @NotBlank(message = "请求数据有误")
    private String userId;
    private List<String> roleIds;
}
