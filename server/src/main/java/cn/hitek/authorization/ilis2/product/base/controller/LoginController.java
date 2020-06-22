package cn.hitek.authorization.ilis2.product.base.controller;

import cn.hitek.authorization.ilis2.common.enums.HttpStatus;
import cn.hitek.authorization.ilis2.common.response.Response;
import cn.hitek.authorization.ilis2.product.base.domain.User;
import cn.hitek.authorization.ilis2.product.base.domain.dto.Router;
import cn.hitek.authorization.ilis2.product.base.domain.dto.RouterMeta;
import cn.hitek.authorization.ilis2.product.base.service.UserService;
import cn.hutool.http.Header;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.Arrays;
import java.util.Collections;

/**
 * @author kano
 */
@RestController
@RequestMapping("auth")
@AllArgsConstructor
public class LoginController {

    private final UserService userService;

    @PostMapping("/login")
    public Response login(@RequestBody User loginUser) {
        String token = this.userService.handleLogin(loginUser);
        return new Response().code(HttpStatus.OK).data(token);
    }

    @GetMapping("/message/count")
    public Response getMessageCount() {
        return new Response().code(HttpStatus.OK).data(3);
    }

    @PostMapping("/logout")
    public Response logout(HttpServletRequest request) {
        String header = request.getHeader(Header.AUTHORIZATION.getValue());
        this.userService.handleLogout(header);
        return new Response().code(HttpStatus.OK);
    }

    @GetMapping("/routers")
    public Response getRouters(String userId) {
        Router router = new Router();
        router.setPath("/customer");
        router.setName("customer");
        router.setComponent("Layout");
        RouterMeta meta = new RouterMeta();
        meta.setTitle("单位用户");
        meta.setIcon("md-people");
        meta.setHideInBread(true);
        router.setMeta(meta);
        Router router1 = new Router();
        router1.setPath("/customer/list");
        router1.setName("customer_list");
        router1.setComponent("customer/Customer.vue");
        RouterMeta meta1 = new RouterMeta();
        meta1.setTitle("用户管理");
        meta1.setIcon("md-people");
        meta1.setAccess(Collections.singletonList("ROLE_ADMIN"));
        router1.setMeta(meta1);
        Router router2 = new Router();
        router2.setPath("/customer/list1");
        router2.setName("customer_list1");
        router2.setComponent("customer/Customer.vue");
        RouterMeta meta2 = new RouterMeta();
        meta2.setTitle("用户管理1");
        meta2.setIcon("md-people");
        meta2.setAccess(Collections.singletonList("ROLE_ADMIN"));
        router2.setMeta(meta2);
        router.setChildren(Arrays.asList(router1, router2));
        return new Response().code(HttpStatus.OK).data(Collections.singleton(router));
    }
}
