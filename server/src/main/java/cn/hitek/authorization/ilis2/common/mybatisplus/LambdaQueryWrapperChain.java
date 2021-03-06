package cn.hitek.authorization.ilis2.common.mybatisplus;

import cn.hitek.authorization.ilis2.framework.web.service.BaseService;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.Query;
import com.baomidou.mybatisplus.core.metadata.TableFieldInfo;
import com.baomidou.mybatisplus.core.toolkit.ExceptionUtils;
import com.baomidou.mybatisplus.core.toolkit.support.SFunction;
import com.baomidou.mybatisplus.extension.conditions.AbstractChainWrapper;

import java.util.List;
import java.util.function.Predicate;

/**
 * @author chenlm
 */
public class LambdaQueryWrapperChain<T> extends AbstractChainWrapper<T, SFunction<T, ?>, LambdaQueryWrapperChain<T>, LambdaQueryWrapper<T>>
        implements Query<LambdaQueryWrapperChain<T>, T, SFunction<T, ?>> {

    private final BaseService<T> baseService;

    public LambdaQueryWrapperChain(BaseService<T> baseService) {
        super();
        this.baseService = baseService;
        super.wrapperChildren = new LambdaQueryWrapper<>();
    }

    @SafeVarargs
    @Override
    public final LambdaQueryWrapperChain<T> select(SFunction<T, ?>... columns) {
        wrapperChildren.select(columns);
        return typedThis;
    }

    @Override
    public LambdaQueryWrapperChain<T> select(Predicate<TableFieldInfo> predicate) {
        wrapperChildren.select(predicate);
        return typedThis;
    }

    @Override
    public LambdaQueryWrapperChain<T> select(Class<T> entityClass, Predicate<TableFieldInfo> predicate) {
        wrapperChildren.select(entityClass, predicate);
        return typedThis;
    }

    @Override
    public String getSqlSelect() {
        throw ExceptionUtils.mpe("can not use this method for \"%s\"", "getSqlSelect");
    }

    @SuppressWarnings("unchecked")
    public List<T> list() {
        return baseService.list(getWrapper());
    }

    @SuppressWarnings("unchecked")
    public T getOne() {
        return (T) baseService.getOne(getWrapper());

    }
    @SuppressWarnings("unchecked")
    public Integer count() {
        return baseService.count(getWrapper());
    }

    @SuppressWarnings("unchecked")
    public boolean exist() {
        return baseService.exist(getWrapper());
    }

    @SuppressWarnings("unchecked")
    public boolean nonExist() {
        return baseService.nonExist(getWrapper());
    }

}
