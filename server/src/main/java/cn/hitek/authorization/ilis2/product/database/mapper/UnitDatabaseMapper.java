package cn.hitek.authorization.ilis2.product.database.mapper;

import cn.hitek.authorization.ilis2.product.database.domain.UnitDatabase;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

/**
 * @author chenlm
 */
@Mapper
public interface UnitDatabaseMapper extends BaseMapper<UnitDatabase> {


    /**
     * 根据id升级数据库数据版本
     *
     * @param id      数据库id
     * @param version 数据版本
     */
    void updateDataVersion(@Param("id") String id, @Param("version") Long version);
}
