package cn.hitek.authorization.ilis2.product.data.management.domain;

import lombok.Data;

/**
 * @author chenlm
 */
@Data
public class DatabaseInfo {

    private String name;
    private boolean online;
    private Integer tables;
    private String dataSize;
    private String indexSize;
    private Long uptime;
    private Integer maxConnections;
    private Integer threadsCached;
    private Integer threadConnected;
    private Integer threadCreated;
    private Integer threadRunning;
}
