package cn.hitek.authorization.ilis2.product.data.management.domain;

import lombok.AllArgsConstructor;
import lombok.Data;

/**
 * @author chenlm
 */
@Data
@AllArgsConstructor
public class Schema {

    private String key;
    private String label;
    private boolean disabled;
}
