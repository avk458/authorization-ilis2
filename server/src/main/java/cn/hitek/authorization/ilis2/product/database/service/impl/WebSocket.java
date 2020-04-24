package cn.hitek.authorization.ilis2.product.database.service.impl;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.WebSocketSession;

import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

/**
 * @author chenlm
 */
@Slf4j
@Component
@ServerEndpoint("/websocket/{userId}")
public class WebSocket {

    private WebSocketSession session;

    private Map<String, WebSocketSession> sessionContainer = new ConcurrentHashMap<>(0);

    @OnOpen
    public void onOpen(WebSocketSession session, @PathParam(value="userId") String userId) {
        this.session = session;
        sessionContainer.put(userId, session);
        log.info("新增webSocket连接，目前连接数：{}", sessionContainer.size());
    }

    // @OnClose
    // public void onClose() {
    //     webSockets.remove(this);
    //     System.out.println("【websocket消息】连接断开，总数为:"+webSockets.size());
    // }

    @OnMessage
    public void onMessage(String message) {
        System.out.println("【websocket消息】收到客户端消息:"+message);
    }

    // public void sendAllMessage(String message) {
    //     for(WebSocket webSocket : webSockets) {
    //         System.out.println("【websocket消息】广播消息:"+message);
    //         try {
    //             webSocket.session.getAsyncRemote().sendText(message);
    //         } catch (Exception e) {
    //             e.printStackTrace();
    //         }
    //     }
    // }
    //
    // public void sendOneMessage(String shopId, String message) {
    //     Session session = sessionPool.get(shopId);
    //     if (session != null) {
    //         try {
    //             session.getAsyncRemote().sendText(message);
    //         } catch (Exception e) {
    //             e.printStackTrace();
    //         }
    //     }
    // }

}
