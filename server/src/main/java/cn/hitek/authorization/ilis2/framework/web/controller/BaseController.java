package cn.hitek.authorization.ilis2.framework.web.controller;

import cn.hitek.authorization.ilis2.common.enums.HttpStatus;
import cn.hitek.authorization.ilis2.common.response.Response;

/**
 * @author chenlm
 */
public abstract class BaseController {

    protected Response result() {
        return new Response().code(HttpStatus.OK);
    }

    protected Response result(HttpStatus status, Object data) {
        return new Response().code(status).data(data);
    }

    protected Response result(HttpStatus status, Object data, String msg) {
        return new Response().code(status).data(data).message(msg);
    }
}
