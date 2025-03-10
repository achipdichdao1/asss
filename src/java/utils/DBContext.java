package utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBContext {
    private static final String SERVER_NAME = "localhost";
    private static final String DB_NAME = "EssentialOilsShop";
    private static final String PORT_NUMBER = "1433";
    private static final String USER_NAME = "sa";
    private static final String PASSWORD = "123456";
    
    public static Connection getConnection() throws Exception {
        try {
            String url = "jdbc:sqlserver://" + SERVER_NAME + ":" + PORT_NUMBER + ";databaseName=" + DB_NAME;
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            return DriverManager.getConnection(url, USER_NAME, PASSWORD);
        } catch (ClassNotFoundException | SQLException ex) {
            throw new Exception("Database Connection Error: " + ex.getMessage());
        }
    }
    
    // Test connection method
    public static void main(String[] args) {
        try {
            Connection conn = getConnection();
            if (conn != null) {
                System.out.println("Connect to database successfully!");
                conn.close();
            } else {
                System.out.println("Connect to database failed!");
            }
        } catch (Exception e) {
            System.out.println("Database connection error: " + e.getMessage());
        }
    }
}