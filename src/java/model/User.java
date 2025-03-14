package model;

public class User {
    private int userID;
    private String username;
    private String password;
    private String fullName;
    private String email;
    private String phoneNumber;
    private String role;
    private Integer customerID;
    private boolean status;
    
    // Constructors
    public User() {
    }
    
    public User(int userID, String username, String password, String fullName, String email, 
            String phoneNumber, String role, Integer customerID, boolean status) {
        this.userID = userID;
        this.username = username;
        this.password = password;
        this.fullName = fullName;
        this.email = email;
        this.phoneNumber = phoneNumber;
        this.role = role;
        this.customerID = customerID;
        this.status = status;
    }
    
    // Getters and Setters
    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public Integer getCustomerID() {
        return customerID;
    }

    public void setCustomerID(Integer customerID) {
        this.customerID = customerID;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }
    
    public boolean isAdmin() {
        return "ADMIN".equals(this.role);
    }
    
    public boolean isManager() {
        return "MANAGER".equals(this.role);
    }
}