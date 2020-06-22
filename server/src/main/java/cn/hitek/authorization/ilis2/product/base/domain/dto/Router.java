package cn.hitek.authorization.ilis2.product.base.domain.dto;

import lombok.Data;

import java.util.List;

/**
 * @author chenlm
 */
@Data
public class Router {

    private String path;
    private String name;
    private String component;
    private RouterMeta meta;
    private List<Router> children;
}
