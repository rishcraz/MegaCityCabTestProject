package com.megacitycab.dao.customer;

import java.sql.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

import com.megacitycab.model.customer.Booking;
import com.megacitycab.util.DBConnection;

public class BookingDAO {
    private Connection connection;

    public BookingDAO() {
        connection = DBConnection.getConnection();
    }
    
    
    public List<Booking> getCancelledBookings() {
        List<Booking> cancelledBookings = new ArrayList<>();
        String sql = "SELECT * FROM bookings WHERE status = 'Cancelled'";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Booking booking = new Booking();
                booking.setOrderNumber(rs.getString("order_number"));
                booking.setCustomerName(rs.getString("customer_name"));
                booking.setPickupLocation(rs.getString("pickup_location"));
                booking.setDestination(rs.getString("destination"));
                booking.setDistance(rs.getDouble("distance")); // Fetch distance
                booking.setPickupDateTime(rs.getTimestamp("pickup_datetime").toLocalDateTime());
                booking.setCarType(rs.getString("car_type"));
                booking.setStatus(rs.getString("status"));
                cancelledBookings.add(booking);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return cancelledBookings;
    }

    
    
    public List<Booking> getConfirmedBookings() {
        List<Booking> bookings = new ArrayList<>();
        String sql = "SELECT * FROM bookings WHERE status IN ('Confirmed', 'Cancelled by Manager', 'Cancelled by Customer')";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Booking booking = new Booking();
                booking.setOrderNumber(rs.getString("order_number"));
                booking.setCustomerName(rs.getString("customer_name"));
                booking.setPickupLocation(rs.getString("pickup_location"));
                booking.setDestination(rs.getString("destination"));
                booking.setDistance(rs.getDouble("distance")); // Fetch distance
                booking.setPickupDateTime(rs.getTimestamp("pickup_datetime").toLocalDateTime());
                booking.setCarType(rs.getString("car_type"));
                booking.setStatus(rs.getString("status"));
                bookings.add(booking);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return bookings;
    }

    
    
    
    public boolean rejectBooking(String orderNumber) {
        String sql = "UPDATE bookings SET status = 'Cancelled by Manager' WHERE order_number = ?";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, orderNumber);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    
    public String getBookingStatus(String orderNumber) {
        String query = "SELECT status FROM bookings WHERE order_number = ?";

        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, orderNumber);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getString("status");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return "Unknown";
    }



    // Get all pending bookings
    public List<Booking> getPendingBookings() {
        List<Booking> bookings = new ArrayList<>();
        String query = "SELECT * FROM bookings WHERE status = 'Pending'";

        try (PreparedStatement ps = connection.prepareStatement(query); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                bookings.add(mapResultSetToBooking(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return bookings;
    }

 

   
    public List<Booking> getConfirmedBookings(String customerId) {
        List<Booking> bookings = new ArrayList<>();
        String query = "SELECT * FROM bookings WHERE status = 'Confirmed' AND customer_id = ?";

        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, customerId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    bookings.add(mapResultSetToBooking(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return bookings;
    }

    
    public boolean confirmBooking(String orderNumber) {
        String query = "UPDATE bookings SET status = 'Confirmed' WHERE order_number = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, orderNumber);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }


    public boolean updatePaymentStatus(String orderNumber, String paymentMethod) {
        String sql = "UPDATE bookings SET status = 'Paid', payment_method = ? WHERE order_number = ?";
        
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, paymentMethod);
            stmt.setString(2, orderNumber);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

  
    public boolean addBooking(Booking booking) {
        String sql = "INSERT INTO bookings (order_number, customer_name, address, telephone, pickup_location, destination, pickup_datetime, car_type, status, distance) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, booking.getOrderNumber());
            stmt.setString(2, booking.getCustomerName());
            stmt.setString(3, booking.getAddress());
            stmt.setString(4, booking.getTelephone());
            stmt.setString(5, booking.getPickupLocation());
            stmt.setString(6, booking.getDestination());
            
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
            stmt.setString(7, booking.getPickupDateTime().format(formatter));
            
            stmt.setString(8, booking.getCarType());
            stmt.setString(9, booking.getStatus());
            stmt.setDouble(10, booking.getDistance());

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

   
    public List<Booking> getAllBookings() {
        List<Booking> bookings = new ArrayList<>();
        String sql = "SELECT * FROM bookings ORDER BY pickup_datetime DESC";

        try (Statement stmt = connection.createStatement(); ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                bookings.add(mapResultSetToBooking(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return bookings;
    }

    
    public Booking getBookingByOrderNumber(String orderNumber) {
        String sql = "SELECT * FROM bookings WHERE order_number = ?";
        
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, orderNumber);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToBooking(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean cancelBooking(String orderNumber) {
        String sql = "UPDATE bookings SET status = 'Cancelled' WHERE order_number = ? AND (status = 'Pending' OR status = 'Confirmed')";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, orderNumber);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    
    public boolean updateBooking(String orderNumber, String pickupLocation, String destination, LocalDateTime pickupDateTime, String carType) {
        String sql = "UPDATE bookings SET pickup_location = ?, destination = ?, pickup_datetime = ?, car_type = ? WHERE order_number = ? AND status = 'Pending'";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, pickupLocation);
            stmt.setString(2, destination);
            stmt.setTimestamp(3, Timestamp.valueOf(pickupDateTime));
            stmt.setString(4, carType);
            stmt.setString(5, orderNumber);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

  
    private Booking mapResultSetToBooking(ResultSet rs) throws SQLException {
        return new Booking(
            rs.getString("order_number"),
            rs.getString("customer_name"),
            rs.getString("address"),
            rs.getString("telephone"),
            rs.getString("pickup_location"),
            rs.getString("destination"),
            rs.getTimestamp("pickup_datetime").toLocalDateTime(),
            rs.getString("car_type"),
            rs.getString("status"),
            rs.getDouble("distance")
        );
    }

    public Booking getBookingDetails(String orderNumber) {
        return getBookingByOrderNumber(orderNumber);
    }


	
	

	public boolean assignDriverToOrder(String driverId, String orderNumber) {
	    String query = "INSERT INTO assigned_drivers (order_number, driver_id) VALUES (?, ?)";

	    try (Connection conn = DBConnection.getConnection();
	         PreparedStatement pstmt = conn.prepareStatement(query)) {

	        pstmt.setString(1, orderNumber);
	        pstmt.setString(2, driverId);
	        return pstmt.executeUpdate() > 0;
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return false;
	}

	public Booking findSimpleBookingByOrderNumber(String orderNumber) {
	    Booking booking = null;
	    String sql = "SELECT order_number, customer_name, address, telephone, pickup_location, destination, pickup_datetime FROM bookings WHERE order_number = ?";

	    try (Connection conn = DBConnection.getConnection();
	         PreparedStatement ps = conn.prepareStatement(sql)) {

	        ps.setString(1, orderNumber);
	        try (ResultSet rs = ps.executeQuery()) {
	            if (rs.next()) {
	                booking = new Booking();
	                booking.setOrderNumber(rs.getString("order_number"));
	                booking.setCustomerName(rs.getString("customer_name"));
	                booking.setAddress(rs.getString("address"));
	                booking.setTelephone(rs.getString("telephone"));
	                booking.setPickupLocation(rs.getString("pickup_location"));
	                booking.setDestination(rs.getString("destination"));
	                booking.setPickupDateTime(rs.getTimestamp("pickup_datetime").toLocalDateTime());
	            } else {
	                System.out.println("No booking found for order number: " + orderNumber);
	            }
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return booking;
	}
	
	
	
	public boolean updateRideStatus(String orderNumber, String driverId, String status) {
	    String sql = "UPDATE assigned_drivers SET ride_status = ? WHERE order_number = ? AND driver_id = ?";

	    try (Connection conn = DBConnection.getConnection();
	         PreparedStatement pstmt = conn.prepareStatement(sql)) {

	        pstmt.setString(1, status);
	        pstmt.setString(2, orderNumber);
	        pstmt.setString(3, driverId);
	        return pstmt.executeUpdate() > 0;
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return false;
	}


	public List<Booking> getAllDriversAvailability() {
	    List<Booking> availability = new ArrayList<>();
	    String query = "SELECT e.employee_id, e.username AS driver_name, e.email, e.status " +
	                   "FROM employees e " +
	                   "WHERE e.role = 'Driver'";

	    System.out.println("Fetching driver availability...");
	    System.out.println("Query executed: " + query);

	    try (Connection conn = DBConnection.getConnection();
	         PreparedStatement pstmt = conn.prepareStatement(query);
	         ResultSet rs = pstmt.executeQuery()) {

	        while (rs.next()) {
	            Booking booking = new Booking();
	            booking.setDriverId(rs.getString("employee_id"));
	            booking.setDriverName(rs.getString("driver_name"));
	            booking.setDriverEmail(rs.getString("email"));
	            booking.setDriverStatus(rs.getString("status")); // <- FIXED column name
	            availability.add(booking);
	        }
	    } catch (SQLException e) {
	        System.out.println("Error fetching driver availability!");
	        e.printStackTrace();
	    }
	    return availability;
	}
	
	

	
	
	public List<Booking> getAllDriverResponses() {
	    List<Booking> responses = new ArrayList<>();
	    String query = "SELECT ad.order_number, ad.driver_id, e.username AS driver_name, ad.driver_response, ad.payment_method " +
	                   "FROM assigned_drivers ad " +
	                   "JOIN employees e ON ad.driver_id = e.employee_id";

	    try (Connection conn = DBConnection.getConnection();
	         PreparedStatement pstmt = conn.prepareStatement(query);
	         ResultSet rs = pstmt.executeQuery()) {

	        while (rs.next()) {
	            Booking booking = new Booking();
	            booking.setOrderNumber(rs.getString("order_number"));
	            booking.setDriverId(rs.getString("driver_id"));
	            booking.setDriverName(rs.getString("driver_name"));
	            booking.setDriverResponse(rs.getString("driver_response"));
	            booking.setPaymentMethod(rs.getString("payment_method")); // Make sure we're setting this
	            responses.add(booking);
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return responses;
	}

	
	
	
	 public List<Booking> getBookingsByDriverId(String driverId) {
	        List<Booking> bookings = new ArrayList<>();
	        String sql = "SELECT b.order_number, b.customer_name, b.pickup_location, b.destination, b.pickup_datetime, " +
	                     "ad.driver_response, ad.payment_method " +
	                     "FROM bookings b " +
	                     "JOIN assigned_drivers ad ON b.order_number = ad.order_number " +
	                     "WHERE ad.driver_id = ?";

	        try (PreparedStatement ps = connection.prepareStatement(sql)) {
	            ps.setString(1, driverId);
	            try (ResultSet rs = ps.executeQuery()) {
	                while (rs.next()) {
	                    Booking booking = new Booking();
	                    booking.setOrderNumber(rs.getString("order_number"));
	                    booking.setCustomerName(rs.getString("customer_name"));
	                    booking.setPickupLocation(rs.getString("pickup_location"));
	                    booking.setDestination(rs.getString("destination"));
	                    booking.setPickupDateTime(rs.getTimestamp("pickup_datetime").toLocalDateTime());
	                    booking.setDriverResponse(rs.getString("driver_response"));
	                    booking.setPaymentMethod(rs.getString("payment_method"));
	                    bookings.add(booking);
	                }
	            }
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	        return bookings;
	    }

	    // Update driver response
	    public boolean updateDriverResponse(String orderNumber, String driverId, String response) {
	        String sql = "UPDATE assigned_drivers SET driver_response = ? WHERE order_number = ? AND driver_id = ?";

	        try (PreparedStatement ps = connection.prepareStatement(sql)) {
	            ps.setString(1, response);
	            ps.setString(2, orderNumber);
	            ps.setString(3, driverId);
	            return ps.executeUpdate() > 0;
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	        return false;
	    }

	    // Update payment method
	    public boolean updatePaymentMethod(String orderNumber, String driverId, String paymentMethod) {
	        String sql = "UPDATE assigned_drivers SET payment_method = ? WHERE order_number = ? AND driver_id = ?";

	        try (PreparedStatement ps = connection.prepareStatement(sql)) {
	            ps.setString(1, paymentMethod);
	            ps.setString(2, orderNumber);
	            ps.setString(3, driverId);
	            return ps.executeUpdate() > 0;
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	        return false;
	    }
	}
	
	
	
	
	

	
	
	


