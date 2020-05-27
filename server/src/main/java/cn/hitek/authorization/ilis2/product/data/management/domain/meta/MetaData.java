/*
 * Copyright (C) 2016 alchemystar, Inc. All Rights Reserved.
 */
package cn.hitek.authorization.ilis2.product.data.management.domain.meta;

import cn.hitek.authorization.ilis2.product.database.helper.SqlUtil;
import lombok.Builder;
import lombok.Data;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedHashMap;
import java.util.Map;


/**
 * @author chenlm
 */
@Data
@Builder
public class MetaData {

    private Connection connection;
    private String schema;

    private Map<String, Table> tables;

    public void init() throws SQLException {
        tables = new LinkedHashMap<>(0);
        getTablesFromDb();
        getCreateTables();
        getAllTableColumns();
        getAllTableKeys();
    }

    private void getTablesFromDb() throws SQLException {
        ResultSet rs = SqlUtil.executeQuery(connection, "show full tables from " + schema + " where Table_Type != 'VIEW'");
        while (rs.next()) {
            Table table = new Table();
            table.setTableName(rs.getString("Tables_in_" + schema));
            tables.put(table.getTableName(), table);
        }
    }

    private void getCreateTables() throws SQLException {
        for (Table table : tables.values()) {
            getCreateTable(table);
        }
    }

    private void getCreateTable(Table table) throws SQLException {
        ResultSet rs = SqlUtil.executeQuery(connection, "show create table " + schema + "." + table.getTableName());
        while (rs.next()) {
            table.setCreateTable(rs.getString("Create Table"));
        }
    }

    private void getAllTableColumns() throws SQLException {
        for (Table table : tables.values()) {
            getTableColumns(table);
        }
    }

    private void getTableColumns(Table table) throws SQLException {
        ResultSet rs = SqlUtil.executeQuery(connection, "select COLUMN_NAME,COLUMN_TYPE,IS_NULLABLE,COLUMN_DEFAULT,"
                + "COLUMN_COMMENT,EXTRA,CHARACTER_SET_NAME,COLLATION_NAME from information_schema.columns where TABLE_SCHEMA=" + "'" + schema + "'"
                + " and "
                + "TABLE_NAME=" + "'" + table.getTableName() + "'" + " order by ORDINAL_POSITION asc");
        while (rs.next()) {
            Column column = new Column();
            column.setName(rs.getString("COLUMN_NAME"));
            column.setType(rs.getString("COLUMN_TYPE"));
            column.setDefaultValue(rs.getString("COLUMN_DEFAULT"));
            column.setIsNull(rs.getString("IS_NULLABLE"));
            column.setExtra(rs.getString("EXTRA"));
            column.setComment(rs.getString("COLUMN_COMMENT"));
            column.setCollate(rs.getString("COLLATION_NAME"));
            table.getColumns().put(column.getName(), column);
        }
    }

    private void getAllTableKeys() throws SQLException {
        for (Table table : tables.values()) {
            getTableKeys(table);
        }
    }

    private void getTableKeys(Table table) throws SQLException {
        ResultSet rs = SqlUtil.executeQuery(connection, "show keys from " + schema + "." + table.getTableName());
        Index last = null;
        while (rs.next()) {
            String keyName = rs.getString("Key_name");
            if (last == null || !keyName.equals(last.getIndexName())) {
                last = new Index();
                last.setIndexName(keyName);
                last.getColumns().add(rs.getString("Column_name"));
                last.setNotUnique(rs.getString("Non_unique"));
                table.getIndexes().put(last.getIndexName(), last);
            } else {
                last.getColumns().add(rs.getString("Column_name"));
            }
        }
    }
}
