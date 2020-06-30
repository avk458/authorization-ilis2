package cn.hitek.authorization.ilis2.product.unit.domain.vo;

import cn.hitek.authorization.ilis2.common.utils.EncryptUtil;
import cn.hitek.authorization.ilis2.product.database.domain.UnitDatabase;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @author chenlm
 */
@Data
@NoArgsConstructor
public class DatabaseInfo {

    private String host;
    private Integer port;
    private String schema;
    private String username;
    private String password;

    public DatabaseInfo(UnitDatabase unitDatabase) {
        this.host = unitDatabase.getHost();
        this.port = unitDatabase.getPort();
        this.schema = unitDatabase.getDatabaseName();
        this.username = EncryptUtil.decrypt(unitDatabase.getDatabaseUsername());
        this.password = EncryptUtil.decrypt(unitDatabase.getDatabasePwd());
    }
}
