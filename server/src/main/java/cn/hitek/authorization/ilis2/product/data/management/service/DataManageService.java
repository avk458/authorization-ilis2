package cn.hitek.authorization.ilis2.product.data.management.service;

import cn.hitek.authorization.ilis2.product.data.management.domain.DatabaseInfo;
import cn.hitek.authorization.ilis2.product.database.domain.UnitDatabase;

import java.util.List;

/**
 * @author chenlm
 */
public interface DataManageService {

    /**
     * 获取单位数据库相关信息
     * @param unitDatabaseList 单位数据库集合
     * @return result
     */
    List<DatabaseInfo> getUnitDatabaseList(List<UnitDatabase> unitDatabaseList);
}
