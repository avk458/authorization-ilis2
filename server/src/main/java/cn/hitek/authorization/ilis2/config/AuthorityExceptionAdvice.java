package cn.hitek.authorization.ilis2.config;

import cn.hitek.authorization.ilis2.common.enums.HttpStatus;
import cn.hitek.authorization.ilis2.common.exception.BusinessException;
import cn.hitek.authorization.ilis2.common.response.Response;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.validation.BindException;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import javax.validation.ConstraintViolation;
import javax.validation.ConstraintViolationException;


/**
 * @author chenlm
 */
@RestControllerAdvice
@Slf4j
public class AuthorityExceptionAdvice {

    private final String bem = "参数异常";

    @ExceptionHandler(Exception.class)
    public Response handlingUnexpectedException(Exception e) {
        e.printStackTrace();
        log.warn("系统异常：{}", e.getMessage());
        return new Response().code(HttpStatus.FAIL).message("程序异常：" + e.getMessage());
    }

    @ExceptionHandler(BusinessException.class)
    public Response handlingBusinessException(BusinessException be) {
        log.warn("业务异常：{}", be.getMessage());
        return new Response().code(HttpStatus.FAIL).message(be.getMessage());
    }

    @ExceptionHandler(BindException.class)
    public Response handlingBindingException(BindException be) {
        log.warn("参数异常：{}", be.getMessage());
        FieldError fieldError = be.getBindingResult().getFieldError();
        return new Response().code(HttpStatus.FAIL).message(null != fieldError ? fieldError.getDefaultMessage() : bem);
    }

    @ExceptionHandler(MethodArgumentNotValidException.class)
    public Response handlingMethodBindingException(MethodArgumentNotValidException e) {
        log.warn("参数异常：{}", e.getMessage());
        FieldError fieldError = e.getBindingResult().getFieldError();
        return new Response().code(HttpStatus.FAIL).message(null != fieldError ? fieldError.getDefaultMessage() : bem);
    }

    @ExceptionHandler(ConstraintViolationException.class)
    public Response handlingConstraintViolationException(ConstraintViolationException e) {
        log.warn("参数异常：{}", e.getMessage());
        return new Response().code(HttpStatus.FAIL).message(e
                .getConstraintViolations()
                .stream()
                .map(ConstraintViolation::getMessageTemplate)
                .findFirst().orElse(bem));
    }

    @ExceptionHandler(BadCredentialsException.class)
    public Response handlingLoginValidate(BadCredentialsException e) {
        log.warn(e.getMessage());
        return new Response().code(HttpStatus.FAIL).message("用户名或者密码错误");
    }

    @ExceptionHandler(AuthenticationException.class)
    public Response handlingUnAuthorizedException(AuthenticationException e) {
        log.warn(e.getMessage());
        return new Response().code(HttpStatus.NO_AUTH).message("您没有访问这个资源的权限");
    }

    @ExceptionHandler(AccessDeniedException.class)
    public Response handlingAccessDeniedException(AccessDeniedException e) {
        log.warn(e.getMessage());
        return new Response().code(HttpStatus.NO_AUTH).message("没有权限，" + e.getMessage());
    }
}
