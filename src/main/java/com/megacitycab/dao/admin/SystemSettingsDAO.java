package dao.admin;

import model.admin.SystemSettings;
import util.DBConnection;
import java.sql.*;

public class SystemSettingsDAO {

    public SystemSettings getSettings() {
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement("SELECT * FROM system_settings LIMIT 1");
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return new SystemSettings(
                        rs.getDouble("base_fare"),
                        rs.getDouble("per_km_rate"),
                        rs.getDouble("sedan_multiplier"),
                        rs.getDouble("suv_multiplier"),
                        rs.getDouble("luxury_multiplier"),
                        rs.getDouble("tax_rate"),
                        rs.getDouble("discount_rate")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return new SystemSettings(50.0, 10.0, 1.0, 1.5, 2.0, 5.0, 10.0); 
    }

    public boolean updateSettings(double baseFare, double perKmRate, double sedanMultiplier, double suvMultiplier,
                                  double luxuryMultiplier, double taxRate, double discountRate) {
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(
                     "UPDATE system_settings SET base_fare=?, per_km_rate=?, sedan_multiplier=?, suv_multiplier=?, luxury_multiplier=?, tax_rate=?, discount_rate=?")) {
            ps.setDouble(1, baseFare);
            ps.setDouble(2, perKmRate);
            ps.setDouble(3, sedanMultiplier);
            ps.setDouble(4, suvMultiplier);
            ps.setDouble(5, luxuryMultiplier);
            ps.setDouble(6, taxRate);
            ps.setDouble(7, discountRate);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
