package cn.hitek.authorization.ilis2.product.base.mapper;

import cn.hitek.authorization.ilis2.product.base.domain.Permission;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @author chenlm
 */
@Mapper
public interface PermissionMapper extends BaseMapper<Permission> {

    /**
     * 查询是否有使用的权限
     *
     * @param perm 权限
     * @return 使用数量
     */
    int existsUsingPermission(@Param("perm") List<String> perm);
}
