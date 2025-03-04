<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ page import="dao.customer.BillingDAO, dao.admin.FareRateDAO, dao.customer.BookingDAO, model.admin.FareRate, model.customer.Billing, model.customer.Booking, java.util.List" %>
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
    <title>Generate Bill - Manager</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/all_css/manager/generateBill.css">
</head>
<body>

<%@ include file="header.jsp" %>

<div class="main-content">
    <div class="container">
        <h2 class="text-center">Generate Customer Bill</h2>

        <!-- Search Form -->
        <form method="get" action="generateBill.jsp" class="search-form">
            <div class="mb-3">
                <label for="orderNumber" class="form-label">Enter Order Number:</label>
                <input type="text" class="form-control" name="orderNumber" required>
            </div>
            <button type="submit" class="btn btn-primary">Search Booking</button>
        </form>

        <%
            String orderNumber = request.getParameter("orderNumber");
            Booking booking = null;

            if (orderNumber != null && !orderNumber.isEmpty()) {
                BookingDAO bookingDAO = new BookingDAO();
                booking = bookingDAO.getBookingByOrderNumber(orderNumber);

                if (booking != null) {
        %>

        <!-- Booking Details -->
        <div class="booking-details mt-4">
            <h4>Booking Details</h4>
            <table class="table table-striped table-bordered">
                <tr><th>Order Number</th><td><%= booking.getOrderNumber() %></td></tr>
                <tr><th>Customer Name</th><td><%= booking.getCustomerName() %></td></tr>
                <tr><th>Pickup Location</th><td><%= booking.getPickupLocation() %></td></tr>
                <tr><th>Destination</th><td><%= booking.getDestination() %></td></tr>
                <tr><th>Distance</th><td><%= booking.getDistance() %> km</td></tr>
                <tr><th>Date/Time</th><td><%= booking.getPickupDateTime() %></td></tr>
                <tr><th>Car Type</th><td><%= booking.getCarType() %></td></tr>
            </table>

            <!-- Generate Bill Form -->
            <form method="post" action="GenerateBillServlet" class="generate-bill-form">
                <input type="hidden" name="orderNumber" value="<%= booking.getOrderNumber() %>">

                <div class="mb-3">
                    <label for="fareId" class="form-label">Select Fare ID:</label>
                    <select class="form-control" name="fareId" required>
                        <%
                            FareRateDAO fareRateDAO = new FareRateDAO();
                            List<FareRate> fareRates = fareRateDAO.getAllFareRates();
                            for (FareRate fare : fareRates) {
                        %>
                        <option value="<%= fare.getId() %>">
                            <%= fare.getCarType() %> - Base: $<%= fare.getBaseFare() %>, Per Km: $<%= fare.getPerKmRate() %>
                        </option>
                        <% } %>
                    </select>
                </div>

                <button type="submit" class="btn btn-success">Generate Bill</button>
            </form>
        </div>

        <% 
                } else { 
        %>
            <p class="text-danger text-center">No booking found for Order Number: <%= orderNumber %></p>
        <%
                }
            }
        %>
    </div>
</div>

<%@ include file="footer.jsp" %>

</body>
</html>
