package cn.hitek.authorization.ilis2.product.init.config.controller;

import cn.hitek.authorization.ilis2.product.database.service.impl.WebSocket;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @author chenlm
 */
@RestController
public class WebsocketSendToUserController {

    @Autowired
    private WebSocket webSocket;

    @RequestMapping("/send")
    public String processMessageFromClient() {
        webSocket.sendAllMessage("清晨起来打开窗，心情美美哒~");
        return "websocket群体发送！";
    }
}
