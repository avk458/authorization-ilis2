package cn.hitek.authorization.ilis2.product.base.domain.vo;

import lombok.Data;

import javax.validation.constraints.NotBlank;

/**
 * @author chenlm
 */
@Data
public class PostUserPwd {

    private static final String MESSAGE = "请求参数有误";

    @NotBlank(message = MESSAGE)
    private String username;

    @NotBlank(message = MESSAGE)
    private String orgPwd;

    @NotBlank(message = MESSAGE)
    private String newPwd;
}
