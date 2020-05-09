package cn.hitek.authorization.ilis2.product.init.file.controller;

import cn.hitek.authorization.ilis2.common.QueryParams;
import cn.hitek.authorization.ilis2.product.init.file.domain.InitFile;
import cn.hitek.authorization.ilis2.product.init.file.service.InitFileService;
import com.baomidou.mybatisplus.core.metadata.IPage;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @author chenlm
 */
@RestController
@RequestMapping("init-file")
public class InitFileController {

    private final InitFileService fileService;

    public InitFileController(InitFileService fileService) {
        this.fileService = fileService;
    }

    @GetMapping("/list")
    public IPage<InitFile> getInitFileList(QueryParams params) {
        return this.fileService.getFilePageList(params);
    }
}
