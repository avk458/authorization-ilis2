package cn.hitek.authorization.ilis2.product.base.controller;

import cn.hitek.authorization.ilis2.common.enums.HttpStatus;
import cn.hitek.authorization.ilis2.common.response.Response;
import cn.hitek.authorization.ilis2.framework.web.controller.BaseController;
import cn.hitek.authorization.ilis2.product.base.domain.User;
import cn.hitek.authorization.ilis2.product.base.service.UserService;
import lombok.AllArgsConstructor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;

/**
 * @author kano
 */
@RestController
@RequestMapping("user")
@AllArgsConstructor
public class LoginController extends BaseController {

    private final UserService userService;

    @PostMapping("/login")
    public Response login(@RequestBody User loginUser) {
        String token = this.userService.handleLogin(loginUser);
        return result(HttpStatus.OK, token);
    }

    @PreAuthorize("hasAuthority('user:info')")
    @GetMapping("/info")
    public Response getUserInfo() {
        HashMap<String, Object> result = new HashMap<>(0);
        result.put("name:", "super_admin");
        result.put("userId", "123123");
        result.put("access", new String[]{"super_admin", "admin"});
        result.put("token", "super_admin");
        result.put("avatar", "https://i.loli.net/2020/05/13/dzGrXugK6pCqncN.png");
        return new Response().code(HttpStatus.OK).data(result);
    }

    @GetMapping("/message/count")
    public Response getMessageCount() {
        return new Response().code(HttpStatus.OK).data(3);
    }

    @PostMapping("/logout")
    public Response logout() {
        return new Response().code(HttpStatus.OK);
    }
}
