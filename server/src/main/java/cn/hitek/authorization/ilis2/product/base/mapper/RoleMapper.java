package cn.hitek.authorization.ilis2.product.base.mapper;

import cn.hitek.authorization.ilis2.product.base.domain.Permission;
import cn.hitek.authorization.ilis2.product.base.domain.Role;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @author chenlm
 */
@Mapper
public interface RoleMapper extends BaseMapper<Role> {
    /**
     * 连表查询角色是否有关联用户
     *
     * @param roleId 角色id
     * @return 查询结果
     */
    Integer roleReference(@Param("roleId") String roleId);

    /**
     * 根据角色id获取关联的权限
     *
     * @param roleId 角色id
     * @return 权限集合
     */
    List<Permission> getRolePermissions(@Param("roleId") String roleId);

    /**
     * 新增角色权限
     *
     * @param roleId        角色id
     * @param permissionIds 权限ids
     */
    void insertRolePermissions(@Param("roleId") String roleId, @Param("permissionIds") List<String> permissionIds);

    /**
     * 批量获取角色权限
     *
     * @return RolePermission
     */
    List<Role> getRolePermissionsBatch();

    /**
     * 根据角色id删除角色下关联的权限
     *
     * @param roleId 角色id
     */
    void deletePermissionByRoleId(@Param("roleId") String roleId);
}
