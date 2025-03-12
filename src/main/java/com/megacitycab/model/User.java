package com.megacitycab.model;

public class User {
    private String userId; // Supports both customers & employees
    private String name;
    private String email;
    private String phone;
    private String nic; 
    private String address; 
    private String password; 
    private String role; // Admin, Manager, Driver, Customer

    public User() {}

    // Constructor for Customers
    public User(String userId, String name, String email, String phone, String nic, String address, String password) {
        this.userId = userId;
        this.name = name;
        this.email = email;
        this.phone = phone;
        this.nic = nic;
        this.address = address;
        this.password = password;
        this.role = "Customer"; 
    }

    // Constructor for Employees (Admin, Manager, Driver)
    public User(String userId, String name, String email, String phone, String password, String role) {
        this.userId = userId;
        this.name = name;
        this.email = email;
        this.phone = phone;
        this.password = password;
        this.role = role;
    }

    // Getters and Setters
    public String getUserId() { return userId; }
    public void setUserId(String userId) { this.userId = userId; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getNic() { return nic; }
    public void setNic(String nic) { this.nic = nic; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }

    // Method to get employee ID (like 'EMP003') for drivers, managers, admins
    public String getEmployeeId() {
        if (role != null && (role.equalsIgnoreCase("admin") || role.equalsIgnoreCase("manager") || role.equalsIgnoreCase("driver"))) {
            return userId; // Assuming userId is used as employeeId for employees
        }
        return null; // Not an employee role
    }
}
