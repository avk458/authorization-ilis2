package cn.hitek.authorization.ilis2.common.jwt;

import cn.hitek.authorization.ilis2.product.base.domain.UserDetail;
import com.auth0.jwt.JWT;
import com.auth0.jwt.JWTVerifier;
import com.auth0.jwt.algorithms.Algorithm;
import com.auth0.jwt.exceptions.JWTCreationException;
import com.auth0.jwt.exceptions.JWTDecodeException;
import com.auth0.jwt.exceptions.JWTVerificationException;
import com.auth0.jwt.interfaces.DecodedJWT;
import lombok.Getter;
import lombok.Setter;
import lombok.extern.log4j.Log4j2;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

import java.util.Date;

/**
 * @author chenlm
 */
@Log4j2
@Getter
@Setter
@Component
@ConfigurationProperties(prefix = "spring.security.auth0")
public class TokenProvider {

    private String publicKey;
    private Long expiresAt;

    public String generateToken(UserDetail userDetail) {
        try {
            Algorithm algorithm = Algorithm.HMAC256(this.publicKey);
            return JWT
                    .create()
                    .withClaim("username", userDetail.getUsername())
                    .withExpiresAt(new Date(expiresAt * 60 * 1000))
                    .sign(algorithm);
        } catch (JWTCreationException e) {
            log.warn("token生成失败！{}", e.getMessage());
        }
        return null;
    }

    public void verifyToken(String token) {
        try {
            Algorithm algorithm = Algorithm.HMAC256(this.publicKey);
            JWTVerifier verifier = JWT.require(algorithm).build();
            verifier.verify(token);
        } catch (JWTVerificationException e) {
            log.warn("token检校失败！{}", e.getMessage());
        }
    }

    public String getUsernameFormToken(String token) {
        String username = null;
        try {
            DecodedJWT decode = JWT.decode(token);
            username = decode.getClaim("username").asString();
        } catch (JWTDecodeException e) {
            log.warn("token检校失败，{}", e.getMessage());
        }
        return username;
    }
}
