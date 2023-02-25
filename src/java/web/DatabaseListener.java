/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package web;

import db.*;
import java.sql.*;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import org.sqlite.SQLiteConfig;

/**
 *
 * @author user
 */
public class DatabaseListener implements ServletContextListener{
    public static final String CLASS_NAME = "org.sqlite.JDBC";
    public static final String URL = "jdbc:sqlite:case.db";
    public static Exception exception = null;
    
    public static Connection getConnection() throws Exception {
        Class.forName(CLASS_NAME);
        Connection connection = null;
            SQLiteConfig config = new SQLiteConfig();
            config.enforceForeignKeys(true);
            connection = DriverManager.getConnection(URL, config.toProperties());
        return connection;

    }
    
    @Override
    public void contextInitialized(ServletContextEvent sce){
        try{
            Class.forName(CLASS_NAME);
            Connection con = getConnection();
            Statement stmt = con.createStatement();
            //stmt.execute("DROP TABLE movimentacao");
            //stmt.execute("DROP TABLE container");
            stmt.execute(Container.getContainerCreateStatement());
            stmt.execute(Movimentacao.getMovimentacaoCreateStatement());
            stmt.execute("PRAGMA foreign_keys = ON");
            stmt.execute("INSERT OR IGNORE INTO container VALUES (1,'Fulano da Silva', 'ABCD1234567', 20, 'Cheio', 'Importação')");
            stmt.execute("INSERT OR IGNORE INTO container VALUES (2,'Teste', 'EFGH1234567', 40, 'Vazio', 'Exportação')");
            stmt.execute("INSERT OR IGNORE INTO movimentacao VALUES (1, 1,'Gate In', '12/04/2022', '12/04/2022', '12:30:24', '13:00:59')");
            stmt.execute("INSERT OR IGNORE INTO movimentacao VALUES (2, 2,'Gate Out', '15/04/2022', '12/12/2022', '23:30:24', '18:05:59')");
            
        } catch (Exception ex) {
            exception = ex;
        }
    }
}
