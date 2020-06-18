package cn.hitek.authorization.ilis2.product.base.domain.dto;

import lombok.Data;

import javax.validation.constraints.NotBlank;

/**
 * @author chenlm
 */
@Data
public class LoginUser {

    @NotBlank(message = "用户名不能为空")
    private String username;
    @NotBlank(message = "密码不能为空")
    private String password;
}
