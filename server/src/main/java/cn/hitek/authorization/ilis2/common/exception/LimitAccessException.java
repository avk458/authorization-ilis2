package cn.hitek.authorization.ilis2.common.exception;

/**
 * @author chenlm
 */
public class LimitAccessException extends Throwable implements CustomException {

    private static final long serialVersionUID = -4953446100335022808L;

    public LimitAccessException(String msg) {
        super(msg);
    }
}
