package cn.hitek.authorization.ilis2.product.data.management.domain;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

/**
 * @author chenlm
 */
@Data
public class SchemaInfo {

    private String schemaType;
    private List<Schema> schemaList;

    @Getter
    @Setter
    public static class Schema {

        private String key;
        private String label;
        private boolean disabled;
    }
}
