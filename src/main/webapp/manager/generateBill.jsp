<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.megacitycab.dao.customer.BillingDAO,com.megacitycab.dao.admin.FareRateDAO, com.megacitycab.dao.customer.BookingDAO,com.megacitycab.model.admin.FareRate,com.megacitycab.model.customer.Billing,com.megacitycab.model.customer.Booking, java.util.List" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="java.time.LocalDateTime, java.time.format.DateTimeFormatter" %>

<%
    HttpSession sessionObj = request.getSession(false);
    String managerId = (sessionObj != null) ? (String) sessionObj.getAttribute("managerId") : null;

    if (managerId == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Generate Bill - Manager</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/all_css/manager/Bill.css">
</head>
<body style="background: #121212; color: #f5f5f5;">

<%@ include file="header.jsp" %>

<div class="main-content">
    <div class="container">
        <h2 class="text-center text-warning mb-4">Generate bill for the Bookings</h2>

        <!-- Search Section -->
        <div class="card shadow-lg" style="background: #1f1f1f; color: #e0e0e0;">
            <div class="card-body">
                <h5 class="card-title text-info">Search by Order Number</h5>
                <form method="get" action="generateBill.jsp">
                    <div class="mb-3">
                        <label for="orderNumber" class="form-label">Enter Order Number:</label>
                        <input type="text" class="form-control bg-dark text-light" name="orderNumber" required>
                    </div>
                    <button type="submit" class="btn btn-outline-info w-100">Search Booking</button>
                </form>
            </div>
        </div>

        <%
            String orderNumber = request.getParameter("orderNumber");
            Booking booking = null;

            if (orderNumber != null && !orderNumber.isEmpty()) {
                BookingDAO bookingDAO = new BookingDAO();
                booking = bookingDAO.getBookingByOrderNumber(orderNumber);

                if (booking != null) {
                    LocalDateTime pickupDateTime = booking.getPickupDateTime();
                    String formattedDateTime = pickupDateTime.format(DateTimeFormatter.ofPattern("dd MMM yyyy, hh:mm a"));
        %>

        <!-- Booking Details in Card Layout -->
        <div class="card shadow-lg mt-4" style="background: #1f1f1f; color: #e0e0e0;">
            <div class="card-body">
                <h5 class="card-title text-info">Booking Details</h5>
                <div class="row">
                    <div class="col-md-6">
                        <p><strong>Order Number:</strong> <span class="text-warning"><%= booking.getOrderNumber() %></span></p>
                        <p><strong>Customer Name:</strong> <%= booking.getCustomerName() %></p>
                        <p><strong>Pickup Location:</strong> <%= booking.getPickupLocation() %></p>
                    </div>
                    <div class="col-md-6">
                        <p><strong>Destination:</strong> <%= booking.getDestination() %></p>
                        <p><strong>Distance:</strong> <%= booking.getDistance() %> km</p>
                        <p><strong>Date/Time:</strong> <%= formattedDateTime %></p>
                    </div>
                </div>

                <!-- Generate Bill Button -->
                <button class="btn btn-outline-success w-100 mt-3" data-bs-toggle="modal" data-bs-target="#generateBillModal">
                    Generate Bill
                </button>
            </div>
        </div>

        <!-- Modal for Bill Generation -->
        <div class="modal fade" id="generateBillModal" tabindex="-1" aria-labelledby="generateBillModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content" style="background: #222; color: #e0e0e0;">
                    <div class="modal-header border-bottom">
                        <h5 class="modal-title text-warning" id="generateBillModalLabel">Generate Bill</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form method="post" action="GenerateBillServlet">
                            <input type="hidden" name="orderNumber" value="<%= booking.getOrderNumber() %>">
                            <div class="mb-3">
                                <label for="fareId" class="form-label">Select Fare ID:</label>
                                <select class="form-control bg-dark text-light" name="fareId" required>
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
                            <button type="submit" class="btn btn-outline-success w-100">Confirm and Generate Bill</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <% 
                } else { 
        %>
            <p class="text-danger text-center mt-4">No booking found for Order Number: <%= orderNumber %></p>
        <%
                }
            }
        %>
    </div>
</div>

<%@ include file="footer.jsp" %>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
