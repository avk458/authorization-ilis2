package cn.hitek.authorization.ilis2.product.init.file.service.impl;

import cn.hitek.authorization.ilis2.common.QueryParams;
import cn.hitek.authorization.ilis2.framework.web.service.impl.BaseServiceImpl;
import cn.hitek.authorization.ilis2.product.init.file.domain.InitFile;
import cn.hitek.authorization.ilis2.product.init.file.mapper.InitFileMapper;
import cn.hitek.authorization.ilis2.product.init.file.service.InitFileService;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.springframework.stereotype.Service;

/**
 * @author chenlm
 */
@Service
public class InitFileServiceImpl extends BaseServiceImpl<InitFileMapper, InitFile> implements InitFileService {

    @Override
    public Page<InitFile> getFilePageList(QueryParams params) {
        Page<InitFile> page = new Page<>(params.getPage(), params.getSize());
        return baseMapper.selectPage(page,
                Wrappers.lambdaQuery(InitFile.class).orderByDesc(InitFile::getCreateTime));
    }
}
