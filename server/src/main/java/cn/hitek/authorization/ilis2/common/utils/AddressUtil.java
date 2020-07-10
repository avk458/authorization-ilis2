package cn.hitek.authorization.ilis2.common.utils;

import cn.hutool.core.io.file.FileWriter;
import lombok.extern.log4j.Log4j2;
import org.lionsoul.ip2region.DataBlock;
import org.lionsoul.ip2region.DbConfig;
import org.lionsoul.ip2region.DbSearcher;

import java.io.File;
import java.io.IOException;
import java.lang.reflect.Method;

/**
 * @author chenlm
 */
@Log4j2
public class AddressUtil {

    public static String getCityInfo(String ip) {
        DbSearcher searcher = null;
        try {
            String dbPath = AddressUtil.class.getResource("/ip2region/ip2region.db").getPath();
            File file = new File(dbPath);
            if (!file.exists()) {
                String tmpDir = System.getProperties().getProperty("java.io.tmpdir");
                dbPath = tmpDir + "ip.db";
                file = new File(dbPath);
                FileWriter.create(file).writeFromStream(AddressUtil.class.getClassLoader().getResourceAsStream("classpath:ip2region/ip2region.db"));
            }
            DbConfig config = new DbConfig();
            searcher = new DbSearcher(config, file.getPath());
            Method method = searcher.getClass().getMethod("btreeSearch", String.class);
            DataBlock dataBlock = (DataBlock) method.invoke(searcher, ip);
            return dataBlock.getRegion();
        } catch (Exception e) {
            log.error("获取地址信息异常", e);
        } finally {
            if (searcher != null) {
                try {
                    searcher.close();
                } catch (IOException e) {
                    e.printStackTrace();
                    log.warn("ip2region程序异常");
                }
            }
        }
        return "";
    }
}
