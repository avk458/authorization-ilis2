package cn.hitek.authorization.ilis2.product.unit.domain;

import cn.hutool.core.builder.EqualsBuilder;
import cn.hutool.core.builder.HashCodeBuilder;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.fasterxml.jackson.datatype.jsr310.deser.LocalDateTimeDeserializer;
import com.fasterxml.jackson.datatype.jsr310.ser.LocalDateTimeSerializer;
import lombok.Data;

import java.time.LocalDateTime;

/**
 * @author chenlm
 */
@Data
@TableName("t_unit_user_login_log")
public class LoginInfo {

    public static final int LOGIN = 100;
    public static final int LOGOUT = 110;
    public static final int KICK_OUT = 120;
    public static final int TIME_OUT = 130;

    @TableId
    private Long id;
    @JsonSerialize(using = LocalDateTimeSerializer.class)
    @JsonDeserialize(using = LocalDateTimeDeserializer.class)
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime operationTime;
    private String userId;
    private String username;
    private String realName;
    private String unitCode;
    private int operationType;
    private String loginIp;
    private String sessionId;
    private String loginRegion;
    private String os;
    private String browser;

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }

        if (o == null || getClass() != o.getClass()) {
            return false;
        }

        LoginInfo info = (LoginInfo) o;

        return new EqualsBuilder()
                .append(userId, info.userId)
                .append(sessionId, info.sessionId)
                .append(unitCode, info.unitCode)
                .append(operationType, info.operationType)
                .isEquals();
    }

    @Override
    public int hashCode() {
        return new HashCodeBuilder(17, 37)
                .append(userId)
                .append(sessionId)
                .append(unitCode)
                .append(operationType)
                .toHashCode();
    }
}
