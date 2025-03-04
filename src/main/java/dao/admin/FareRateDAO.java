package dao.admin;

import model.admin.FareRate;
import util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class FareRateDAO {

   
    public List<FareRate> getAllFareRates() {
        List<FareRate> fareRates = new ArrayList<>();
        String sql = "SELECT * FROM fare_rates";
        
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                fareRates.add(new FareRate(
                    rs.getInt("id"),
                    rs.getString("car_type"),
                    rs.getDouble("base_fare"),
                    rs.getDouble("per_km_rate"),
                    rs.getBoolean("multiplier_enabled"),
                    rs.getDouble("multiplier"),
                    rs.getBoolean("tax_enabled"),
                    rs.getDouble("tax_rate"),
                    rs.getDouble("discount")
                ));
            }
        } catch (SQLException e) {
            System.err.println("Error fetching fare rates: " + e.getMessage());
        }
        return fareRates;
    }

    
    public boolean addFareRate(FareRate fare) {
        String sql = "INSERT INTO fare_rates (car_type, base_fare, per_km_rate, multiplier_enabled, multiplier, tax_enabled, tax_rate, discount) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setString(1, fare.getCarType());
            ps.setDouble(2, fare.getBaseFare());
            ps.setDouble(3, fare.getPerKmRate());
            ps.setBoolean(4, fare.isMultiplierEnabled());
            ps.setDouble(5, fare.isMultiplierEnabled() ? fare.getMultiplier() : 1.0); 
            ps.setBoolean(6, fare.isTaxEnabled());
            ps.setDouble(7, fare.isTaxEnabled() ? fare.getTaxRate() : 0.0); 
            ps.setDouble(8, fare.getDiscount());
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error adding fare rate: " + e.getMessage());
        }
        return false;
    }

    // Update an existing fare rate
    public boolean updateFareRate(FareRate fare) {
        String sql = "UPDATE fare_rates SET car_type=?, base_fare=?, per_km_rate=?, multiplier_enabled=?, multiplier=?, tax_enabled=?, tax_rate=?, discount=? WHERE id=?";
        
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setString(1, fare.getCarType());
            ps.setDouble(2, fare.getBaseFare());
            ps.setDouble(3, fare.getPerKmRate());
            ps.setBoolean(4, fare.isMultiplierEnabled());
            ps.setDouble(5, fare.isMultiplierEnabled() ? fare.getMultiplier() : 1.0);
            ps.setBoolean(6, fare.isTaxEnabled());
            ps.setDouble(7, fare.isTaxEnabled() ? fare.getTaxRate() : 0.0);
            ps.setDouble(8, fare.getDiscount());
            ps.setInt(9, fare.getId());
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error updating fare rate: " + e.getMessage());
        }
        return false;
    }


    public boolean deleteFareRate(int id) {
        String sql = "DELETE FROM fare_rates WHERE id=?";
        
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error deleting fare rate: " + e.getMessage());
        }
        return false;
    }

    
    public FareRate getFareRateById(int id) {
        String sql = "SELECT * FROM fare_rates WHERE id=?";
        
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new FareRate(
                        rs.getInt("id"),
                        rs.getString("car_type"),
                        rs.getDouble("base_fare"),
                        rs.getDouble("per_km_rate"),
                        rs.getBoolean("multiplier_enabled"),
                        rs.getDouble("multiplier"),
                        rs.getBoolean("tax_enabled"),
                        rs.getDouble("tax_rate"),
                        rs.getDouble("discount")
                    );
                }
            }
        } catch (SQLException e) {
            System.err.println("Error fetching fare rate by ID: " + e.getMessage());
        }
        return null; 
    }

	public FareRate getFareByCarType(String carType) {
		// TODO Auto-generated method stub
		return null;
	}
}
