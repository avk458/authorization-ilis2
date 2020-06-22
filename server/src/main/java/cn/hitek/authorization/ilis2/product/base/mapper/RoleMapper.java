package cn.hitek.authorization.ilis2.product.base.mapper;

import cn.hitek.authorization.ilis2.product.base.domain.Role;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

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
}
