package com.dineease.config;

import java.sql.Connection;
import java.sql.DriverManager;

/**
 * DBConnection
 *
 * Provides a single static method to obtain a JDBC connection
 * to the DineEase MySQL database.
 *
 * Database : dineease_db
 * Host     : localhost (XAMPP)
 * Port     : 3306
 */
public class DBConnection {

    private static final String URL      = "jdbc:mysql://localhost:3306/dineease_db"
                                         + "?useSSL=false"
                                         + "&serverTimezone=UTC"
                                         + "&allowPublicKeyRetrieval=true";
    private static final String USER     = "root";
    private static final String PASSWORD = "";   // XAMPP default — change if you set a password

    // Private constructor — this is a utility class, never instantiate it
    private DBConnection() {}

    /**
     * Opens and returns a new JDBC connection.
     * Caller is responsible for closing it (use try-with-resources).
     *
     * @return a live {@link Connection} to dineease_db
     * @throws Exception if the driver is missing or the connection fails
     */
    public static Connection getConnection() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}