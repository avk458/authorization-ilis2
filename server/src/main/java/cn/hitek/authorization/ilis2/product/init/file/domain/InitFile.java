package cn.hitek.authorization.ilis2.product.init.file.domain;

import cn.hitek.authorization.ilis2.framework.web.entity.BaseEntity;
import lombok.Getter;
import lombok.Setter;

/**
 * @author chenlm
 */
@Getter
@Setter
public class InitFile extends BaseEntity {

    private String configId;

    private String configName;

    private String sqlFilePath;

    private String errorLogPath;
}
