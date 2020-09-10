package cn.hitek.authorization.ilis2.framework.socket.manager;

import cn.hitek.authorization.ilis2.product.unit.service.UnitUserLogger;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.handler.WebSocketHandlerDecoratorFactory;

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
        return new DecodeTokenSocketDecorator(handler, userLogger);
    }
}


