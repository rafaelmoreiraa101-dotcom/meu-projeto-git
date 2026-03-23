package br.com.revistaria.dao;

import java.sql.Connection;
import java.sql.DriverManager;

public class Conexao {

    private static final String URL = "jdbc:mysql://localhost:3306/sistema_revistaria";
    private static final String USER = "rafa";
    private static final String PASSWORD = "1234";

    public static Connection getConexao() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");

        Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);

        System.out.println("BANCO CONECTADO: " + conn.getCatalog());

        return conn;
    }
}