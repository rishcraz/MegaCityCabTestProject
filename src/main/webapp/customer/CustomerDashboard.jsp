<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%
    HttpSession userSession = request.getSession(false);
    String userId = (userSession != null) ? (String) userSession.getAttribute("userId") : null;

    if (userId == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp"); // Redirect to login if not logged in
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Customer Dashboard</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/all_css/customer/dashboard.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <!-- Font Awesome for professional icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
</head>
<body class="bg-light text-dark">
<%@ include file="header.jsp" %>

<div class="dashboard-container">
    <div class="dashboard-header">
        <h2>Welcome to MegaCityCab</h2>
        <p>Your one-stop platform for cab bookings and payments.</p>
    </div>

    <div class="dashboard-grid">
        <!-- Book a Cab -->
        <div class="dashboard-card">
            <div class="icon"><i class="fas fa-taxi"></i></div>
            <h3>Book a Cab</h3>
            <p>Plan your ride easily with our quick booking system.</p>
            <a href="booking.jsp" class="btn btn-primary">Book Now</a>
        </div>

        <!-- View Bookings -->
        <div class="dashboard-card">
            <div class="icon"><i class="fas fa-list-alt"></i></div>
            <h3>View Bookings</h3>
            <p>Check, edit, or cancel your existing bookings.</p>
            <a href="viewBookings.jsp" class="btn btn-info">Manage Bookings</a>
        </div>

        <!-- Billing -->
        <div class="dashboard-card">
            <div class="icon"><i class="fas fa-file-invoice-dollar"></i></div>
            <h3>Billing</h3>
            <p>Check your bills and complete payments.</p>
            <a href="billing.jsp" class="btn btn-success">Go to Billing</a>
        </div>

        <!-- Payment History -->
        <div class="dashboard-card">
            <div class="icon"><i class="fas fa-receipt"></i></div>
            <h3>Payment History</h3>
            <p>View your past payment records and invoices.</p>
            <a href="paymentHistory.jsp" class="btn btn-warning">View History</a>
        </div>

        <!-- Booking History -->
        <div class="dashboard-card">
            <div class="icon"><i class="fas fa-history"></i></div>
            <h3>Booking History</h3>
            <p>Track all your previous cab bookings.</p>
            <a href="ConfirmedBookings.jsp" class="btn btn-secondary">View Bookings</a>
        </div>
        
        <!-- View Replies -->
        <div class="dashboard-card">
            <div class="icon"><i class="fas fa-comment-dots"></i></div>
            <h3>View Replies</h3>
            <p>Check replies to your customer inquiries.</p>
            <a href="viewReplies.jsp" class="btn btn-info">View Replies</a>
        </div>

    </div>
</div>
<%@ include file="footer.jsp" %>
</body>
</html>
