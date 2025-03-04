<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.customer.Booking" %>
<%@ page import="dao.customer.BookingDAO" %>
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
    <h2>Confirmed & Cancelled Bookings</h2>
    <table border="1" cellpadding="10" cellspacing="0">
        <tr>
            <th>Order Number</th>
            <th>Customer Name</th>
            <th>Pickup Location</th>
            <th>Destination</th>
            <th>Date/Time</th>
             <th>Distance (KM)</th>
            <th>Car Type</th>
            <th>Status</th>
        </tr>
        <%
            DateTimeFormatter displayFormat = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
            BookingDAO bookingDAO = new BookingDAO();
            List<Booking> confirmedBookings = bookingDAO.getConfirmedBookings();
            for (Booking booking : confirmedBookings) {
        %>
        <tr>
            <td><%= booking.getOrderNumber() %></td>
            <td><%= booking.getCustomerName() %></td>
            <td><%= booking.getPickupLocation() %></td>
            <td><%= booking.getDestination() %></td>
              <td><%=booking.getPickupDateTime().format(displayFormat)%></td>
            <td><%=booking.getDistance()%>KM</td>
            <td><%= booking.getCarType() %></td>
            <td>
                <% if (booking.getStatus().contains("Cancelled")) { %>
                    <span style='color:red; font-weight: bold;'><%= booking.getStatus() %></span>
                <% } else { %>
                    <span style='color:green; font-weight: bold;'><%= booking.getStatus() %></span>
                <% } %>
            </td>
        </tr>
        <% } %>
    </table>
     <%@ include file="footer.jsp" %>
</body>
</html>
