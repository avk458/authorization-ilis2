package cn.hitek.authorization.ilis2.product.base.service;

import cn.hitek.authorization.ilis2.framework.web.service.BaseService;
import cn.hitek.authorization.ilis2.product.base.domain.User;
import cn.hitek.authorization.ilis2.product.base.domain.UserDetail;
import cn.hitek.authorization.ilis2.product.base.domain.dto.UserInfo;
import cn.hitek.authorization.ilis2.product.base.domain.vo.PostUserPwd;
import cn.hitek.authorization.ilis2.product.base.domain.vo.PostUserRoles;

import java.util.List;

/**
 * @author chenlm
 */
public interface UserService extends BaseService<User> {

    /**
     * 验证用户
     * @param loginUser 登录信息
     * @return token
     */
    String handleLogin(User loginUser);

    /**
     * 根据token验证访问是否合法
     * @param token token
     * @return user detail
     */
    UserDetail verify(String token);

    /**
     * 根据授权请求头获取用户相关信息
     * @param header 请求头
     * @return 用户信息
     */
    UserInfo getUserInfo(String header);

    /**
     * 用户登出
     * @param header 请求头
     */
    void handleLogout(String header);

    /**
     * 获取用户列表
     * @return 用户列表
     */
    List<User> getUsers();

    /**
     * 验证新增用户时，用户名是否合法/重复
     * @param username 用户输入的用户名
     * @return 验证结果
     */
    boolean validateUsername(String username);

    /**
     * 设置用户启用状态
     * @param userId 用户id
     */
    void updateActiveStatus(String userId);

    /**
     * 关联用户角色
     * @param userRoles 封装对象
     */
    void setUserRoles(PostUserRoles userRoles);

    /**
     * 删除用户
     * @param userId user id
     */
    void deleteUser(String userId);

    /**
     * 用户修改密码
     * @param userPwd 参数封装
     */
    void changeUserPassword(PostUserPwd userPwd);
}
