package cn.hitek.authorization.ilis2.product.database.domain.vo;

import lombok.Data;
import lombok.NonNull;
import lombok.RequiredArgsConstructor;

/**
 * @author chenlm
 */
@RequiredArgsConstructor
@Data
public class UpdateEchoLog {

    @NonNull
    private Long scriptVersion;
    @NonNull
    private String sqlScript;
    @NonNull
    private String unitName;
    private Boolean success;
    private String msg;
}
