package cn.hitek.authorization.ilis2.common.response;

import java.util.HashMap;
import java.util.List;

/**
 * @author chenlm
 */
public class Pager extends HashMap<String, Object> {

    public Pager count(int count) {
        this.put("count", count);
        return this;
    }

    public Pager rows(List<Object> rows) {
        this.put("rows", rows);
        return this;
    }

    @Override
    public Object put(String key, Object value) {
        return super.put(key, value);
    }
}
