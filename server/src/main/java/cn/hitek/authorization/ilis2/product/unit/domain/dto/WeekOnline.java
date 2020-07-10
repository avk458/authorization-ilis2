package cn.hitek.authorization.ilis2.product.unit.domain.dto;

import lombok.Data;

import java.time.LocalDate;

/**
 * @author chenlm
 */
@Data
public class WeekOnline {

    private LocalDate logTime;
    private Integer members;
}
