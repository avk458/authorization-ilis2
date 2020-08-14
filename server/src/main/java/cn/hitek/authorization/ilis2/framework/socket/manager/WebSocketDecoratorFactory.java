package cn.hitek.authorization.ilis2.framework.socket.manager;

import cn.hitek.authorization.ilis2.product.unit.service.UnitUserLogger;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.*;
import org.springframework.web.socket.handler.WebSocketHandlerDecorator;
import org.springframework.web.socket.handler.WebSocketHandlerDecoratorFactory;

import java.security.Principal;
import java.util.Optional;

/**
 * 处理服务端和客户端握手挥手 ping pong
 * @author chenlm
 */
@Component
@AllArgsConstructor
public class WebSocketDecoratorFactory implements WebSocketHandlerDecoratorFactory {

    private final UnitUserLogger userLogger;

    @Override
    public WebSocketHandler decorate(WebSocketHandler handler) {
        return new WebSocketHandlerDecorator(handler) {

            @Override
            public void afterConnectionEstablished(WebSocketSession session) {
                Principal principal = session.getPrincipal();
                Optional.ofNullable(principal).ifPresent(p -> {
                    SocketManager.add(principal.getName(), session);
                    userLogger.addOnlineUser(p.getName());
                });
            }

            @Override
            public void afterConnectionClosed(WebSocketSession session, CloseStatus closeStatus) {
                Principal principal = session.getPrincipal();
                Optional.ofNullable(principal).ifPresent(p -> userLogger.removeOnlineUser(p.getName()));
            }

            /**
             * this is ilis ws ping msg
             * @param session client ws session
             * @param message ping msg
             * @throws Exception exception
             */
            @Override
            public void handleMessage(WebSocketSession session, WebSocketMessage<?> message) throws Exception {
                // cannot received the PongMessage or BinaryMessage
                session.sendMessage(new TextMessage(""));
                Principal principal = session.getPrincipal();
                // update cached info latest online datetime or bring offline account back online
                Optional.ofNullable(principal).ifPresent(p -> userLogger.updateStatus(p.getName()));
            }
        };
    }
}


