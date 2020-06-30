package cn.hitek.authorization.ilis2.product.unit.domain;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDateTime;

/**
 * @author chenlm
 */
@Data
@TableName("t_unit_user_login_log")
public class LoginInfo {

    @TableId
    private Long id;
    private LocalDateTime operationTime;
    private String userId;
    private String username;
    private String realName;
    private String unitCode;
    private Boolean login;
    private String loginIp;
    private String remark;
}
