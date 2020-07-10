package cn.hitek.authorization.ilis2.product.unit.domain.vo;

import lombok.Data;

/**
 * @author chenlm
 */
@Data
public class UnitAccount {

    private String unitCode;
    private String unitName;
    private Integer maxAccount;
    private Integer totalAccount;
    private Integer maxOnlineAccount;
    private Integer onlineAccount;
}
