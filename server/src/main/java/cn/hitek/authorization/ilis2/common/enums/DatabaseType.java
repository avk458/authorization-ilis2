package cn.hitek.authorization.ilis2.common.enums;

import lombok.Getter;

/**
 * @author chenlm
 */
@Getter
public enum DatabaseType {

    /**
     * mysql
     */
    MYSQL(211),
    /**
     * postgre sql
     */
    POSTGRE_SQL(222),
    /**
     * microsoft sql
     */
    MICROSOFT_SQL(233);

    private final int type;

    DatabaseType(int type) {
        this.type = type;
    }
}
