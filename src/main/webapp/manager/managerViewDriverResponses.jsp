<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="dao.customer.BookingDAO" %>
<%@ page import="model.customer.Booking" %>
<%@ page import="java.util.List" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<%
    HttpSession sessionObj = request.getSession(false); // Don't create a new session if none exists
    String managerId = (sessionObj != null) ? (String) sessionObj.getAttribute("managerId") : null;

    if (managerId == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp"); // Redirect to login if not logged in
        return;
    }
%>

<%
    BookingDAO bookingDAO = new BookingDAO();

    // Driver responses from assigned_drivers table
    List<Booking> driverResponses = bookingDAO.getAllDriverResponses();

    // Driver availability from employees table
    List<Booking> driverAvailability = bookingDAO.getAllDriversAvailability();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Driver Responses & Availability</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="<%= request.getContextPath() %>/all_css/manager/Response.css">
</head>
<body>

<%@ include file="header.jsp" %>

<div class="container mt-5">
    <h2 class="text-center mb-4">Driver Responses</h2>

    <div class="row">
        <% 
            if (driverResponses.isEmpty()) { 
        %>
            <p class="text-center text-danger">No responses yet.</p>
        <%
            } else {
                for (Booking booking : driverResponses) { 
        %>
        <div class="col-md-4">
            <div class="card mb-4" style="background-color: #333; color: #fff;">
                <div class="card-body">
                    <h5 class="card-title">Order Number: <%= booking.getOrderNumber() %></h5>
                    <p><strong>Driver:</strong> <%= booking.getDriverName() %> (ID: <%= booking.getDriverId() %>)</p>
                    <p><strong>Response:</strong> <%= booking.getDriverResponse() != null ? booking.getDriverResponse() : "Pending" %></p>
                    <p><strong>Payment Method:</strong> 
                        <%= booking.getDriverResponse() != null && "Accepted".equals(booking.getDriverResponse()) ?
                               ("Cash".equals(booking.getPaymentMethod()) ? "Cashed Out" : "Online Pay") :
                               "Not Available" %>
                    </p>
                </div>
            </div>
        </div>
        <% 
                } 
            } 
        %>
    </div>
</div>

<div class="container mt-5">
    <h2 class="text-center mb-4">Driver Availability Status</h2>

    <div class="row">
        <% 
            if (driverAvailability.isEmpty()) { 
        %>
            <p class="text-center text-warning">No drivers available.</p>
        <%
            } else {
                for (Booking booking : driverAvailability) { 
        %>
        <div class="col-md-4">
            <div class="card mb-4" style="background-color: #444; color: #fff;">
                <div class="card-body">
                    <h5 class="card-title"><%= booking.getDriverName() %> (ID: <%= booking.getDriverId() %>)</h5>
                    <p><strong>Email:</strong> <%= booking.getDriverEmail() %></p>
                    <p><strong>Status:</strong> <%= booking.getDriverStatus() != null ? booking.getDriverStatus() : "N/A" %></p>
                </div>
            </div>
        </div>
        <% 
                } 
            } 
        %>
    </div>
</div>

<%@ include file="footer.jsp" %>

</body>
</html>
