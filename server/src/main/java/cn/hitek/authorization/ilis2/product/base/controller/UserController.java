package cn.hitek.authorization.ilis2.product.base.controller;

import cn.hitek.authorization.ilis2.common.enums.HttpStatus;
import cn.hitek.authorization.ilis2.common.response.Response;
import cn.hitek.authorization.ilis2.common.validation.group.OnCreate;
import cn.hitek.authorization.ilis2.common.validation.group.OnUpdate;
import cn.hitek.authorization.ilis2.product.base.domain.User;
import cn.hitek.authorization.ilis2.product.base.domain.dto.UserInfo;
import cn.hitek.authorization.ilis2.product.base.service.UserService;
import cn.hutool.core.util.StrUtil;
import cn.hutool.http.Header;
import lombok.AllArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.validation.constraints.NotBlank;
import java.util.List;

/**
 * @author chenlm
 */
@RestController
@RequestMapping("user")
@AllArgsConstructor
public class UserController {

    private final UserService userService;
    private final PasswordEncoder passwordEncoder;

    @GetMapping("/info")
    public Response getUserInfo(HttpServletRequest request) {
        String header = request.getHeader(Header.AUTHORIZATION.getValue());
        UserInfo info = this.userService.getUserInfo(header);
        return new Response().code(HttpStatus.OK).data(info);
    }

    @PostMapping
    public Response addUser(@Validated(OnCreate.class) @RequestBody User user) {
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        user.setAvatar("https://i.loli.net/2017/08/21/599a521472424.jpg");
        this.userService.save(user);
        return new Response().code(HttpStatus.ADD);
    }

    @PutMapping
    public Response updateUser(@Validated(OnUpdate.class) @RequestBody User user) {
        if (StrUtil.isNotBlank(user.getPassword())) {
            user.setPassword(passwordEncoder.encode(user.getPassword()));
        }
        this.userService.updateById(user);
        return new Response().code(HttpStatus.UPDATE);
    }

    @DeleteMapping("/{userId}")
    public Response deleteUser(@PathVariable String userId) {
        this.userService.removeById(userId);
        return new Response().code(HttpStatus.DELETE);
    }

    @GetMapping("/list")
    public Response getUsers() {
        List<User> users = this.userService.getUsers();
        return new Response().code(HttpStatus.OK).data(users);
    }

    @Validated
    @PostMapping("/actions/validate-username")
    public Response validateUsername(@NotBlank(message = "请求参数有误") String username) {
        boolean valid = this.userService.validateUsername(username);
        return new Response().code(HttpStatus.OK).data(valid);
    }

    @Validated
    @PostMapping("/actions/update-active-state")
    public Response updateActiveStatus(@NotBlank(message = "请求参数有误") String userId) {
        this.userService.updateActiveStatus(userId);
        return new Response().code(HttpStatus.UPDATE);
    }
}
