package cn.hitek.authorization.ilis2.product.unit.domain;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.fasterxml.jackson.datatype.jsr310.deser.LocalDateDeserializer;
import com.fasterxml.jackson.datatype.jsr310.ser.LocalDateSerializer;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.NonNull;
import lombok.RequiredArgsConstructor;

import java.time.LocalDate;

/**
 * @author chenlm
 */
@Data
@TableName("t_unit_user_online_log")
@RequiredArgsConstructor
@NoArgsConstructor
public class UnitUserOnlineLog {

    @TableId
    private Long id;

    @NonNull
    @JsonSerialize(using = LocalDateSerializer.class)
    @JsonDeserialize(using = LocalDateDeserializer.class)
    private LocalDate logTime;

    @NonNull
    private String unitCode;

    @NonNull
    private Integer onlineMembers;

}
