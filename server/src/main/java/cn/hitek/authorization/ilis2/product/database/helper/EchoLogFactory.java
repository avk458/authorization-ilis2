package cn.hitek.authorization.ilis2.product.database.helper;

import cn.hitek.authorization.ilis2.product.database.bo.EchoLog;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

/**
 * @author chenlm
 */
public class EchoLogFactory {

    public static String createLog(LogType type, String message) throws JsonProcessingException {
        EchoLog log;
        switch (type) {
            case WARN:
                log = new EchoLog("yellow", message);
                break;
            case ERROR:
                log = new EchoLog("red", message);
                break;
            case SUCCESS:
                log = new EchoLog("green", message);
                break;
            default:
                log = new EchoLog("blue", message);
                break;
        }
        ObjectMapper objectMapper = new ObjectMapper();
        return objectMapper.writeValueAsString(log);
    }
}
