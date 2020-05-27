/*
 * Copyright (C) 2016 alchemystar, Inc. All Rights Reserved.
 */
package cn.hitek.authorization.ilis2.product.data.management.domain.meta;


import lombok.Data;

/**
 * @author chenlm
 */
@Data
public class Column {

    private String name;
    private String type;
    private String isNull;
    private String defaultValue;
    private String comment;
    private String extra;
    private String collate;
}
