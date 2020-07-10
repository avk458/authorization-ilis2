package cn.hitek.authorization.ilis2.framework.socket.manager;

import cn.hitek.authorization.ilis2.product.unit.service.UnitUserLogger;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.WebSocketHandlerDecorator;
import org.springframework.web.socket.handler.WebSocketHandlerDecoratorFactory;

import java.security.Principal;

/**
 * 处理服务端和客户端握手挥手
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
            public void afterConnectionEstablished(WebSocketSession session) throws Exception {
                Principal principal = session.getPrincipal();
                if (principal != null) {
                    SocketManager.add(principal.getName(), session);
                    userLogger.addOnlineUser(principal.getName());
                }
                super.afterConnectionEstablished(session);
            }

            @Override
            public void afterConnectionClosed(WebSocketSession session, CloseStatus closeStatus) throws Exception {
                Principal principal = session.getPrincipal();
                if (principal != null) {
                    SocketManager.remove(principal.getName());
                    userLogger.removeOnlineUser(principal.getName());
                }
                super.afterConnectionClosed(session, closeStatus);
            }
        };
    }
}


