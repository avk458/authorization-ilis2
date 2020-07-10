package cn.hitek.authorization.ilis2.product.data.script.mapper;

import cn.hitek.authorization.ilis2.product.base.domain.UserDetail;
import cn.hitek.authorization.ilis2.product.data.script.domain.DataScript;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

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

    /**
     * 交换脚本顺序
     *
     * @param id1 id1
     * @param id2 id2
     * @param userDetail user info
     */
    void scriptExchange(@Param("id1") String id1, @Param("id2") String id2, @Param("userDetail") UserDetail userDetail);
}
