package cn.hitek.authorization.ilis2.product.data.management.domain;

import cn.hitek.authorization.ilis2.framework.web.entity.BaseEntity;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Getter;
import lombok.Setter;

/**
 * @author chenlm
 */
@TableName("t_standard_database_detail")
@Getter
@Setter
public class StandardDatabaseDetail extends BaseEntity {

    private String standardDatabaseId;

    private String version;

    private String ddl;

    private String dml;
}
