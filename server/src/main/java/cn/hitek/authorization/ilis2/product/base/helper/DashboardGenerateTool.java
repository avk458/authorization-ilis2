package cn.hitek.authorization.ilis2.product.base.helper;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author chenlm
 */
public class DashboardGenerateTool {

    public static List<Map<String, Object>> generateInfoCardsData(Long scriptId, Map<String, Integer> accountsData) {
        HashMap<String, Object> dataScriptCard = new HashMap<>(1);
        dataScriptCard.put("title", "当前数据库数据版本");
        dataScriptCard.put("icon", "md-analytics");
        dataScriptCard.put("count", scriptId);
        dataScriptCard.put("color", "#2d8cf0");
        HashMap<String, Object> totalUsersCard = new HashMap<>(1);
        totalUsersCard.put("title", "累计用户数");
        totalUsersCard.put("icon", "md-people");
        totalUsersCard.put("count", accountsData.get("total"));
        totalUsersCard.put("color", "#19be6b");
        HashMap<String, Object> onlineUsersCard = new HashMap<>(1);
        onlineUsersCard.put("title", "当前活跃用户");
        onlineUsersCard.put("icon", "md-chatbubbles");
        onlineUsersCard.put("count", accountsData.get("online"));
        onlineUsersCard.put("color", "#ff9900");
        return Arrays.asList(dataScriptCard, totalUsersCard, onlineUsersCard);
    }
}
