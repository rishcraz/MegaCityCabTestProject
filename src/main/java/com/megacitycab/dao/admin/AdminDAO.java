package com.megacitycab.dao.admin;


import java.sql.Connection;
import java.sql.PreparedStatement;

import com.megacitycab.model.admin.Employee;
import com.megacitycab.util.DBConnection;


public class AdminDAO {
    public boolean registerEmployee(Employee employee) {
        boolean status = false;
        try {
            Connection conn = DBConnection.getConnection();
            String sql = "INSERT INTO employees (employeeID, username, password, email, role) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, employee.getEmployeeID());
            stmt.setString(2, employee.getUsername());
            stmt.setString(3, employee.getPassword());
            stmt.setString(4, employee.getEmail());
            stmt.setString(5, employee.getRole());

            int rows = stmt.executeUpdate();
            if (rows > 0) {
                status = true;
            }
            stmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return status;
    }
}
