package cn.hitek.authorization.ilis2.product.unit.domain.vo;

import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @author chenlm
 */
@Data
@NoArgsConstructor
public class UnitInfo {

    private boolean singleLogin;
    private boolean expired;
    private boolean userMaxLimits;
    private boolean userOnlineMaxLimits;
    private DatabaseInfo data;

}
