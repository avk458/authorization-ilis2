package cn.hitek.authorization.ilis2.product.database.helper;

import cn.hitek.authorization.ilis2.product.database.domain.UnitDatabase;
import cn.hitek.authorization.ilis2.product.unit.domain.Unit;
import cn.hitek.authorization.ilis2.product.unit.mapper.UnitMapper;
import cn.hutool.core.util.IdUtil;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

/**
 * @author chenlm
 */
@Component
@RequiredArgsConstructor
public class DynamicScript {

    private final UnitMapper unitMapper;

    public List<String> getScripts(UnitDatabase database) {
        final DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        String databaseName = database.getDatabaseName();
        Unit unit = this.unitMapper.selectById(database.getUnitId());
        String unitName = unit.getName();
        String unitShortName = unit.getUnitShortName();
        Objects.requireNonNull(unit, "不能获取到单位信息");
        ArrayList<String> strings = new ArrayList<>(2);
        String ilisDepartVersion = "REPLACE INTO %s.t_s_depart_version VALUES ('402882105ec60bc0015ec6262d3d0003', null, 'A03', '%s', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 0, '%s', '%s', '1', null, null, null, null, null, null, null, '', '', null, null, null, '%s', '');";
        String ilisDepart = "update %s.t_s_depart set departname = '%s', org_code = 'A03', org_type = '1' WHERE ID = '8a8ab0b246dc81120146dc8180ba0017';";
        String ilisSnCategoryOrg = "INSERT INTO %s.t_sn_category_org VALUES ('%s', null, null, null, null, null, null, '%s', '%s', '%s', 0, '%s', '');";
        LocalDateTime date = LocalDateTime.now();
        String now = date.format(formatter);
        String twentyYearsLater = date.plusYears(20).format(formatter);
        strings.add(String.format(ilisDepartVersion, databaseName, unitName, now, twentyYearsLater, unitShortName));
        strings.add(String.format(ilisDepart, databaseName, unitName));
        strings.add(String.format(ilisSnCategoryOrg, databaseName, IdUtil.simpleUUID(), "A03", "8a8ab0b246dc81120146dc8180ba0017", "2c9284d07357297e01735a6f21da006d", unitName));
        strings.addAll(UnitInfoScripts.get(unit.getCenterUnitId(), unitName));
        return strings;
    }
}
