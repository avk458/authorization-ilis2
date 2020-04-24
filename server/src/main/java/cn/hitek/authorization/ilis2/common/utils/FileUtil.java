package cn.hitek.authorization.ilis2.common.utils;

import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.util.ResourceUtils;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.HashSet;
import java.util.Set;

/**
 * @author chenlm
 */
@Slf4j
public class FileUtil {

    public static Set<String> getMySqlDatabaseNameKeyWords() {
        HashSet<String> keyWords = null;
        try {
            File file = ResourceUtils.getFile("classpath:MySQLKeyWords.txt");
            FileReader fileReader = new FileReader(file);
            BufferedReader reader = new BufferedReader(fileReader);
            keyWords = new HashSet<>(0);
            while (StringUtils.isNotBlank(reader.readLine())) {
                keyWords.add(reader.readLine().toLowerCase());
            }
        } catch (IOException e) {
            log.warn("获取MySql数据库命名关键字文件失败！");
            e.printStackTrace();
        }
        return keyWords;
    }
 }
