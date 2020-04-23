package cn.hitek.authorization.ilis2.framework.web.service;

import cn.hitek.authorization.ilis2.common.mybatisplus.LambdaQueryWrapperChain;
import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.toolkit.SqlHelper;
import org.apache.ibatis.logging.Log;
import org.apache.ibatis.logging.LogFactory;

import java.io.Serializable;
import java.util.Collection;
import java.util.List;

/**
 * @author chenlm
 */
public interface BaseService<T> {

    Log logger = LogFactory.getLog(SqlHelper.class);

    int BATCH_SIZE = 1024;

    /**
     * <p>
     * 插入一条记录（选择字段，策略插入）
     * </p>
     *
     * @param entity 实体对象
     * @return result
     */
    boolean save(T entity);

    /**
     * <p>
     * 插入（批量）
     * </p>
     *
     * @param entityList 实体对象集合
     */
    void saveBatch(Collection<T> entityList);

    /**
     * <p>
     * TableId 注解存在更新记录，否插入一条记录
     * </p>
     *
     * @param entity 实体对象
     * @return result
     */
    boolean saveOrUpdate(T entity);

    /**
     * <p>
     * 批量修改插入
     * </p>
     *
     * @param entityList 实体对象集合
     * @return result
     */
    boolean saveOrUpdateBatch(Collection<T> entityList);

    /**
     * <p>
     * 查询列表
     * </p>
     *
     * @return list
     */
    default List<T> list() {
        return list(Wrappers.emptyWrapper());
    }

    /**
     * <p>
     * 查询列表
     * </p>
     *
     * @param queryWrapper 实体对象封装操作类 {@link com.baomidou.mybatisplus.core.conditions.query.QueryWrapper}
     * @return list
     */
    List<T> list(Wrapper<T> queryWrapper);

    /**
     * <p>
     * 根据 whereEntity 条件，更新记录
     * </p>
     *
     * @param updateWrapper 实体对象封装操作类 {@link com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper}
     * @return result
     */
    default boolean update(Wrapper<T> updateWrapper) {
        return update(null, updateWrapper);
    }

    /**
     * <p>
     * 根据 whereEntity 条件，更新记录
     * </p>
     *
     * @param entity        实体对象
     * @param updateWrapper 实体对象封装操作类 {@link com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper}
     * @return result
     */
    boolean update(T entity, Wrapper<T> updateWrapper);

    /**
     * <p>
     * 根据 ID 选择修改
     * </p>
     *
     * @param entity 实体对象
     * @return result
     */
    boolean updateById(T entity);

    /**
     * <p>
     * 根据ID 批量更新
     * </p>
     *
     * @param entityList 实体对象集合
     * @return result
     */
    default boolean updateBatchById(Collection<T> entityList) {
        return updateBatchById(entityList, BATCH_SIZE);
    }

    /**
     * <p>
     * 根据ID 批量更新
     * </p>
     *
     * @param entityList 实体对象集合
     * @param batchSize  更新批次数量
     * @return result
     */
    boolean updateBatchById(Collection<T> entityList, int batchSize);

    /**
     * <p>
     * 根据 Wrapper 条件，查询总记录数
     * </p>
     *
     * @return count
     */
    default int count() {
        return count(Wrappers.emptyWrapper());
    }

    /**
     * <p>
     * 根据 Wrapper 条件，查询记录是否存在
     * </p>
     *
     * @param queryWrapper 实体对象封装操作类 {@link com.baomidou.mybatisplus.core.conditions.query.QueryWrapper}
     * @return is obj exist
     */
    default boolean exist(Wrapper<T> queryWrapper) {
        return count(queryWrapper) > 0;
    }

    /**
     * <p>
     * 根据 Wrapper 条件，查询记录是否不存在
     * </p>
     *
     * @param queryWrapper 实体对象封装操作类 {@link com.baomidou.mybatisplus.core.conditions.query.QueryWrapper}
     * @return is not exist
     */
    default boolean nonExist(Wrapper<T> queryWrapper) {
        return !exist(queryWrapper);
    }

    /**
     * <p>
     * 根据 Wrapper 条件，查询总记录数
     * </p>
     *
     * @param queryWrapper 实体对象封装操作类 {@link com.baomidou.mybatisplus.core.conditions.query.QueryWrapper}
     * @return count
     */
    int count(Wrapper<T> queryWrapper);

    /**
     * <p>
     * 根据 Wrapper，查询一条记录
     * </p>
     *
     * @param queryWrapper 实体对象封装操作类 {@link com.baomidou.mybatisplus.core.conditions.query.QueryWrapper}
     * @return T
     */
    default T getOne(Wrapper<T> queryWrapper) {
        return SqlHelper.getObject(logger, list(queryWrapper));
    }

    /**
     * <p>
     * 根据 ID 查询
     * </p>
     *
     * @param id 主键ID
     * @return T
     */
    T getById(Serializable id);

    /**
     * <p>
     * 根据 ID 删除
     * </p>
     *
     * @param id 主键ID
     * @return result
     */
    boolean removeById(Serializable id);
    /**
     * <p>
     * 删除所有记录
     * </p>
     *
     * @return remove all
     */
    default boolean remove() {
        return remove(Wrappers.emptyWrapper());
    }

    /**
     * <p>
     * 根据 entity 条件，删除记录
     * </p>
     *
     * @param queryWrapper 实体包装类 {@link com.baomidou.mybatisplus.core.conditions.query.QueryWrapper}
     * @return is success
     */
    boolean remove(Wrapper<T> queryWrapper);

    /**
     * lambdaQueryChain
     *
     * @return chain
     */
    default LambdaQueryWrapperChain<T> query() {
        return new LambdaQueryWrapperChain<>(this);
    }
}
