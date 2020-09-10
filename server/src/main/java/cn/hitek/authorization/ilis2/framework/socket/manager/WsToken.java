package cn.hitek.authorization.ilis2.framework.socket.manager;

import lombok.AllArgsConstructor;
import lombok.Data;

/**
 * @author chenlm
 */
@Data
@AllArgsConstructor
public class WsToken {

    private String unitCode;
    private String userId;
    private String sessionId;
}
