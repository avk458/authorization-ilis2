package cn.hitek.authorization.ilis2.common.exception;

import org.springframework.security.core.AuthenticationException;

/**
 * @author chenlm
 */
public class TokenAuthenticationException extends AuthenticationException {

    private static final long serialVersionUID = -6031010114077381468L;

    public TokenAuthenticationException(String msg, Throwable t) {
        super(msg, t);
    }

    public TokenAuthenticationException(String msg) {
        super(msg);
    }
}
