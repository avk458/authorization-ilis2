package cn.hitek.authorization.ilis2.product.base.domain.dto;

import lombok.Data;
import lombok.NonNull;
import lombok.RequiredArgsConstructor;

import java.util.ArrayList;
import java.util.List;

/**
 * @author chenlm
 */
@Data
@RequiredArgsConstructor
public class CascadeMenu {

    @NonNull
    private String value;
    @NonNull
    private String label;
    private boolean loading;
    private List<CascadeMenu> children = new ArrayList<>(0);
}
