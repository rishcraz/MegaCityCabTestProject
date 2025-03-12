package model.admin;

public class Employee {
    private String employeeID;
    private String username;
    private String password;
    private String email;
    private String phone; // Adding phone field
    private String role;

    // Constructor with phone field
    public Employee(String employeeID, String username, String password, String email, String phone, String role) {
        this.employeeID = employeeID;
        this.username = username;
        this.password = password;
        this.email = email;
        this.phone = phone;
        this.role = role;
    }

    // Existing constructor without phone (keeping this so old code stays safe)
    public Employee(String employeeID, String username, String password, String email, String role) {
        this.employeeID = employeeID;
        this.username = username;
        this.password = password;
        this.email = email;
        this.role = role;
    }

    // Default constructor
    public Employee() {}

    // Getters and setters
    public String getEmployeeID() { return employeeID; }
    public void setEmployeeID(String employeeID) { this.employeeID = employeeID; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPhone() { return phone; } // New getter for phone
    public void setPhone(String phone) { this.phone = phone; } // New setter for phone

    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }
}
