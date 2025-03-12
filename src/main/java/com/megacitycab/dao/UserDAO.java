package dao;

import model.User;
import util.DBConnection;
import org.mindrot.jbcrypt.BCrypt;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {




	/*
	 * public UserDAO(Connection mockConnection) { // TODO Auto-generated
	 * constructor stub }
	 */
	


	// Login Method (Checks both users and employees)
	public User loginUser(String email, String password) { 
	    User user = null;
	    String query = "SELECT user_id, name, email, phone, nic, address, password_hash, role FROM users WHERE email = ? " +
	                   "UNION " +
	                   "SELECT employee_id AS user_id, username AS name, email, '' AS phone, '' AS nic, '' AS address, password AS password_hash, role FROM employees WHERE email = ?";

	    try (Connection conn = DBConnection.getConnection();
	         PreparedStatement pstmt = conn.prepareStatement(query)) {

	        pstmt.setString(1, email);
	        pstmt.setString(2, email);
	        ResultSet rs = pstmt.executeQuery();

	        if (rs.next()) {
	            String hashedPassword = rs.getString("password_hash");
	            String role = rs.getString("role");

	            if ("Deactivated".equalsIgnoreCase(role)) {
	                throw new IllegalStateException("Your account has been deactivated. Please contact our customer portal.");
	            }


	            // Password check for hashed and plain passwords
	            if (hashedPassword.startsWith("$2a$")) { 
	                if (!BCrypt.checkpw(password, hashedPassword)) {
	                    return null; // Wrong password
	                }
	            } else {
	                if (!hashedPassword.equals(password)) {
	                    return null; // Wrong password
	                }
	            }

	            // Create user object only if everything is correct
	            user = new User();
	            user.setUserId(rs.getString("user_id"));
	            user.setName(rs.getString("name"));
	            user.setEmail(rs.getString("email"));
	            user.setPhone(rs.getString("phone"));
	            user.setNic(rs.getString("nic"));
	            user.setAddress(rs.getString("address"));
	            user.setRole(role);
	        }
	    } catch (IllegalStateException e) {
	        throw e; // Rethrow the deactivated account message
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return user;
	}


   
    public boolean registerUser(User user) {
        String query = "INSERT INTO users (user_id, name, email, phone, nic, address, password_hash, role, created_at) " +
                       "VALUES (?, ?, ?, ?, ?, ?, ?, ?, NOW())";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            String hashedPassword = BCrypt.hashpw(user.getPassword(), BCrypt.gensalt());

            pstmt.setString(1, user.getUserId());
            pstmt.setString(2, user.getName());
            pstmt.setString(3, user.getEmail());
            pstmt.setString(4, user.getPhone());
            pstmt.setString(5, user.getNic());
            pstmt.setString(6, user.getAddress());
            pstmt.setString(7, hashedPassword);
            pstmt.setString(8, user.getRole());

            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

  
    public List<User> getAllCustomers() {
        List<User> customers = new ArrayList<>();
        String query = "SELECT user_id, name, email, phone, nic, address, role FROM users WHERE role = 'Customer'";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                customers.add(new User(
                        rs.getString("user_id"),
                        rs.getString("name"),
                        rs.getString("email"),
                        rs.getString("phone"),
                        rs.getString("nic"),
                        rs.getString("address"),
                        null 
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return customers;
    }

   
    public boolean deactivateCustomer(String customerId) {
        String query = "UPDATE users SET role = 'Deactivated' WHERE user_id = ? AND role = 'Customer'";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setString(1, customerId);
            return pstmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    
    
    public User getCustomerById(String userId) {
        User user = null;
        String query = "SELECT user_id, name, email, phone, nic, address, role FROM users WHERE user_id = ? AND role = 'Customer'";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setString(1, userId);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                user = new User();
                user.setUserId(rs.getString("user_id"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setPhone(rs.getString("phone"));
                user.setNic(rs.getString("nic"));
                user.setAddress(rs.getString("address"));
                user.setRole(rs.getString("role"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }

    
    public boolean updateCustomerProfile(User user) {
        String query = "UPDATE users SET name = ?, email = ?, phone = ?, nic = ?, address = ? WHERE user_id = ? AND role = 'Customer'";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setString(1, user.getName());
            pstmt.setString(2, user.getEmail());
            pstmt.setString(3, user.getPhone());
            pstmt.setString(4, user.getNic());
            pstmt.setString(5, user.getAddress());
            pstmt.setString(6, user.getUserId());

            return pstmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    
    
    
    
}

    
    
    