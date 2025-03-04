package model.customer;

import java.sql.Timestamp;

public class Inquiry {
    private int inquiryId;
    private String userId;
    private String name;
    private String email;
    private String subject;
    private String message;
    private String reply;
    private String status;
    private Timestamp createdAt;

    // Constructor for saving new inquiries
    public Inquiry(String userId, String name, String email, String subject, String message) {
        this.userId = userId;
        this.name = name;
        this.email = email;
        this.subject = subject;
        this.message = message;
    }

    // Constructor for fetching inquiries from DB
    public Inquiry(int inquiryId, String userId, String name, String email, String subject, String message, String reply, String status, Timestamp createdAt) {
        this.inquiryId = inquiryId;
        this.userId = userId;
        this.name = name;
        this.email = email;
        this.subject = subject;
        this.message = message;
        this.reply = reply;
        this.status = status;
        this.createdAt = createdAt;
    }

    // Getters and Setters
    public int getInquiryId() { return inquiryId; }
    public void setInquiryId(int inquiryId) { this.inquiryId = inquiryId; }

    public String getUserId() { return userId; }
    public void setUserId(String userId) { this.userId = userId; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getSubject() { return subject; }
    public void setSubject(String subject) { this.subject = subject; }

    public String getMessage() { return message; }
    public void setMessage(String message) { this.message = message; }

    public String getReply() { return reply; }
    public void setReply(String reply) { this.reply = reply; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
}
