package cn.hitek.authorization.ilis2.product.data.script.service.impl;

import cn.hitek.authorization.ilis2.common.constants.Constant;
import cn.hitek.authorization.ilis2.framework.web.service.impl.BaseServiceImpl;
import cn.hitek.authorization.ilis2.product.base.domain.UserDetail;
import cn.hitek.authorization.ilis2.product.data.script.domain.DataScript;
import cn.hitek.authorization.ilis2.product.data.script.mapper.DataScriptMapper;
import cn.hitek.authorization.ilis2.product.data.script.service.DataScriptService;
import cn.hitek.authorization.ilis2.common.properties.DataSourceProperties;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import lombok.AllArgsConstructor;
import lombok.SneakyThrows;
import org.apache.ibatis.jdbc.ScriptRunner;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.FileReader;
import java.nio.file.Files;
import java.nio.file.Path;
import java.sql.Connection;
import java.sql.DriverManager;
import java.util.ArrayList;
import java.util.List;

/**
 * @author chenlm
 */
@Service
@AllArgsConstructor
public class DataScriptServiceImpl extends BaseServiceImpl<DataScriptMapper, DataScript> implements DataScriptService {

    private final DataSourceProperties dataSourceProperties;

    @Override
    public List<DataScript> getScriptRange(Long dataVersion) {
        dataVersion = dataVersion == null ? 0L : dataVersion;
        return query().gt(DataScript::getId, dataVersion).list();
    }

    @Override
    public List<DataScript> getScriptRange(Long dataVersion, Long updateVersion) {
        return query().gt(DataScript::getId, dataVersion).le(DataScript::getId, updateVersion).list();
    }

    @SneakyThrows
    @Override
    public ResponseEntity<Object> exportScript() {
        Long lastId = baseMapper.getLastId();
        String fileName = generateFileName(lastId);
        File tmp = File.createTempFile(fileName, ".sql");
        List<String> commands = buildScriptExportCommands();
        ProcessBuilder builder = new ProcessBuilder(commands);
        builder.redirectOutput(ProcessBuilder.Redirect.to(tmp));
        Process process = builder.start();
        process.waitFor();
        Resource body = new FileSystemResource(tmp);
        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-Disposition", fileName + ".sql");
        headers.add("Cache-Control", "no-cache,no-store,must-revalidate");
        headers.add("Pragma", "no-cache");
        headers.add("Expires", "0");
        headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
        return ResponseEntity.ok()
                .headers(headers)
                .contentLength(tmp.length())
                .body(body);
    }

    private String generateFileName(Long lastId) {
        if (lastId == null) {
            return "0";
        }
        if (lastId >= 100) {
            return lastId + "";
        } else if (lastId >= 10) {
            return "0" + lastId;
        } else {
            return "00" + lastId;
        }
    }

    private List<String> buildScriptExportCommands() {
        ArrayList<String> command = new ArrayList<>(8);
        command.add(Constant.MYSQL_DUMP);
        command.add("-h" + dataSourceProperties.getHost());
        command.add("-P" + dataSourceProperties.getPort());
        command.add("-u" + dataSourceProperties.getUsername());
        command.add("-p" + dataSourceProperties.getPassword());
        // make sure this progress will not hang in metadata lock
        command.add("--single-transaction");
        command.add("auth01");
        command.add("t_data_script");
        return command;
    }

    @Override
    public String getLastDataScriptVersion() {
        return generateFileName(baseMapper.getLastId());
    }

    @SneakyThrows
    @Override
    public void importScriptFile(MultipartFile multipartFile) {
        Path tmp = Files.createTempFile("tmp", ".sql");
        multipartFile.transferTo(tmp);
        Connection connection = DriverManager.getConnection(
                dataSourceProperties.getUrl(),
                dataSourceProperties.getUsername(),
                dataSourceProperties.getPassword());
        ScriptRunner runner = new ScriptRunner(connection);
        runner.runScript(new FileReader(tmp.toFile()));
    }

    @Override
    public IPage<DataScript> selectPage(Page<DataScript> page) {
        return baseMapper.selectPage(
                page,
                Wrappers.lambdaQuery(DataScript.class)
                        .orderByDesc(DataScript::getId)
        );
    }

    @Override
    public Long getLastDataScriptId() {
        return baseMapper.getLastId();
    }

    @Override
    public void scriptExchange(String id1, String id2) {
        UserDetail principal = (UserDetail) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        baseMapper.scriptExchange(id1, id2, principal);
    }
}
