package cn.hitek.authorization.ilis2.product.base.service.impl;

import cn.hitek.authorization.ilis2.product.base.domain.Permission;
import cn.hitek.authorization.ilis2.product.base.domain.Role;
import cn.hitek.authorization.ilis2.product.base.domain.User;
import cn.hitek.authorization.ilis2.product.base.domain.UserDetail;
import cn.hitek.authorization.ilis2.product.base.mapper.UserMapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import lombok.AllArgsConstructor;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author chenlm
 */
@Service
@AllArgsConstructor
public class UserDetailServiceImpl implements UserDetailsService {

    private final UserMapper userMapper;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        User sysUser = this.userMapper.selectOne(Wrappers.lambdaQuery(User.class).eq(User::getUsername, username));
        if (sysUser == null) {
            throw new UsernameNotFoundException(String.format("'%s'，这个用户不存在", username));
        }
        List<Role> roles = this.userMapper.getUserRole(sysUser.getId());
        List<Permission> permissions = this.userMapper.getUserPermission(sysUser.getId());
        return new UserDetail(sysUser, permissions);
    }
}
