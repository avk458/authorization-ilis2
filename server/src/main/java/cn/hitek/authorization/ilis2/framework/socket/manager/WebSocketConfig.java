package cn.hitek.authorization.ilis2.framework.socket.manager;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.socket.config.annotation.EnableWebSocketMessageBroker;
import org.springframework.web.socket.config.annotation.StompEndpointRegistry;
import org.springframework.web.socket.config.annotation.WebSocketMessageBrokerConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketTransportRegistration;

/**
 * @author chenlm
 */
@Configuration
@EnableWebSocketMessageBroker
public class WebSocketConfig implements WebSocketMessageBrokerConfigurer {

    private final WebSocketDecoratorFactory webSocketDecoratorFactory;
    private final PrincipalHandshakeHandler principalHandshakeHandler;

    public WebSocketConfig(WebSocketDecoratorFactory webSocketDecoratorFactory,
                           PrincipalHandshakeHandler principalHandshakeHandler) {
        this.webSocketDecoratorFactory = webSocketDecoratorFactory;
        this.principalHandshakeHandler = principalHandshakeHandler;
    }

    @Override
    public void registerStompEndpoints(StompEndpointRegistry registry) {
        registry.addEndpoint("/online")
                .setAllowedOrigins("*")
                .setHandshakeHandler(principalHandshakeHandler);
    }

    @Override
    public void configureWebSocketTransport(WebSocketTransportRegistration registry) {
        registry.addDecoratorFactory(webSocketDecoratorFactory);
    }
}
