package cn.hitek.authorization.ilis2.product.unit.service;

import cn.hitek.authorization.ilis2.framework.socket.manager.WsToken;
import cn.hitek.authorization.ilis2.framework.web.service.BaseService;
import cn.hitek.authorization.ilis2.product.unit.domain.ClientAccount;
import cn.hitek.authorization.ilis2.product.unit.domain.LoginInfo;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;

import java.util.Map;

/**
 * @author chenlm
 */
public interface UnitUserLogger extends BaseService<LoginInfo> {

    /**
     * 单位用户登录记录入库
     * @param loginInfo 记录实体
     */
    void handleLoginLog(LoginInfo loginInfo);

    /**
     * 单位用户登录统计信息缓存
     * @param loginInfo 记录实体
     */
    void handleLoginStatisticLog(LoginInfo loginInfo);

    /**
     * 添加用户会话到在线用户
     * @param token ws token
     */
    void addAccountSession(WsToken token);

    /**
     * 从在线用户中删除用户会话
     * @param token ws token
     */
    void removeAccountSession(WsToken token);

    /**
     * 获取单位在线用户数量，有效会话数量
     * @param uniqCode 单位编码
     * @return 在线用户数量
     */
    Integer getUnitOnlineAccounts(String uniqCode);

    /**
     * 根据单位编码查询单位用户登录日志
     * @param unitCode 单位编码
     * @param page page
     * @return 分页
     */
    IPage<LoginInfo> getUnitAccountLogs(String unitCode, Page<LoginInfo> page);

    /**
     * 根据单位code获取该单位在线用户集合
     * @param unitCode 单位编码
     * @param userid user id
     * @param sessionIds sessions
     * @param page page
     * @return 分页
     */
    IPage<LoginInfo> getUnitOnlineAccounts(String unitCode, String userid, String sessionIds, Page<LoginInfo> page);

    /**
     * 如果用户登录日志缓冲区有数据，则将日志入库
     */
    void flushLogIfPresent();

    /**
     * 检测用户是否在线
     * @param userId 用户id
     * @param code 单位编码
     * @return 是否在线
     */
    Boolean isUserOnline(String userId, String code);

    /**
     * 获取单位用户总数
     * @param unitCode 单位编码
     * @return 用户总数
     */
    int getUnitTotalAccounts(String unitCode);

    /**
     * 获取对应单位所有用户
     * @param unitCode 单位编码
     * @param page 分页参数
     * @return 用户数据
     */
    IPage<ClientAccount> getClientAccounts(String unitCode, Page<ClientAccount> page);

    /**
     * 获取指定用户登录日志
     * @param unitCode 单位编码
     * @param userId 用户id
     * @param page 分页参数
     * @return 登录日志
     */
    IPage<LoginInfo> getAccountLogs(String unitCode, String userId, Page<LoginInfo> page);

    /**
     * 获取所有单位用户数量以及在线数量
     * @return 统计信息
     */
    Map<String, Integer> combineAccounts();
}
