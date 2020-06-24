package cn.hitek.authorization.ilis2.product.base.domain.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
public class Relation {

    private String source;
    private String target;
}
