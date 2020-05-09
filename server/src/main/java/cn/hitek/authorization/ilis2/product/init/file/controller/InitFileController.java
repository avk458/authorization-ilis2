package cn.hitek.authorization.ilis2.product.init.file.controller;

import cn.hitek.authorization.ilis2.common.QueryParams;
import cn.hitek.authorization.ilis2.common.enums.HttpStatus;
import cn.hitek.authorization.ilis2.common.response.Response;
import cn.hitek.authorization.ilis2.product.init.file.domain.InitFile;
import cn.hitek.authorization.ilis2.product.init.file.service.InitFileService;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
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
    public Response getInitFileList(QueryParams params) {
        Page<InitFile> page = this.fileService.getFilePageList(params);
        return new Response().code(HttpStatus.OK).data(page);
    }
}
