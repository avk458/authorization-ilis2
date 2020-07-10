package cn.hitek.authorization.ilis2.product.unit.mapper;

import cn.hitek.authorization.ilis2.product.unit.domain.UnitUserOnlineLog;
import cn.hitek.authorization.ilis2.product.unit.domain.dto.WeekOnline;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * @author chenlm
 */
@Mapper
public interface UnitUserOnlineLogMapper extends BaseMapper<UnitUserOnlineLog> {

    /**
     * mysql 统计周活跃用户
     * @return 统计信息
     */
    List<WeekOnline> getWeekStatisticData();
}
