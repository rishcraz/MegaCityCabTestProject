package model.customer;

import java.time.LocalDateTime;

public class Booking {
    private String orderNumber;
    private String customerName;
    private String address;
    private String telephone;
    private String pickupLocation;
    private String destination;
    private LocalDateTime pickupDateTime;
    private String carType;
    private String status;
    private double distance;

    // New fields for driver assignment
    private String driverId;
    private String driverName;     // Driver's username
    private String driverEmail;    // Driver's email
    private String driverResponse; // Accept/Decline/Completed response
    private String driverStatus;   // Availability: Available, On a Ride, Off Duty

    // Payment method field (NEW)
    private String paymentMethod;

    // Constructor (Main)
    public Booking(String orderNumber, String customerName, String address, String telephone,
                   String pickupLocation, String destination, LocalDateTime pickupDateTime,
                   String carType, String status, double distance) {
        this.orderNumber = orderNumber;
        this.customerName = customerName;
        this.address = address;
        this.telephone = telephone;
        this.pickupLocation = pickupLocation;
        this.destination = destination;
        this.pickupDateTime = pickupDateTime;
        this.carType = carType;
        this.status = status;
        this.distance = distance;
    }

    // Default Constructor
    public Booking() {}

    // Getters and Setters
    public String getOrderNumber() { return orderNumber; }
    public void setOrderNumber(String orderNumber) { this.orderNumber = orderNumber; }

    public String getCustomerName() { return customerName; }
    public void setCustomerName(String customerName) { this.customerName = customerName; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public String getTelephone() { return telephone; }
    public void setTelephone(String telephone) { this.telephone = telephone; }

    public String getPickupLocation() { return pickupLocation; }
    public void setPickupLocation(String pickupLocation) { this.pickupLocation = pickupLocation; }

    public String getDestination() { return destination; }
    public void setDestination(String destination) { this.destination = destination; }

    public LocalDateTime getPickupDateTime() { return pickupDateTime; }
    public void setPickupDateTime(LocalDateTime pickupDateTime) { this.pickupDateTime = pickupDateTime; }

    public String getCarType() { return carType; }
    public void setCarType(String carType) { this.carType = carType; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public double getDistance() { return distance; }
    public void setDistance(double distance) { this.distance = distance; }

    // Driver-related fields
    public String getDriverId() { return driverId; }
    public void setDriverId(String driverId) { this.driverId = driverId; }

    public String getDriverName() { return driverName; }
    public void setDriverName(String driverName) { this.driverName = driverName; }

    public String getDriverEmail() { return driverEmail; }
    public void setDriverEmail(String driverEmail) { this.driverEmail = driverEmail; }

    public String getDriverResponse() { return driverResponse; }
    public void setDriverResponse(String driverResponse) { this.driverResponse = driverResponse; }

    public String getDriverStatus() { return driverStatus; }
    public void setDriverStatus(String driverStatus) { this.driverStatus = driverStatus; }

    // Payment method getter and setter (NEW)
    public String getPaymentMethod() { return paymentMethod; }
    public void setPaymentMethod(String paymentMethod) { this.paymentMethod = paymentMethod; }
}
