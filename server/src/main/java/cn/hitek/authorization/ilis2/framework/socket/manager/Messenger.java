package cn.hitek.authorization.ilis2.framework.socket.manager;

import cn.hitek.authorization.ilis2.product.database.helper.LogType;

import java.io.IOException;

// import org.springframework.web.socket.TextMessage;
// import org.springframework.web.socket.WebSocketSession;

/**
 * @author chenlm
 */
public class Messenger {

    public static void sendMessage(LogType type, String message) throws IOException {
        // UserDetail userDetail = (UserDetail) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        // WebSocketSession session = SocketManager.get(userDetail.getUserId());
        // String log = createLog(type, message);
        // session.sendMessage(new TextMessage(log));
    }
}
