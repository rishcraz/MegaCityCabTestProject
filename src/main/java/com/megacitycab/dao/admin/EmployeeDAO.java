package com.megacitycab.dao.admin;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.megacitycab.model.admin.Employee;
import com.megacitycab.util.DBConnection;

public class EmployeeDAO {
	
	
	

	public boolean updateDriverAvailability(String employeeId, String availability) {
	    String sql = "UPDATE employees SET availability = ? WHERE employee_id = ?";
	    try (Connection con = DBConnection.getConnection();
	         PreparedStatement stmt = con.prepareStatement(sql)) {
	        stmt.setString(1, availability);
	        stmt.setString(2, employeeId);
	        return stmt.executeUpdate() > 0;
	    } catch (SQLException e) {
	        e.printStackTrace();
	        return false;
	    }
	}

	
	public List<Employee> getAvailableDrivers() {
	    List<Employee> drivers = new ArrayList<>();
	    String sql = "SELECT employee_id, username FROM employees WHERE role = 'Driver' AND availability = 'Available'";
	    try (Connection con = DBConnection.getConnection();
	         PreparedStatement ps = con.prepareStatement(sql);
	         ResultSet rs = ps.executeQuery()) {
	        while (rs.next()) {
	            drivers.add(new Employee(rs.getString("employee_id"), rs.getString("username"), "", "", "Driver"));
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return drivers;
	}


   
    public List<Employee> getAllEmployees() {
        List<Employee> employees = new ArrayList<>();
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement("SELECT * FROM employees")) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                employees.add(new Employee(
                        rs.getString("employee_id"),
                        rs.getString("username"),
                        rs.getString("password"),
                        rs.getString("email"),
                        rs.getString("role")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return employees;
    }

   
    public String generateNextEmployeeID() {
        String prefix = "EMP";
        String nextID = prefix + "001"; 

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement("SELECT employee_id FROM employees ORDER BY employee_id DESC LIMIT 1");
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                String lastID = rs.getString("employee_id");
                int num = Integer.parseInt(lastID.substring(3)); 
                num++;
                nextID = prefix + String.format("%03d", num); 
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return nextID;
    }

   
    public boolean addEmployee(String employeeID, String username, String hashedPassword, String email, String role) {
        boolean isSuccess = false;
        String sql = "INSERT INTO employees (employee_id, username, password, email, role) VALUES (?, ?, ?, ?, ?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setString(1, employeeID);
            ps.setString(2, username);
            ps.setString(3, hashedPassword);
            ps.setString(4, email);
            ps.setString(5, role);

            int rowsAffected = ps.executeUpdate();
            isSuccess = rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return isSuccess;
    }

    // Delete an employee
    public boolean deleteEmployee(String employeeId) {
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement("DELETE FROM employees WHERE employee_id = ?")) {
            ps.setString(1, employeeId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    
    public Employee getEmployeeById(String employeeId) {
        Employee employee = null;
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement("SELECT * FROM employees WHERE employee_id = ?")) {
            ps.setString(1, employeeId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                employee = new Employee(
                        rs.getString("employee_id"),
                        rs.getString("username"),
                        rs.getString("password"),
                        rs.getString("email"),
                        rs.getString("role")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return employee;
    }

    
    public boolean updateEmployee(String employeeId, String username, String password, String email, String role) {
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement("UPDATE employees SET username=?, password=?, email=?, role=? WHERE employee_id=?")) {
            ps.setString(1, username);
            ps.setString(2, password);
            ps.setString(3, email);
            ps.setString(4, role);
            ps.setString(5, employeeId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    
    
    public Employee getDriverById(String driverId) {
        Employee driver = null;
        String query = "SELECT employee_id, username, email, role FROM employees WHERE employee_id = ? AND role = 'Driver'";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setString(1, driverId);
            System.out.println("Executing query for driver: " + query);

            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                System.out.println("Driver found: " + rs.getString("username"));
                driver = new Employee(
                        rs.getString("employee_id"),
                        rs.getString("username"),
                        null,
                        rs.getString("email"),
                        rs.getString("role")
                );
            } else {
                System.out.println("Driver not found with ID: " + driverId);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return driver;
    }


    
    
    public boolean updateDriverStatus(String driverId, String status) {
        String query = "UPDATE employees SET status = ? WHERE employee_id = ? AND role = 'Driver'";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setString(1, status);
            pstmt.setString(2, driverId);

            return pstmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    
    
    
    
    public Employee findEmployeeById(String employeeId) {
        Employee employee = null;
        String sql = "SELECT employee_id, username, email, phone FROM employees WHERE employee_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, employeeId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    employee = new Employee();
                    employee.setEmployeeID(rs.getString("employee_id"));
                    employee.setUsername(rs.getString("username"));
                    employee.setEmail(rs.getString("email"));
                    employee.setPhone(rs.getString("phone"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return employee;
    }
    
    
    
    
    public boolean updateDriverProfile(Employee driver) {
        String sql = "UPDATE employees SET username = ?, email = ?, phone = ? WHERE employee_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, driver.getUsername());
            ps.setString(2, driver.getEmail());
            ps.setString(3, driver.getPhone());
            ps.setString(4, driver.getEmployeeID());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
    
    
    
 
    
   
