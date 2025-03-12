package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    private static Connection connection;
    private static final String URL = "jdbc:mysql://localhost:3306/megacitycab";
    private static final String USERNAME = "root"; 
    private static final String PASSWORD = "MYSQL"; 

    
    private DBConnection() {}

    public static synchronized Connection getConnection() {
        try {
         
            if (connection == null || connection.isClosed()) {
                Class.forName("com.mysql.cj.jdbc.Driver");
                connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        return connection;
    }

	public static void setMockConnection(Connection mockConnection) {
		// TODO Auto-generated method stub
		
	}
}
