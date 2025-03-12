package dao.customer;

import model.customer.Billing;
import util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BillingDAO {
	
	
	
	
	public List<Billing> getCompletedPayments() {
	    List<Billing> paymentHistory = new ArrayList<>();
	    String sql = "SELECT order_number, total_fare, tax_amount, discount_amount, final_amount, " +
	                 "payment_method, payment_status, generated_at " +
	                 "FROM billing WHERE payment_status = 'Paid' ORDER BY generated_at DESC";

	    try (Connection conn = DBConnection.getConnection();
	         PreparedStatement stmt = conn.prepareStatement(sql);
	         ResultSet rs = stmt.executeQuery()) {

	        while (rs.next()) {
	            paymentHistory.add(new Billing(
	                rs.getString("order_number"),
	                rs.getDouble("total_fare"),
	                rs.getDouble("tax_amount"),
	                rs.getDouble("discount_amount"),
	                rs.getDouble("final_amount"),
	                rs.getString("payment_method"),
	                rs.getString("payment_status"),
	                rs.getTimestamp("generated_at").toString() // Convert timestamp to string
	            ));
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return paymentHistory;
	}

	
	
	public List<Billing> getPendingBills() {
	    List<Billing> pendingBills = new ArrayList<>();
	    String sql = "SELECT b.order_number, bk.customer_name, bk.pickup_location, bk.destination, " +
	                 "b.total_fare, b.tax_amount, b.discount_amount, b.final_amount, b.payment_status " +
	                 "FROM billing b " +
	                 "JOIN bookings bk ON b.order_number = bk.order_number " +
	                 "WHERE b.payment_status = 'Awaiting Manager Approval'";

	    try (Connection conn = DBConnection.getConnection();
	         PreparedStatement stmt = conn.prepareStatement(sql);
	         ResultSet rs = stmt.executeQuery()) {

	        while (rs.next()) {
	            pendingBills.add(new Billing(
	                rs.getString("order_number"),
	                rs.getString("customer_name"),
	                rs.getString("pickup_location"),
	                rs.getString("destination"),
	                rs.getDouble("total_fare"),
	                rs.getDouble("tax_amount"),
	                rs.getDouble("discount_amount"),
	                rs.getDouble("final_amount"),
	                rs.getString("payment_status")
	            ));
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return pendingBills;
	}
	
	public boolean confirmBill(String orderNumber) {
	    String sql = "UPDATE billing SET payment_status = 'Paid' WHERE order_number = ? AND payment_status = 'Awaiting Manager Approval'";

	    try (Connection conn = DBConnection.getConnection();
	         PreparedStatement stmt = conn.prepareStatement(sql)) {
	        stmt.setString(1, orderNumber);
	        int updatedRows = stmt.executeUpdate();
	        return updatedRows > 0;  // Ensures update was successful
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return false;
	}



   
    public boolean generateBill(String orderNumber, int fareId) {
        String query = "INSERT INTO billing (order_number, fare_id, total_fare, tax_amount, discount_amount, final_amount, payment_status) " +
                       "SELECT ?, ?, (f.base_fare + (b.distance * f.per_km_rate)), " +
                       "(f.tax_rate * (f.base_fare + (b.distance * f.per_km_rate)) / 100), " +
                       "(f.discount * (f.base_fare + (b.distance * f.per_km_rate)) / 100), " +
                       "((f.base_fare + (b.distance * f.per_km_rate)) + " +
                       "(f.tax_rate * (f.base_fare + (b.distance * f.per_km_rate)) / 100) - " +
                       "(f.discount * (f.base_fare + (b.distance * f.per_km_rate)) / 100)), " +
                       "'Pending Payment' FROM bookings b " +
                       "JOIN fare_rates f ON f.id = ? WHERE b.order_number = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, orderNumber);
            stmt.setInt(2, fareId);
            stmt.setInt(3, fareId);
            stmt.setString(4, orderNumber);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

   
    public Billing getBillByOrder(String orderNumber) {
        String query = "SELECT b.order_number, c.customer_name, c.pickup_location, c.destination, " +
                       "b.total_fare, b.tax_amount, b.discount_amount, b.final_amount, b.payment_status " +
                       "FROM billing b JOIN bookings c ON b.order_number = c.order_number " +
                       "WHERE b.order_number = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, orderNumber);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return new Billing(
                    rs.getString("order_number"),
                    rs.getString("customer_name"),
                    rs.getString("pickup_location"),
                    rs.getString("destination"),
                    rs.getDouble("total_fare"),
                    rs.getDouble("tax_amount"),
                    rs.getDouble("discount_amount"),
                    rs.getDouble("final_amount"),
                    rs.getString("payment_status")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

 
    public boolean updatePaymentStatus(String orderNumber, String paymentMethod) {
        String query = "UPDATE billing SET payment_status = ?, payment_method = ? WHERE order_number = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            if ("Cash".equalsIgnoreCase(paymentMethod)) {
                stmt.setString(1, "Paid");
            } else {
                stmt.setString(1, "Awaiting Manager Approval");
            }
            stmt.setString(2, paymentMethod);
            stmt.setString(3, orderNumber);
            int updatedRows = stmt.executeUpdate();
            return updatedRows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
