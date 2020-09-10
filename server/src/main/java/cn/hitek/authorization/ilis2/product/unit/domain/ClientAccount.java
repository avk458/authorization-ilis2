package cn.hitek.authorization.ilis2.product.unit.domain;

import cn.hutool.core.map.MapUtil;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.fasterxml.jackson.datatype.jsr310.deser.LocalDateTimeDeserializer;
import com.fasterxml.jackson.datatype.jsr310.ser.LocalDateTimeSerializer;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;

/**
 * @author chenlm
 */
@Data
@NoArgsConstructor
@TableName("t_client_account")
public class ClientAccount implements Serializable {

    private static final long serialVersionUID = 2675035834357717329L;

    public ClientAccount(LoginInfo loginInfo) {
        this.userId = loginInfo.getUserId();
        this.unitCode = loginInfo.getUnitCode();
        this.username = loginInfo.getUsername();
        this.realName = loginInfo.getRealName();
    }

    @TableId
    private Long id;
    private String userId;
    private String username;
    private String realName;
    private String unitCode;
    @JsonSerialize(using = LocalDateTimeSerializer.class)
    @JsonDeserialize(using = LocalDateTimeDeserializer.class)
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime lastOperations;
    @TableField(exist = false)
    private boolean isOnline;
    @TableField(exist = false)
    private Map<String, LocalDateTime> sessions;
    private Long loginTimes;

    public boolean isOnline() {
        return getSessions().size() > 0;
    }

    public Map<String, LocalDateTime> getSessions() {
        return getOnlineSessions();
    }

    @JsonIgnore
    private Map<String, LocalDateTime> getOnlineSessions() {
        sessions = Optional
                .ofNullable(sessions)
                .orElse(MapUtil.empty())
                .entrySet()
                .stream()
                .filter(e -> e.getValue().plus(2, ChronoUnit.MINUTES).isAfter(LocalDateTime.now()))
                .collect(Collectors.toMap(Map.Entry::getKey, Map.Entry::getValue));
        return sessions;
    }
}
