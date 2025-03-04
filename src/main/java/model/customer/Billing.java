package model.customer;

public class Billing {
    private String orderNumber;
    private String customerName;
    private String pickupLocation;
    private String destination;
    private double totalFare;
    private double taxAmount;
    private double discountAmount;
    private double finalAmount;
    private String paymentStatus;
    private String paymentMethod;

    // ✅ Constructor with all fields
    public Billing(String orderNumber, String customerName, String pickupLocation, String destination, 
                   double totalFare, double taxAmount, double discountAmount, double finalAmount, 
                   String paymentStatus) {
        this.orderNumber = orderNumber;
        this.customerName = customerName;
        this.pickupLocation = pickupLocation;
        this.destination = destination;
        this.totalFare = totalFare;
        this.taxAmount = taxAmount;
        this.discountAmount = discountAmount;
        this.finalAmount = finalAmount;
        this.paymentStatus = paymentStatus;
    }
    
    
    
    
    private String generatedAt; // Timestamp of payment

 // ✅ Updated Constructor
 public Billing(String orderNumber, double totalFare, double taxAmount, double discountAmount,
                double finalAmount, String paymentMethod, String paymentStatus, String generatedAt) {
     this.orderNumber = orderNumber;
     this.totalFare = totalFare;
     this.taxAmount = taxAmount;
     this.discountAmount = discountAmount;
     this.finalAmount = finalAmount;
     this.paymentMethod = paymentMethod;
     this.paymentStatus = paymentStatus;
     this.generatedAt = generatedAt;
 }

 // ✅ Getter & Setter for Generated Date
 public String getGeneratedAt() {
     return generatedAt;
 }
 public void setGeneratedAt(String generatedAt) {
     this.generatedAt = generatedAt;
 }


    // ✅ Default Constructor
    public Billing() {}

    // ✅ Getters and Setters
    public String getOrderNumber() {
        return orderNumber;
    }

    public void setOrderNumber(String orderNumber) {
        this.orderNumber = orderNumber;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getPickupLocation() {
        return pickupLocation;
    }

    public void setPickupLocation(String pickupLocation) {
        this.pickupLocation = pickupLocation;
    }

    public String getDestination() {
        return destination;
    }

    public void setDestination(String destination) {
        this.destination = destination;
    }

    public double getTotalFare() {
        return totalFare;
    }

    public void setTotalFare(double totalFare) {
        this.totalFare = totalFare;
    }

    public double getTaxAmount() {
        return taxAmount;
    }

    public void setTaxAmount(double taxAmount) {
        this.taxAmount = taxAmount;
    }

    public double getDiscountAmount() {
        return discountAmount;
    }

    public void setDiscountAmount(double discountAmount) {
        this.discountAmount = discountAmount;
    }

    public double getFinalAmount() {
        return finalAmount;
    }

    public void setFinalAmount(double finalAmount) {
        this.finalAmount = finalAmount;
    }

    public String getPaymentStatus() {
        return paymentStatus;
    }

    public void setPaymentStatus(String paymentStatus) {
        this.paymentStatus = paymentStatus;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }
}
