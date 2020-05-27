/*
 * Copyright (C) 2016 alchemystar, Inc. All Rights Reserved.
 */
package cn.hitek.authorization.ilis2.product.data.management.domain.meta;

import lombok.Data;
import lombok.NonNull;
import lombok.RequiredArgsConstructor;

import java.util.LinkedHashMap;
import java.util.Map;

/**
 * @author chenlm
 */
@Data
@RequiredArgsConstructor
public class Table {

    private String tableName;
    private String createTable;
    @NonNull
    private Map<String, Column> columns;
    @NonNull
    private Map<String, Index> indexes;

    public Table() {
        columns = new LinkedHashMap<>();
        indexes = new LinkedHashMap<>();
    }
}
