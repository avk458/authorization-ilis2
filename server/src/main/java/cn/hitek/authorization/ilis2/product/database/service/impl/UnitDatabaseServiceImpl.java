package cn.hitek.authorization.ilis2.product.database.service.impl;

import cn.hitek.authorization.ilis2.common.exception.BusinessException;
import cn.hitek.authorization.ilis2.common.utils.FileUtil;
import cn.hitek.authorization.ilis2.framework.web.service.impl.BaseServiceImpl;
import cn.hitek.authorization.ilis2.product.database.domain.UnitDatabase;
import cn.hitek.authorization.ilis2.product.database.helper.ConnectionHandler;
import cn.hitek.authorization.ilis2.product.database.mapper.UnitDatabaseMapper;
import cn.hitek.authorization.ilis2.product.database.service.UnitDatabaseService;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.Set;

/**
 * @author chenlm
 */
@Service
@Slf4j
public class UnitDatabaseServiceImpl extends BaseServiceImpl<UnitDatabaseMapper, UnitDatabase> implements UnitDatabaseService {

    @Override
    public void initUnitDatabase(String unitDatabaseId) {
        // 1. export
        // 2. initialize
        UnitDatabase database = baseMapper.selectById(unitDatabaseId);
        try {
            Connection connection = ConnectionHandler.getConnection(database);

        } catch (SQLException e) {
            log.debug("创建数据库链接失败！{}", e.getMessage());
            e.printStackTrace();
        }
    }

    @Override
    public boolean isUnitDatabaseInitialized(String unitId) {
        return query().eq(StringUtils.isNotBlank(unitId), UnitDatabase::getUnitId, unitId)
                .eq(UnitDatabase::getIsInitialized, UnitDatabase.INITIALIZED)
                .exist();
    }

    @Override
    public boolean isDatabaseNameIllegally(String name) {
        Set<String> mySqlDatabaseNameKeyWords = FileUtil.getMySqlDatabaseNameKeyWords();
        return mySqlDatabaseNameKeyWords.contains(name.toLowerCase());
    }

    @Override
    public void removeUnitDatabaseInfoViaUnitId(String unitId) {
        boolean remove = super.remove(Wrappers.lambdaQuery(UnitDatabase.class)
                .eq(UnitDatabase::getUnitId, unitId)
                .eq(UnitDatabase::getIsInitialized, !UnitDatabase.INITIALIZED));
        if (!remove) {
            throw new BusinessException("删除失败！不能删除正在使用的数据库信息");
        }
    }
}
