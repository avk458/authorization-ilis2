package cn.hitek.authorization.ilis2.product.unit.service;

import cn.hitek.authorization.ilis2.framework.web.service.BaseService;
import cn.hitek.authorization.ilis2.product.unit.domain.LoginInfo;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;

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
     * 生成redis单位用户累计登录key
     * @param unitCode 单位编码
     * @return key
     */
    String getTotalUsersKey(String unitCode);

    /**
     * 添加用户会话到在线用户
     * @param token sessionId
     */
    void addOnlineUser(String token);

    /**
     * 从在线用户中删除用户会话
     * @param token sessionId
     */
    void removeOnlineUser(String token);

    /**
     * 获取单位在线用户数量
     * @param uniqCode 单位编码
     * @return 在线用户数量
     */
    Integer getUnitOnlineUsers(String uniqCode);

    /**
     * 根据单位编码查询单位用户登录日志
     * @param unitCode 单位编码
     * @param page page
     * @return 分页
     */
    IPage<LoginInfo> getLogsViaUnitCode(String unitCode, Page<LoginInfo> page);

    /**
     * 根据单位code获取该单位在线用户集合
     * @param unitCode 单位编码
     * @param page page
     * @return 分页
     */
    IPage<LoginInfo> getUnitOnlineAccounts(String unitCode, Page<LoginInfo> page);

    /**
     * 如果用户登录日志缓冲区有数据，则将日志入库
     */
    void flushLogIfPresent();
}
