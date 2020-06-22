package cn.hitek.authorization.ilis2.common.jwt;

import cn.hitek.authorization.ilis2.common.entrypoint.JwtAuthenticationEntryPoint;
import cn.hitek.authorization.ilis2.product.base.domain.UserDetail;
import cn.hitek.authorization.ilis2.product.base.service.UserService;
import cn.hutool.core.util.StrUtil;
import cn.hutool.http.Header;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * @author chenlm
 */
@Component
public class AuthenticationTokenFilter extends OncePerRequestFilter {

    @Autowired
    private UserService userService;
    @Autowired
    private JwtAuthenticationEntryPoint authenticationEntryPoint;

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain) throws ServletException, IOException {
        String header = request.getHeader(Header.AUTHORIZATION.getValue());
        if (StrUtil.isNotBlank(header)) {
            // verify token
            try {
                UserDetail userDetail = this.userService.verify(header);
                setAuthentication2Context(userDetail, request);
            } catch (AuthenticationException e) {
                SecurityContextHolder.clearContext();
                authenticationEntryPoint.commence(request, response, e);
            }
        }
        filterChain.doFilter(request, response);
    }

    private void setAuthentication2Context(UserDetail userDetail, HttpServletRequest request) {
        UsernamePasswordAuthenticationToken authenticationToken = new UsernamePasswordAuthenticationToken(
                userDetail,
                userDetail.getPassword(),
                userDetail.getAuthorities()
        );
        authenticationToken.setDetails(new WebAuthenticationDetailsSource().buildDetails(request));
        SecurityContextHolder.getContext().setAuthentication(authenticationToken);
    }
}
