<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.customer.Booking" %>
<%@ page import="dao.customer.BookingDAO" %>
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
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cancelled Bookings</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/all_css/manager/cancelled.css">
</head>
<body>

<%@ include file="header.jsp" %>

<main class="main-content">
    <div class="container mt-5">
        <h2 class="text-center mb-4">Confrimed Bookings</h2>

        <div class="table-responsive">
            <table class="table table-bordered table-striped table-hover text-center">
                <thead class="table-dark">
                    <tr>
                        <th>Order Number</th>
                        <th>Customer Name</th>
                        <th>Pickup Location</th>
                        <th>Destination</th>
                        <th>Distance (km)</th>
                        <th>Date/Time</th>
                        <th>Car Type</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                <%
                    BookingDAO bookingDAO = new BookingDAO();
                    List<Booking> bookings = bookingDAO.getConfirmedBookings();

                    if (bookings.isEmpty()) {
                %>
                <tr>
                    <td colspan="8" class="text-center text-danger">No confirmed bookings found.</td>
                </tr>
                <%
                    } else {
                        for (Booking booking : bookings) {
                            if (!booking.getStatus().contains("Cancelled")) {
                %>
                <tr>
                    <td><%= booking.getOrderNumber() %></td>
                    <td><%= booking.getCustomerName() %></td>
                    <td><%= booking.getPickupLocation() %></td>
                    <td><%= booking.getDestination() %></td>
                    <td><%= booking.getDistance() %> KM</td>
                    <td><%= booking.getPickupDateTime() %></td>
                    <td><%= booking.getCarType() %></td>
                    <td class="text-success fw-bold"><%= booking.getStatus() %></td>
                </tr>
                <%
                            }
                        }
                    }
                %>
            </tbody>
            </table>
        </div>
    </div>
</main>

<%@ include file="footer.jsp" %>

</body>
</html>
