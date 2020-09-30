package cn.hitek.authorization.ilis2.framework.socket.manager;

import lombok.extern.log4j.Log4j2;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.concurrent.ConcurrentHashMap;

/**
 * socket管理器
 *
 * @author chenlm
 */
@Log4j2
public class SocketManager {

    private static final ConcurrentHashMap<String, List<WebSocketSession>> SESSION_CONTAINER = new ConcurrentHashMap<>();

    public static void add(String key, WebSocketSession webSocketSession) {
        SESSION_CONTAINER.computeIfAbsent(key, k -> new ArrayList<>(1)).add(webSocketSession);
        log.debug("新添加webSocket连接 {}，当前连接数：{}", key, SESSION_CONTAINER.size());
    }

    public static void remove(String key) {
        SESSION_CONTAINER.remove(key);
        log.debug("移除webSocket连接 {}，当前连接数：{}", key, SESSION_CONTAINER.size());
    }

    public static List<WebSocketSession> get(String key) {
        log.debug("获取webSocket连接 {}", key);
        return SESSION_CONTAINER.get(key);
    }

    public static void destroySession(String key) throws IOException {
        List<WebSocketSession> sessions = get(key);
        sessions = Optional.ofNullable(sessions).orElse(new ArrayList<>(0));
        for (WebSocketSession session : sessions) {
            session.sendMessage(new TextMessage("offline"));
            session.close();
        }
        remove(key);
        log.debug("销毁session {}", key);
    }

    public static void closeConnection(String sessionId) throws IOException {
        List<WebSocketSession> sessions = get(sessionId);
        sessions = Optional.ofNullable(sessions).orElse(new ArrayList<>(0));
        for (WebSocketSession session : sessions) {
            session.sendMessage(new TextMessage("sessionExpired"));
            session.close();
        }
        remove(sessionId);
    }
}


