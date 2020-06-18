package cn.hitek.authorization.ilis2.common.jwt;

import cn.hitek.authorization.ilis2.common.entrypoint.JwtAuthenticationEntryPoint;
import cn.hitek.authorization.ilis2.product.base.domain.UserDetail;
import cn.hitek.authorization.ilis2.product.base.service.UserService;
import cn.hutool.core.util.StrUtil;
import cn.hutool.http.Header;
import lombok.AllArgsConstructor;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.context.SecurityContextHolder;
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
@AllArgsConstructor
public class AuthenticationTokenFilter extends OncePerRequestFilter {

    private final UserService userService;
    private final JwtAuthenticationEntryPoint authenticationEntryPoint;

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain) throws ServletException, IOException {
        String header = request.getHeader(Header.AUTHORIZATION.getValue());
        if (StrUtil.isNotBlank(header)) {
            // verify token
            try {
                UserDetail userDetail = this.userService.verify(header);
                setAuthentication2Context(userDetail);
            } catch (AuthenticationException e) {
                SecurityContextHolder.clearContext();
                authenticationEntryPoint.commence(request, response, e);
            }
        } else {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED);
        }
        filterChain.doFilter(request, response);
    }

    private void setAuthentication2Context(UserDetail userDetail) {
        UsernamePasswordAuthenticationToken authenticationToken = new UsernamePasswordAuthenticationToken(
                userDetail.getUsername(),
                userDetail.getPassword(),
                userDetail.getAuthorities()
        );
        SecurityContextHolder.getContext().setAuthentication(authenticationToken);
    }
}
