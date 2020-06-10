package cn.hitek.authorization.ilis2.product.data.management.mapper;

import cn.hitek.authorization.ilis2.product.data.management.domain.DataScript;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;

/**
 * @author chenlm
 */
@Mapper
public interface DataScriptMapper extends BaseMapper<DataScript> {

    /**
     * 获取最大id
     * @return id
     */
    Long getLastId();
}
