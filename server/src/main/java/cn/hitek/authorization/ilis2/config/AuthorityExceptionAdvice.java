package cn.hitek.authorization.ilis2.config;

import cn.hitek.authorization.ilis2.common.enums.HttpStatus;
import cn.hitek.authorization.ilis2.common.exception.BusinessException;
import cn.hitek.authorization.ilis2.common.response.Response;
import lombok.extern.slf4j.Slf4j;
import org.springframework.validation.BindException;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;


/**
 * @author chenlm
 */
@RestControllerAdvice
@Slf4j
public class AuthorityExceptionAdvice {

    @ExceptionHandler(Exception.class)
    public Response handlingUnexpectedException(Exception e) {
        log.debug("系统异常：{}", e.getMessage());
        return new Response().code(HttpStatus.FAIL).message("程序异常");
    }

    @ExceptionHandler(BusinessException.class)
    public Response handlingBusinessException(BusinessException be) {
        log.debug("业务异常：{}", be.getMessage());
        return new Response().code(HttpStatus.FAIL).message(be.getMessage());
    }

    @ExceptionHandler(BindException.class)
    public Response handlingBindingException(BindException be) {
        log.debug("参数异常：{}", be.getMessage());
        FieldError fieldError = be.getBindingResult().getFieldError();
        assert fieldError != null;
        return new Response().code(HttpStatus.FAIL).message(fieldError.getDefaultMessage());
    }

    @ExceptionHandler(MethodArgumentNotValidException.class)
    public Response handlingMethodBindingException(MethodArgumentNotValidException e) {
        log.debug("参数异常：{}", e.getMessage());
        FieldError fieldError = e.getBindingResult().getFieldError();
        assert fieldError != null;
        return new Response().code(HttpStatus.FAIL).message(fieldError.getDefaultMessage());
    }
}
