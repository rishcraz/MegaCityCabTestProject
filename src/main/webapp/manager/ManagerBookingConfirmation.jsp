<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ page import="java.util.List"%>
<%@ page import="com.megacitycab.model.customer.Booking"%>
<%@ page import="com.megacitycab.dao.customer.BookingDAO"%>
<%@ page import="javax.servlet.http.HttpSession" %>

<%
    HttpSession sessionObj = request.getSession(false); // Don't create a new session if none exists
    String managerId = (sessionObj != null) ? (String) sessionObj.getAttribute("managerId") : null;

    if (managerId == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp"); // Redirect to login if not logged in
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Confirm Bookings - Manager Dashboard</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/all_css/manager/Checkbooking.css">
</head>
<body>

<%@ include file="header.jsp" %>

<div class="main-content">
    <div class="container mt-5">
        <h2 class="text-center mb-4 text-white">Confirm Bookings</h2>

        <div class="booking-list">
            <%
                BookingDAO bookingDAO = new BookingDAO();
                List<Booking> pendingBookings = bookingDAO.getPendingBookings();
                for (Booking booking : pendingBookings) {
            %>
            <div class="booking-item">
                <div class="booking-details">
                    <div class="data-row">
                        <span class="data-title">Order No:</span> <span class="data-value"><%= booking.getOrderNumber() %></span>
                    </div>
                    <div class="data-row">
                        <span class="data-title">Customer Name:</span> <span class="data-value"><%= booking.getCustomerName() %></span>
                    </div>
                    <div class="data-row">
                        <span class="data-title">Telephone:</span> <span class="data-value"><%= booking.getTelephone() %></span>
                    </div>
                    <div class="data-row">
                        <span class="data-title">Pickup Location:</span> <span class="data-value"><%= booking.getPickupLocation() %></span>
                    </div>
                    <div class="data-row">
                        <span class="data-title">Destination:</span> <span class="data-value"><%= booking.getDestination() %></span>
                    </div>
                    <div class="data-row">
                        <span class="data-title">Date/Time:</span> <span class="data-value"><%= booking.getPickupDateTime() %></span>
                    </div>
                    <div class="data-row">
                        <span class="data-title">Car Type:</span> <span class="data-value"><%= booking.getCarType() %></span>
                    </div>
                    <div class="data-row">
                        <span class="data-title">Status:</span> <span class="data-value status"><%= booking.getStatus() %></span>
                    </div>
                    <div class="data-row">
                        <span class="data-title">Distance:</span> <span class="data-value"><%= booking.getDistance() %> KM</span>
                    </div>
                </div>
                <div class="booking-actions">
                    <form action="<%=request.getContextPath()%>/manager/ConfirmBookingServlet" method="POST">
                        <input type="hidden" name="orderNumber" value="<%= booking.getOrderNumber() %>">
                        <button type="submit" class="btn btn-success action-btn">Confirm</button>
                    </form>
                    <form action="<%=request.getContextPath()%>/manager/RejectBookingServlet" method="POST">
                        <input type="hidden" name="orderNumber" value="<%= booking.getOrderNumber() %>">
                        <button type="submit" class="btn btn-danger action-btn"
                                onclick="return confirm('Are you sure you want to reject this booking?');">
                            Reject
                        </button>
                    </form>
                </div>
            </div>
            <% 
                }
            %>
        </div>
    </div>
</div>

<%@ include file="footer.jsp" %>

</body>
</html>
