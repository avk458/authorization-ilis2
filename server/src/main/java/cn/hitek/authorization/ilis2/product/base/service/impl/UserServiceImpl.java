package cn.hitek.authorization.ilis2.product.base.service.impl;

import cn.hitek.authorization.ilis2.common.exception.TokenAuthenticationException;
import cn.hitek.authorization.ilis2.common.jwt.TokenProvider;
import cn.hitek.authorization.ilis2.framework.web.service.impl.BaseServiceImpl;
import cn.hitek.authorization.ilis2.product.base.domain.User;
import cn.hitek.authorization.ilis2.product.base.domain.UserDetail;
import cn.hitek.authorization.ilis2.product.base.domain.dto.UserInfo;
import cn.hitek.authorization.ilis2.product.base.mapper.UserMapper;
import cn.hitek.authorization.ilis2.product.base.service.UserService;
import cn.hutool.core.util.StrUtil;
import cn.hutool.http.Header;
import lombok.AllArgsConstructor;
import org.springframework.data.redis.core.BoundHashOperations;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author chenlm
 */
@Service
@AllArgsConstructor
public class UserServiceImpl extends BaseServiceImpl<UserMapper, User> implements UserService {

    private final AuthenticationManager authenticationManager;
    private final TokenProvider tokenProvider;
    private final RedisTemplate<String, Object> redisTemplate;

    private BoundHashOperations<String, String, Object> tokenStorage() {
        return this.redisTemplate.boundHashOps(Header.AUTHORIZATION.getValue());
    }

    @Override
    public String handleLogin(User loginUser) {
        UsernamePasswordAuthenticationToken upt = new UsernamePasswordAuthenticationToken(loginUser.getUsername(), loginUser.getPassword());
        Authentication authenticate = authenticationManager.authenticate(upt);
        SecurityContextHolder.getContext().setAuthentication(authenticate);
        UserDetail userDetail = (UserDetail) authenticate.getPrincipal();
        tokenStorage().put(userDetail.getUsername(), userDetail);
        return tokenProvider.generateToken(userDetail);
    }

    @Override
    public UserDetail verify(String header) {
        String token = extractBearerToken(header);
        if (StrUtil.isBlank(token)) {
            throw new TokenAuthenticationException("非法请求");
        }
        String username = this.tokenProvider.getUsernameFormToken(token);
        UserDetail userDetail =  (UserDetail) tokenStorage().get(username);
        if (userDetail == null) {
            throw new TokenAuthenticationException("非法请求");
        }
        return userDetail;
    }

    private String extractBearerToken(String token) {
        final String bearer = "Bearer ";
        String tokenStr = null;
        if (StrUtil.isNotBlank(token) && token.startsWith(bearer)) {
            tokenStr = token.substring(bearer.length());
        }
        return tokenStr;
    }

    @Override
    public UserInfo getUserInfo(String header) {
        UserDetail userDetail = verify(header);
        return new UserInfo(userDetail);
    }

    @Override
    public void handleLogout(String header) {
        UserDetail userDetail = verify(header);
        tokenStorage().delete(userDetail.getUsername());
    }

    @Override
    public List<User> getUsers() {
        return query().list();
    }

    @Override
    public boolean validateUsername(String username) {
        return query().eq(User::getUsername, username).exist();
    }

    @Override
    public void updateActiveStatus(String userId) {
        User user = getById(userId);
        user.setActive(!user.getActive());
        super.updateById(user);
    }
}
