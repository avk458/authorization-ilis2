package cn.hitek.authorization.ilis2.framework.socket.manager;

import cn.hitek.authorization.ilis2.common.exception.InvalidWebSocketTokenException;
import cn.hitek.authorization.ilis2.product.unit.service.UnitUserLogger;
import cn.hutool.core.codec.Base64;
import lombok.extern.log4j.Log4j2;
import org.springframework.web.socket.*;
import org.springframework.web.socket.handler.WebSocketHandlerDecorator;

import java.security.Principal;
import java.util.Optional;

/**
 * @author chenlm
 */
@Log4j2
public class DecodeTokenSocketDecorator extends WebSocketHandlerDecorator {

    private final UnitUserLogger userLogger;

    public DecodeTokenSocketDecorator(WebSocketHandler delegate, UnitUserLogger userLogger) {
        super(delegate);
        this.userLogger = userLogger;
    }

    private WsToken decodeWsToken(String rawToken) {
        rawToken = rawToken == null ? "" : Base64.decodeStr(rawToken);
        String[] split = rawToken.split(",");
        final int validLength = 3;
        if (validLength != split.length) {
            log.warn("wrong ws token");
            throw new InvalidWebSocketTokenException();
        }
        return new WsToken(split[0], split[1], split[2]);
    }

    @Override
    public void afterConnectionEstablished(WebSocketSession session) {
        Principal principal = session.getPrincipal();
        Optional.ofNullable(principal).ifPresent(p -> {
            WsToken wsToken = decodeWsToken(p.getName());
            String sessionId = wsToken.getSessionId();
            SocketManager.add(sessionId, session);
            userLogger.addAccountSession(wsToken);
        });
    }

    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus closeStatus) {
        Principal principal = session.getPrincipal();
        Optional.ofNullable(principal).ifPresent(p -> {
            WsToken wsToken = decodeWsToken(p.getName());
            userLogger.removeAccountSession(wsToken);
        });
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
        Optional.ofNullable(principal).ifPresent(p -> {
            WsToken wsToken = decodeWsToken(p.getName());
            userLogger.addAccountSession(wsToken);
        });
    }
}
