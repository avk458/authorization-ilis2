package cn.hitek.authorization.ilis2.config;

import cn.hitek.authorization.ilis2.common.entrypoint.JwtAuthenticationEntryPoint;
import cn.hitek.authorization.ilis2.common.jwt.AuthenticationTokenFilter;
import lombok.Setter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.BeanIds;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

import java.util.List;

/**
 * @author chenlm
 */
@Setter
@Configuration
@EnableWebSecurity
@EnableGlobalMethodSecurity(prePostEnabled = true)
@ConfigurationProperties(prefix = "spring.security")
public class SecurityConfig extends WebSecurityConfigurerAdapter {

    @Autowired
    private JwtAuthenticationEntryPoint authenticationEntryPoint;

    @Autowired
    private AuthenticationTokenFilter authenticationTokenFilter;

    @Qualifier("userDetailServiceImpl")
    @Autowired
    private UserDetailsService userDetailsService;

    private List<String> whiteList;

    @Bean(name = BeanIds.AUTHENTICATION_MANAGER)
    @Override
    public AuthenticationManager authenticationManagerBean() throws Exception {
        return super.authenticationManagerBean();
    }

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        // @formatter:off
        http
            .cors().and().csrf().disable()
            .exceptionHandling().authenticationEntryPoint(authenticationEntryPoint)
            .and()
            .sessionManagement().sessionCreationPolicy(SessionCreationPolicy.STATELESS)
            .and()
            .authorizeRequests()
                .antMatchers(whiteList.toArray(new String[0])).permitAll()
                .anyRequest().authenticated()
            .and()
            .addFilterBefore(authenticationTokenFilter, UsernamePasswordAuthenticationFilter.class)
                .headers().cacheControl();
        // @formatter:on
    }

    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.userDetailsService(userDetailsService).passwordEncoder(passwordEncoder());
    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }


    // @Bean
    // public CorsConfigurationSource corsConfigurationSource() {
    //     final CorsConfiguration configuration = new CorsConfiguration();
    //     configuration.setAllowedOrigins(Collections.unmodifiableList(Collections.singletonList("*")));
    //     configuration.setAllowedMethods(Collections.unmodifiableList(Arrays.asList("HEAD", "GET", "POST", "PUT", "DELETE", "PATCH")));
    //     configuration.setAllowCredentials(true);
    //     configuration.addExposedHeader("Content-Disposition");
    //     // setAllowedHeaders is important! Without it, OPTIONS preflight request
    //     // will fail with 403 Invalid CORS request
    //     configuration.setAllowedHeaders(Collections.unmodifiableList(Arrays.asList("Authorization", "Cache-Control", "Content-Type")));
    //     final UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
    //     source.registerCorsConfiguration("/**", configuration);
    //     return source;
    // }
}
