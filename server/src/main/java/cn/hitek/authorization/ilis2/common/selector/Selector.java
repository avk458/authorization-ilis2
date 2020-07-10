package cn.hitek.authorization.ilis2.common.selector;

/**
 * @author chenlm
 */
@FunctionalInterface
public interface Selector<T> {

    /**
     * get an object
     *
     * @return T
     * @throws Exception progress exception
     */
    T get() throws Exception;
}
