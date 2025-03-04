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
</head>
<body>

<%@ include file="header.jsp" %>

<div class="container mt-5">
    <h2 class="text-center mb-4">Driver Responses</h2>

    <%
        if (driverResponses.isEmpty()) {
    %>
        <p class="text-center text-danger">No responses yet.</p>
    <%
        } else {
    %>
        <table class="table table-striped table-bordered">
    <thead class="table-dark">
        <tr>
            <th>Order Number</th>
            <th>Driver ID</th>
            <th>Driver Name</th>
            <th>Response</th>
            <th>Payment Method</th>
        </tr>
    </thead>
    <tbody>
        <%
            for (Booking booking : driverResponses) {
        %>
            <tr>
                <td><%= booking.getOrderNumber() %></td>
                <td><%= booking.getDriverId() %></td>
                <td><%= booking.getDriverName() %></td>
                <td><%= booking.getDriverResponse() != null ? booking.getDriverResponse() : "Pending" %></td>
                <td>
                    <%
                        if ("Completed".equals(booking.getDriverResponse())) {
                            if ("Cash".equals(booking.getPaymentMethod())) {
                                out.print("Cashed Out");
                            } else if ("Card".equals(booking.getPaymentMethod())) {
                                out.print("Online Pay");
                            } else {
                                out.print("Payment Not Recorded");
                            }
                        } else {
                            out.print("-");
                        }
                    %>
                </td>
            </tr>
        <%
            }
        %>
    </tbody>
</table>

    <%
        }
    %>
</div>

<div class="container mt-5">
    <h2 class="text-center mb-4">Driver Availability Status</h2>

    <%
        if (driverAvailability.isEmpty()) {
    %>
        <p class="text-center text-warning">No drivers available.</p>
    <%
        } else {
    %>
        <table class="table table-striped table-bordered">
            <thead class="table-primary">
                <tr>
                    <th>Employee ID</th>
                    <th>Driver Name</th>
                    <th>Email</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody>
                <%
                    for (Booking booking : driverAvailability) {
                %>
                    <tr>
                        <td><%= booking.getDriverId() %></td>
                        <td><%= booking.getDriverName() %></td>
                        <td><%= booking.getDriverEmail() %></td>
                        <td><%= booking.getDriverStatus() != null ? booking.getDriverStatus() : "N/A" %></td>
                    </tr>
                <%
                    }
                %>
            </tbody>
        </table>
    <%
        }
    %>
</div>
<%@ include file="footer.jsp" %>
</body>
</html>
