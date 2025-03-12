package dao.admin;

import model.admin.Car;
import util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CarDAO {

    
    public List<Car> getAllCars() {
        List<Car> cars = new ArrayList<>();
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement("SELECT * FROM cars")) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                cars.add(new Car(
                        rs.getString("car_id"),
                        rs.getString("model"),
                        rs.getString("plate_number"),
                        rs.getString("status")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return cars;
    }

   
    public List<Car> getAvailableCars() {
        List<Car> availableCars = new ArrayList<>();
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement("SELECT * FROM cars WHERE status = 'Available'")) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                availableCars.add(new Car(
                        rs.getString("car_id"),
                        rs.getString("model"),
                        rs.getString("plate_number"),
                        rs.getString("status")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return availableCars;
    }

   
    public boolean addCar(String model, String plateNumber, String status) {
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement("INSERT INTO cars (model, plate_number, status) VALUES (?, ?, ?)")) {
            ps.setString(1, model);
            ps.setString(2, plateNumber);
            ps.setString(3, status);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

 
    public boolean updateCar(String carID, String model, String plateNumber, String status) {
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement("UPDATE cars SET model=?, plate_number=?, status=? WHERE car_id=?")) {
            ps.setString(1, model);
            ps.setString(2, plateNumber);
            ps.setString(3, status);
            ps.setString(4, carID);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    
    public boolean deleteCar(String carID) {
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement("DELETE FROM cars WHERE car_id=?")) {
            ps.setString(1, carID);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    
    public boolean assignCarToEmployee(String employeeId, int carId) {
        String sql = "INSERT INTO assigned_cars (employee_id, car_id) VALUES (?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, employeeId);
            pstmt.setInt(2, carId);

            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    
    public Car findCarById(String carId) {
        Car car = null;
        String sql = "SELECT * FROM cars WHERE car_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, carId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    car = new Car();
                    car.setCarID(rs.getString("car_id"));
                    car.setModel(rs.getString("model"));
                    car.setPlateNumber(rs.getString("plate_number"));
                    car.setStatus(rs.getString("status"));
                } else {
                    System.out.println("No car found for ID: " + carId);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return car;
    }

    
    
    public Car getAssignedCarByDriverId(String driverId) {
        Car car = null;
        String sql = "SELECT c.car_id, c.model, c.plate_number, c.status " +
                     "FROM cars c " +
                     "JOIN assigned_cars ac ON c.car_id = ac.car_id " +
                     "WHERE ac.employee_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, driverId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    car = new Car();
                    car.setCarID(rs.getString("car_id"));
                    car.setModel(rs.getString("model"));
                    car.setPlateNumber(rs.getString("plate_number"));
                    car.setStatus(rs.getString("status"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return car;
    }

    
 // Retrieve a single car by ID
    public Car getCarById(String carID) {
        Car car = null;
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement("SELECT * FROM cars WHERE car_id=?")) {
            ps.setString(1, carID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                car = new Car(
                    rs.getString("car_id"),
                    rs.getString("model"),
                    rs.getString("plate_number"),
                    rs.getString("status")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return car;
    }
}
    
    
    
    

