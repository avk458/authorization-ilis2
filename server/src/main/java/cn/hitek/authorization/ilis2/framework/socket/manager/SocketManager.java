package cn.hitek.authorization.ilis2.framework.socket.manager;

import lombok.extern.slf4j.Slf4j;
import org.springframework.web.socket.WebSocketSession;

import java.util.concurrent.ConcurrentHashMap;

/**
 * socket管理器
 *
 * @author chenlm
 */
@Slf4j
public class SocketManager {

    private static final ConcurrentHashMap<String, WebSocketSession> SESSION_CONTAINER = new ConcurrentHashMap<>();

    public static void add(String key, WebSocketSession webSocketSession) {
        SESSION_CONTAINER.put(key, webSocketSession);
        log.info("新添加webSocket连接 {}，当前连接数：{}", key, SESSION_CONTAINER.size());
    }

    public static void remove(String key) {
        SESSION_CONTAINER.remove(key);
        log.info("移除webSocket连接 {}，当前连接数：{}", key, SESSION_CONTAINER.size());
    }

    public static WebSocketSession get(String key) {
        log.info("获取webSocket连接 {}", key);
        return SESSION_CONTAINER.get(key);
    }
}


