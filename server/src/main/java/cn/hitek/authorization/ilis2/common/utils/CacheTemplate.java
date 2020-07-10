package cn.hitek.authorization.ilis2.common.utils;

import cn.hitek.authorization.ilis2.common.selector.Selector;
import lombok.extern.log4j.Log4j2;

import java.util.function.Supplier;

/**
 * 缓存获取模板
 * @author chenlm
 */
@Log4j2
public class CacheTemplate {

    public static <T> T get(Selector<T> cacheSelector, Supplier<T> databaseSelector) {
        try {
            T t = cacheSelector.get();
            if (t == null) {
                return databaseSelector.get();
            } else {
                return t;
            }
        } catch (Exception e) {
            log.error("通过缓存获取数据失败，将尝试从数据库获取");
            return databaseSelector.get();
        }
    }
}
