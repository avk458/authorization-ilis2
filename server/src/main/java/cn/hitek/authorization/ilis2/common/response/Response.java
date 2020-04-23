package cn.hitek.authorization.ilis2.common.response;

import cn.hitek.authorization.ilis2.common.enums.HttpStatus;

import java.util.HashMap;

/**
 * @author chenlm
 */
public class Response extends HashMap<String, Object> {

    public Response code(HttpStatus status) {
        this.put("code", status.getCode());
        return this;
    }

    public Response data(Object obj) {
        this.put("data", obj);
        return this;
    }

    public Response message(String msg) {
        this.put("message", msg);
        return this;
    }

    @Override
    public Object put(String key, Object value) {
        return super.put(key, value);
    }
}
