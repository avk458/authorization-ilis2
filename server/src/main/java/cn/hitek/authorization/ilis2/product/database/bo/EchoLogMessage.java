package cn.hitek.authorization.ilis2.product.database.bo;

import org.springframework.web.socket.WebSocketMessage;

public class EchoLogMessage implements WebSocketMessage<EchoLog> {

    private final EchoLog log;
    private final boolean isLast;

    public EchoLogMessage(EchoLog log) {
        this.log = log;
        this.isLast = true;
    }

    @Override
    public EchoLog getPayload() {
        return log;
    }

    @Override
    public int getPayloadLength() {
        return 0;
    }

    @Override
    public boolean isLast() {
        return this.isLast;
    }
}
