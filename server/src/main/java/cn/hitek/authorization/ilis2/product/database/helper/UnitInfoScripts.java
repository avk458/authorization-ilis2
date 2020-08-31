package cn.hitek.authorization.ilis2.product.database.helper;

import java.util.ArrayList;
import java.util.List;

/**
 * @author chenlm
 */
public class UnitInfoScripts {

    public static List<String> get(Long centerUnitId, String unitName, String schema) {
        String updateCenterUnit = "update %s.t_s_type set typename = '%s' where ID = '%s';";
        ArrayList<String> strings = new ArrayList<>(2);
        strings.add(String.format(updateCenterUnit, schema, centerUnitId, "716e3fe3db6b4d22a57b661bf858b929"));
        strings.add(String.format(updateCenterUnit, schema, unitName, "db02a62954944e29bfeed3e5a2c2a020"));
        return strings;
    }
}
