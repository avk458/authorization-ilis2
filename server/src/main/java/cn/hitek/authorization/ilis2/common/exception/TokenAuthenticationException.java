package cn.hitek.authorization.ilis2.common.exception;

import org.springframework.security.core.AuthenticationException;

/**
 * @author chenlm
 */
public class TokenAuthenticationException extends AuthenticationException {

    public TokenAuthenticationException(String msg, Throwable t) {
        super(msg, t);
    }

    public TokenAuthenticationException(String msg) {
        super(msg);
    }
}
