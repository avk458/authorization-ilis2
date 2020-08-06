package cn.hitek.authorization.ilis2.framework.socket.manager;

import lombok.extern.log4j.Log4j2;
import org.springframework.web.socket.WebSocketSession;

import java.io.IOException;
import java.util.concurrent.ConcurrentHashMap;

/**
 * socket管理器
 *
 * @author chenlm
 */
@Log4j2
public class SocketManager {

    private static final ConcurrentHashMap<String, WebSocketSession> SESSION_CONTAINER = new ConcurrentHashMap<>();

    public static void add(String key, WebSocketSession webSocketSession) {
        SESSION_CONTAINER.put(key, webSocketSession);
        log.debug("新添加webSocket连接 {}，当前连接数：{}", key, SESSION_CONTAINER.size());
    }

    public static void remove(String key) {
        SESSION_CONTAINER.remove(key);
        log.debug("移除webSocket连接 {}，当前连接数：{}", key, SESSION_CONTAINER.size());
    }

    public static WebSocketSession get(String key) {
        log.debug("获取webSocket连接 {}", key);
        return SESSION_CONTAINER.get(key);
    }

    public static void destroySession(String key) throws IOException {
        WebSocketSession session = get(key);
        if (session != null && session.isOpen()) {
            session.close();
            remove(key);
            log.debug("销毁session {}", key);
        }
    }
}


