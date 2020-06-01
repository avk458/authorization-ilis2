package cn.hitek.authorization.ilis2.product.init.file.service;

import cn.hitek.authorization.ilis2.framework.web.service.BaseService;
import cn.hitek.authorization.ilis2.product.init.file.domain.InitFile;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;

/**
 * @author chenlm
 */
public interface InitFileService extends BaseService<InitFile> {

    /**
     * 获取分页集合
     * @param page 封装的参数
     * @return 分页对象
     */
    Page<InitFile> getFilePageList(Page<InitFile> page);
}
