package cn.hitek.authorization.ilis2.product.init.file.service;

import cn.hitek.authorization.ilis2.common.QueryParams;
import cn.hitek.authorization.ilis2.framework.web.service.BaseService;
import cn.hitek.authorization.ilis2.product.init.file.domain.InitFile;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;

/**
 * @author chenlm
 */
public interface InitFileService extends BaseService<InitFile> {

    /**
     * 获取分页集合
     * @param params 封装的参数
     * @return 分页对象
     */
    Page<InitFile> getFilePageList(QueryParams params);
}
