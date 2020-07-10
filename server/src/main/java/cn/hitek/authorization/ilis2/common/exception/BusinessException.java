package cn.hitek.authorization.ilis2.common.exception;

/**
 * @author chenlm
 */
public class BusinessException extends RuntimeException implements CustomException {

    private static final long serialVersionUID = 2426705453106108728L;

    public BusinessException(String message) {
        super(message);
    }
}
