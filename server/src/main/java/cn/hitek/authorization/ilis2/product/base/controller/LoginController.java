package cn.hitek.authorization.ilis2.product.base.controller;

import cn.hitek.authorization.ilis2.common.enums.HttpStatus;
import cn.hitek.authorization.ilis2.common.response.Response;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.Map;

/**
 * @author kano
 */
@RestController
public class LoginController {

    @PostMapping("user/login")
    public Response login() {
        Map<String, String> token = new HashMap<>(0);
        token.put("token", "admin");
        return new Response().code(HttpStatus.OK).data(token);
    }

    @GetMapping("user/info")
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

    @PostMapping("user/logout")
    public Response logout() {
        return new Response().code(HttpStatus.OK);
    }
}
