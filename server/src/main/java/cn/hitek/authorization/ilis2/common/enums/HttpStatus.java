package cn.hitek.authorization.ilis2.common.enums;

import lombok.Getter;

/**
 * @author chenlm
 */
@Getter
public enum HttpStatus {

    /**
     * 正常
     */
    OK(20000),
    /**
     * 无权限
     */
    NO_AUTH(20020),
    /**
     * 新增成功
     */
    ADD(20100),
    /**
     * 失败
     */
    FAIL(20010),
    /**
     * 修改成功
     */
    UPDATE(20200),
    /**
     * 删除成功
     */
    DELETE(20300);

    private final int code;

    HttpStatus(int code) {
        this.code = code;
    }
}
