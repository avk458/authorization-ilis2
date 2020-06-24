package cn.hitek.authorization.ilis2.product.base.mapper;

import cn.hitek.authorization.ilis2.product.base.domain.Permission;
import cn.hitek.authorization.ilis2.product.base.domain.Role;
import cn.hitek.authorization.ilis2.product.base.domain.User;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @author chenlm
 */
@Mapper
public interface UserMapper extends BaseMapper<User> {

    /**
     * 根据用户id获取用户角色
     *
     * @param userId 用户id
     * @return 用户角色集合
     */
    List<Role> getUserRole(@Param("userId") String userId);

    /**
     * 根据用户id获取用户权限
     *
     * @param userId 用户id
     * @return 用户权限结合
     */
    List<Permission> getUserPermission(@Param("userId") String userId);

    /**
     * 获取用户以及关联的角色列表
     *
     * @return user with roles list
     */
    List<User> getUserWithRolesList();

    /**
     * 根据user id 删除用户关联的角色
     *
     * @param userId user id
     */
    void deleteUserRoles(@Param("userId") String userId);

    /**
     * 新增用户角色关联
     *
     * @param userId  user id
     * @param roleIds role id
     */
    void insertUserRoles(@Param("userId") String userId, @Param("roleIds") List<String> roleIds);
}
