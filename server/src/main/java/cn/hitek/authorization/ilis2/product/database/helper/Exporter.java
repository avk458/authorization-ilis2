package cn.hitek.authorization.ilis2.product.database.helper;

/**
 * @author chenlm
 */
public interface Exporter {

    /**
     * 从数据库中导出
     * @throws RuntimeException 抛出让用户知晓的业务异常
     */
    void export() throws RuntimeException;

}
