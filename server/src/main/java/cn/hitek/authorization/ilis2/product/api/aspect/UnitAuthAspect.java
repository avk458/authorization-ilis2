package cn.hitek.authorization.ilis2.product.api.aspect;

import cn.hitek.authorization.ilis2.product.configuration.domain.TargetSourceProfile;
import cn.hitek.authorization.ilis2.product.configuration.mapper.TargetSourceProfileMapper;
import cn.hitek.authorization.ilis2.product.unit.domain.Unit;
import cn.hitek.authorization.ilis2.product.unit.mapper.UnitMapper;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import lombok.RequiredArgsConstructor;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.context.annotation.Profile;
import org.springframework.oxm.ValidationFailureException;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import java.util.Objects;

/**
 * @author chenlm
 */
@Profile("prod")
@Aspect
@Component
@RequiredArgsConstructor
public class UnitAuthAspect {

    private final UnitMapper unitMapper;
    private final TargetSourceProfileMapper targetMapper;

    @Before("execution(* cn.hitek.authorization.ilis2.product.api.ApiController.getUnitInfo(..)) && args(code)")
    public void validateRequestOrigin(String code) {
        HttpServletRequest request = ((ServletRequestAttributes) Objects
                .requireNonNull(RequestContextHolder.getRequestAttributes()))
                .getRequest();
        String origin = request.getHeader("client-origin");
        if (StrUtil.isBlank(origin)) {
            throw new ValidationFailureException("请求头数据验证失败");
        }
        LambdaQueryWrapper<Unit> unitWrapper = Wrappers.lambdaQuery(Unit.class).eq(Unit::getUniqCode, code);
        Unit unit = unitMapper.selectOne(unitWrapper);
        Objects.requireNonNull(unit, "未获取到对应的单位信息");
        String profileId = unit.getTargetProfileId();
        TargetSourceProfile target = targetMapper.selectById(profileId);
        Objects.requireNonNull(target, "未能获取到目标数据源信息");
        if (!origin.equals(target.getDeploy())) {
            throw new ValidationFailureException("非同源请求");
        }
    }
}
