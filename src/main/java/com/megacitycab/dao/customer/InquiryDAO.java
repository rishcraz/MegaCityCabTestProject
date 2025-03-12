package dao.customer;

import model.customer.Inquiry;
import util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet; // <-- Added this
import java.util.ArrayList; // <-- Added this
import java.util.List; // <-- And this

public class InquiryDAO {

    // Save customer inquiry
    public boolean saveInquiry(Inquiry inquiry) {
        String query = "INSERT INTO inquiries (user_id, name, email, subject, message) VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setString(1, inquiry.getUserId());
            pstmt.setString(2, inquiry.getName());
            pstmt.setString(3, inquiry.getEmail());
            pstmt.setString(4, inquiry.getSubject());
            pstmt.setString(5, inquiry.getMessage());

            return pstmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // Get all customer inquiries
    public List<Inquiry> getAllInquiries() {
        List<Inquiry> inquiries = new ArrayList<>();
        String query = "SELECT * FROM inquiries ORDER BY created_at DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                Inquiry inquiry = new Inquiry(
                        rs.getInt("inquiry_id"),
                        rs.getString("user_id"),
                        rs.getString("name"),
                        rs.getString("email"),
                        rs.getString("subject"),
                        rs.getString("message"),
                        rs.getString("reply"),
                        rs.getString("status"),
                        rs.getTimestamp("created_at")
                );
                inquiries.add(inquiry);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return inquiries;
    }

    // Get specific inquiry by ID
    public Inquiry getInquiryById(int inquiryId) {
        Inquiry inquiry = null;
        String query = "SELECT * FROM inquiries WHERE inquiry_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setInt(1, inquiryId);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                inquiry = new Inquiry(
                        rs.getInt("inquiry_id"),
                        rs.getString("user_id"),
                        rs.getString("name"),
                        rs.getString("email"),
                        rs.getString("subject"),
                        rs.getString("message"),
                        rs.getString("reply"),
                        rs.getString("status"),
                        rs.getTimestamp("created_at")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return inquiry;
    }

    // Send admin reply and update status
    public boolean sendReply(int inquiryId, String reply) {
        String query = "UPDATE inquiries SET reply = ?, status = 'Replied' WHERE inquiry_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setString(1, reply);
            pstmt.setInt(2, inquiryId);
            return pstmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public List<Inquiry> getInquiriesByUserId(String userId) {
        List<Inquiry> inquiries = new ArrayList<>();
        String query = "SELECT * FROM inquiries WHERE user_id = ? ORDER BY created_at DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setString(1, userId);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                Inquiry inquiry = new Inquiry(
                        rs.getInt("inquiry_id"),
                        rs.getString("user_id"),
                        rs.getString("name"),
                        rs.getString("email"),
                        rs.getString("subject"),
                        rs.getString("message"),
                        rs.getString("reply"),
                        rs.getString("status"),
                        rs.getTimestamp("created_at")
                );
                inquiries.add(inquiry);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return inquiries;
    }

    
    
    
}




