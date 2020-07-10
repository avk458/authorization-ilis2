package cn.hitek.authorization.ilis2.product.data.script.service;

import cn.hitek.authorization.ilis2.framework.web.service.BaseService;
import cn.hitek.authorization.ilis2.product.data.script.domain.DataScript;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.springframework.http.ResponseEntity;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

/**
 * @author chenlm
 */
public interface DataScriptService extends BaseService<DataScript> {



    /**
     * 获取当前数据库数据版本到最新版本
     * @param dataVersion 当前数据库数据库版本
     * @return 脚本
     */
    List<DataScript> getScriptRange(Long dataVersion);

    /**
     * 获取当前数据库数据版本到指定的版本的数据库脚本
     * @param dataVersion 当前数据库数据版本
     * @param updateVersion 要升级到的数据库版本
     * @return 指定范围内的脚本数据
     */
    List<DataScript> getScriptRange(Long dataVersion, Long updateVersion);

    /**
     * 导出数据脚本
     * @return file output stream
     */
    ResponseEntity<Object> exportScript();

    /**
     * 获取数据脚本最新id
     * @return id
     */
    String getLastDataScriptVersion();

    /**
     * 导入数据库脚本
     * @param multipartFile file
     */
    void importScriptFile(MultipartFile multipartFile);

    /**
     * 返回分页列表
     * @param page page params
     * @return pagination
     */
    IPage<DataScript> selectPage(Page<DataScript> page);

    /**
     * 获取最新的数据脚本id
     * @return id
     */
    Long getLastDataScriptId();

    /**
     * 交换数据脚本顺序
     * @param id1 id1
     * @param id2 id2
     */
    void scriptExchange(String id1, String id2);
}
