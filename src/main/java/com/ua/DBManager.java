package com.ua;


import com.ua.entity.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import java.sql.*;


public class DBManager {
    private static final String SQL_INSERT_USER = "insert into users values (DEFAULT, ?, ?)";
    private static DBManager instance;

    public static synchronized DBManager getInstance() {
        if (instance == null) {
            instance = new DBManager();
        }
        return instance;
    }

    private DBManager() {
        try {
            Context initContext = new InitialContext();
            Context envContext = (Context) initContext.lookup("java:/comp/env");
            ds = (DataSource) envContext.lookup("jdbc/TestDB");
        } catch (NamingException ex) {
            throw new IllegalStateException("Cannot init DBManager", ex);
        }
    }

    /////////////////////////////////

    private DataSource ds;

    public Connection getConnection() throws SQLException {
        return ds.getConnection();
    }

}
