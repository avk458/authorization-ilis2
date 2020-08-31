package cn.hitek.authorization.ilis2.common.exception;

/**
 * @author chenlm
 */
public class ValidateFailureException extends Throwable implements CustomException {

    private static final long serialVersionUID = -8498565978187260967L;

    public ValidateFailureException(String message) {
        super(message);
    }
}
