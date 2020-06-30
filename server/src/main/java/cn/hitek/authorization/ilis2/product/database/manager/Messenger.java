package cn.hitek.authorization.ilis2.product.database.manager;

import cn.hitek.authorization.ilis2.product.base.domain.UserDetail;
import cn.hitek.authorization.ilis2.product.database.helper.LogType;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;

import java.io.IOException;

import static cn.hitek.authorization.ilis2.product.database.helper.EchoLogFactory.createLog;

// import org.springframework.web.socket.TextMessage;
// import org.springframework.web.socket.WebSocketSession;

/**
 * @author chenlm
 */
public class Messenger {

    public static void sendMessage(LogType type, String message) throws IOException {
        UserDetail userDetail = (UserDetail) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        WebSocketSession session = SocketManager.get(userDetail.getUserId());
        String log = createLog(type, message);
        session.sendMessage(new TextMessage(log));
    }
}
