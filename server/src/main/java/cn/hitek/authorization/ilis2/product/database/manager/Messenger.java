package cn.hitek.authorization.ilis2.product.database.manager;

import cn.hitek.authorization.ilis2.product.database.helper.LogType;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;

import java.io.IOException;

import static cn.hitek.authorization.ilis2.product.database.helper.EchoLogFactory.createLog;

public class Messenger {

    public static void sendMessage(LogType type, String message) throws IOException {
        WebSocketSession session = SocketManager.get("1234456");
        String log = createLog(type, message);
        session.sendMessage(new TextMessage(log));
    }
}
