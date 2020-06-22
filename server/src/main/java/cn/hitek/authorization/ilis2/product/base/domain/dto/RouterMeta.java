package cn.hitek.authorization.ilis2.product.base.domain.dto;

import lombok.Data;

import java.util.List;

/**
 * @author chenlm
 */
@Data
public class RouterMeta {

    private String title;
    private boolean hideInBread;
    private boolean hideInMenu;
    private boolean notCache;
    private List<String> access;
    private String icon;

}
