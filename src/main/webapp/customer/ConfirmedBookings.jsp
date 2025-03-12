<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ page import="java.util.List" %> 
<%@ page import="com.megacitycab.model.customer.Booking" %> 
<%@ page import="com.megacitycab.dao.customer.BookingDAO" %> 
<%@ page import="java.time.format.DateTimeFormatter" %> 
<%@ page import="java.time.LocalDateTime" %> 

<%
    HttpSession userSession = request.getSession(false);
    String userId = (userSession != null) ? (String) userSession.getAttribute("userId") : null;

    if (userId == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp"); // Redirect to login if not logged in
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Confirmed Bookings</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/all_css/customer/confrim.css">
</head>
<body>
<%@ include file="header.jsp" %>
    <div class="page-container">
        <h2>Confirmed & Cancelled Bookings</h2>
        <div class="booking-container">
            <%
                DateTimeFormatter displayFormat = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
                BookingDAO bookingDAO = new BookingDAO();
                List<Booking> confirmedBookings = bookingDAO.getConfirmedBookings();
                for (Booking booking : confirmedBookings) {
                    // Format pickupDateTime directly as it's a LocalDateTime
                    LocalDateTime pickupDateTime = booking.getPickupDateTime();
                    String formattedDateTime = (pickupDateTime != null) ? pickupDateTime.format(displayFormat) : "N/A";
            %>
            <div class="booking-card">
                <div class="card-header">
                    <h4>Order Number: <%= booking.getOrderNumber() %></h4>
                    <span class="status <%= booking.getStatus().contains("Cancelled") ? "cancelled" : "confirmed" %>">
                        <%= booking.getStatus() %>
                    </span>
                </div>
                <div class="card-body">
                    <p><strong>Customer Name:</strong> <%= booking.getCustomerName() %></p>
                    <p><strong>Pickup Location:</strong> <%= booking.getPickupLocation() %></p>
                    <p><strong>Destination:</strong> <%= booking.getDestination() %></p>
                    <p><strong>Date/Time:</strong> <%= formattedDateTime %></p>
                    <p><strong>Distance:</strong> <%= booking.getDistance() %> KM</p>
                    <p><strong>Car Type:</strong> <%= booking.getCarType() %></p>
                </div>
            </div>
            <% } %>
        </div>
    </div>
    <%@ include file="footer.jsp" %>
</body>
</html>
