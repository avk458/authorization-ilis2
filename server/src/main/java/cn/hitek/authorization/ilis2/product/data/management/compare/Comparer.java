/*
 * Copyright (C) 2016 alchemystar, Inc. All Rights Reserved.
 */
package cn.hitek.authorization.ilis2.product.data.management.compare;

import cn.hitek.authorization.ilis2.product.data.management.domain.meta.Column;
import cn.hitek.authorization.ilis2.product.data.management.domain.meta.Index;
import cn.hitek.authorization.ilis2.product.data.management.domain.meta.MetaData;
import cn.hitek.authorization.ilis2.product.data.management.domain.meta.Table;
import lombok.SneakyThrows;

import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;


/**
 * @author chenlm
 */
public class Comparer {

    private final MetaData source;
    private final MetaData target;
    private final List<String> sqlContainer;

    public Comparer(MetaData source, MetaData target) {
        this.source = source;
        this.target = target;
        sqlContainer = new ArrayList<>();
    }

    @SneakyThrows
    public void execute() {
        Statement statement = target.getConnection().createStatement();
        statement.execute("USE " + target.getSchema());
        for (String sql : sqlContainer) {
            System.out.println(sql);
            statement.execute(sql);
        }
    }

    private void addSql(String sql) {
        this.sqlContainer.add(sql + ";");
    }

    private String singleQuote(String value) {
        return "'" + value + "'";
    }

    private String backtick(String value) {
        return "`" + value + "`";
    }

    public void compare() {
        compareTables();
        compareKeys();
    }

    private void compareTables() {
        for (Table sourceTable : source.getTables().values()) {
            if (target.getTables().get(sourceTable.getTableName()) == null) {
                addSql(sourceTable.getCreateTable());
                continue;
            }
            compareSingleTable(sourceTable, target.getTables().get(sourceTable.getTableName()));
        }
        for (Table targetTable : target.getTables().values()) {
            if (source.getTables().get(targetTable.getTableName()) == null) {
                String dropTableSql = "drop table " + target.getSchema() + "." + targetTable.getTableName();
                addSql(dropTableSql);
            }
        }
    }

    private void compareSingleTable(Table sourceTable, Table targetTable) {
        compareColumns(sourceTable, targetTable);
    }

    private void compareColumns(Table sourceTable, Table targetTable) {
        String after = null;
        for (Column column : sourceTable.getColumns().values()) {
            if (targetTable.getColumns().get(column.getName()) == null) {
                String sql = "alter table " + target.getSchema() + "." + targetTable.getTableName() + " add " +
                        backtick(column.getName()) + " ";
                sql += column.getType() + " ";
                if ("NO".equals(column.getIsNull())) {
                    sql += "NOT NULL ";
                } else {
                    sql += "NULL ";
                }
                if (column.getCollate() != null) {
                    sql += "COLLATE " + singleQuote(column.getCollate()) + " ";
                }
                if (column.getDefaultValue() != null) {
                    sql += "DEFAULT " + singleQuote(column.getDefaultValue()) + " ";
                } else {
                    if (!sql.contains("NOT NULL")) {
                        sql += "DEFAULT NULL ";
                    }
                }
                if (column.getComment() != null) {
                    sql += "COMMENT " + singleQuote(column.getComment()) + " ";
                }
                if (after != null) {
                    sql += "after " + backtick(after);
                }
                addSql(sql);
            } else {
                String sql =
                        "alter table " + target.getSchema() + "." + backtick(targetTable.getTableName()) + " change " +
                                backtick(column.getName()) + " ";
                Column targetColumn = targetTable.getColumns().get(column.getName());
                String sqlExtend = compareSingleColumn(column, targetColumn);
                if (sqlExtend != null) {
                    addSql(sql + sqlExtend);
                }
            }
            after = column.getName();
        }

        for (Column column : targetTable.getColumns().values()) {
            if (sourceTable.getColumns().get(column.getName()) == null) {
                String sql = "alter table " + target.getSchema() + "." + targetTable.getTableName() + " drop " +
                        backtick(column.getName()) + " ";
                addSql(sql);
            }
        }
    }

    private String compareSingleColumn(Column sourceColumn, Column targetColumn) {
        if (sourceColumn.equals(targetColumn)) {
            return null;
        }
        String changeSql = "";
        changeSql += sourceColumn.getName() + " ";
        changeSql += sourceColumn.getType() + " ";
        if ("NO".equals(sourceColumn.getIsNull())) {
            changeSql += "NOT NULL ";
        } else {
            changeSql += "NULL ";
        }
        if (sourceColumn.getCollate() != null) {
            changeSql += "COLLATE " + singleQuote(sourceColumn.getCollate()) + " ";
        }
        if (sourceColumn.getExtra().toUpperCase().contains("AUTO_INCREMENT")) {
            changeSql += "AUTO_INCREMENT ";
        }
        if (sourceColumn.getDefaultValue() != null) {
            changeSql += "DEFAULT " + singleQuote(sourceColumn.getDefaultValue()) + " ";
        } else {
            if (!changeSql.contains("NOT NULL")) {
                changeSql += "DEFAULT NULL ";
            }
        }
        if (sourceColumn.getComment() != null) {
            changeSql += "COMMENT " + singleQuote(sourceColumn.getComment()) + " ";
        }
        return changeSql;
    }

    private void compareKeys() {
        for (Table table : source.getTables().values()) {
            if (target.getTables().get(table.getTableName()) != null) {
                compareSingleKeys(table, target.getTables().get(table.getTableName()));
            }
        }
    }

    private void compareSingleKeys(Table sourceTable, Table targetTable) {
        for (Index index : sourceTable.getIndexes().values()) {
            StringBuilder sql = new StringBuilder("alter table " + target.getSchema() + "." + targetTable.getTableName() + " ");
            if (targetTable.getIndexes().get(index.getIndexName()) == null) {
                if ("PRIMARY".equals(index.getIndexName())) {
                    sql.append("add primary key ");
                } else {
                    if ("0".equals(index.getNotUnique())) {
                        sql.append("add unique ").append(index.getIndexName()).append(" ");
                    } else {
                        sql.append("add index ").append(index.getIndexName()).append(" ");
                    }
                }
                sql.append("(`");
                for (String key : index.getColumns()) {
                    sql.append(key.trim()).append("`,`");
                }
                sql = new StringBuilder(sql.substring(0, sql.length() - 2) + ")");
                sqlContainer.add(sql + ";");
            }
        }
        for (Index index : targetTable.getIndexes().values()) {
            if (sourceTable.getIndexes().get(index.getIndexName()) == null) {
                String sql = "alter table " + target.getSchema() + "." + targetTable.getTableName() + " ";
                if ("PRIMARY".equals(index.getIndexName())) {
                    sql += "drop primary key ";
                } else {
                    sql += "drop index " + index.getIndexName();
                }
                sqlContainer.add(sql + ";");
            }
        }
    }
}
