package cn.hitek.authorization.ilis2.product.unit.service;

import cn.hitek.authorization.ilis2.framework.web.service.BaseService;
import cn.hitek.authorization.ilis2.product.unit.domain.LoginInfo;
import cn.hitek.authorization.ilis2.product.unit.domain.Unit;
import cn.hitek.authorization.ilis2.product.unit.domain.vo.UnitAccount;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;

import java.util.List;
import java.util.Map;

/**
 * @author chenlm
 */
public interface UnitService extends BaseService<Unit>{

    /**
     * 检测单位唯一识别码是否存在
     * @param code 识别码
     * @return 检测结果
     */
    boolean validateCode(String code);

    /**
     * 根据单位id，删除单位信息和单位数据库信息
     * @param unitId 单位id
     */
    void removeUnitInfoAndDatabaseInfoViaUnitId(String unitId);

    /**
     * 新增单位信息并新增单位数据库信息
     * @param unit 单位实体
     * @return unit database id
     */
    String insertUnitInfo(Unit unit);

    /**
     * ilis2 程序根据单位识别码获取单位信息单位数据库信息
     * @param code 单位识别码
     * @return 加密字符串
     */
    String getUnitInfo(String code);

    /**
     * 修改单位单点登录状态
     * @param unitId 单位id
     */
    void updateUnitLoginPolicy(String unitId);

    /**
     * 记录单位用户登录日志
     * @param loginInfo 登录信息
     */
    void logUserLogin(LoginInfo loginInfo);

    /**
     * 所有单位累计用户数
     * @return 所有单位累计用户数
     */
    Map<String, Integer> combineUnitUsers();

    /**
     * 单位用户占比
     * @return 用户占比数据
     */
    List<Map<String, Object>> getUnitUserPie();

    /**
     * 获取周活跃用户
     * @return 统计数据
     */
    Map<String, Integer> getWeekOnlineStatisticData();

    /**
     * 获取当前各单位在线人数
     * @return 各单位在线人数统计
     */
    Map<String, int[]> getCurrentOnlineData();

    /**
     * 获取单位用户相关数据
     * @return 单位用户相关数据
     */
    List<UnitAccount> getUnitAccountData();

    /**
     * 单位用户会话是否在线
     * @param userId user id
     * @param code 单位编码
     * @return 结果
     */
    Boolean isUnitSessionOnline(String userId, String code);

    /**
     * 获取分页单位信息集合
     * @param page 分页参数
     * @return 分页数据
     */
    IPage<Unit> getPageRecords(Page<Unit> page);
}
