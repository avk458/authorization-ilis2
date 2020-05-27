/*
 * Copyright (C) 2016 alchemystar, Inc. All Rights Reserved.
 */
package cn.hitek.authorization.ilis2.product.data.management.domain.meta;

import lombok.Data;

import java.util.ArrayList;
import java.util.List;


/**
 * @author chenlm
 */
@Data
public class Index {

    private List<String> columns;
    private String indexName;
    private String notUnique;

    public Index() {
        this.columns = new ArrayList<>(0);
    }
}
