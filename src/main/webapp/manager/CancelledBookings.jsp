<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.megacitycab.model.customer.Booking" %>
<%@ page import="com.megacitycab.dao.customer.BookingDAO" %>
<%@ page import="javax.servlet.http.HttpSession" %>

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
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cancelled Bookings</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/all_css/manager/Booking.css">
</head>
<body class="dark-theme">

<%@ include file="header.jsp" %>

<main class="main-content">
    <div class="container">
        <h2 class="text-center mb-4 text-danger">Cancelled Bookings</h2>

        <div class="row g-4">
            <%
                BookingDAO bookingDAO = new BookingDAO();
                List<Booking> cancelledBookings = bookingDAO.getCancelledBookings();

                if (cancelledBookings.isEmpty()) {
            %>
            <div class="col-12 text-center text-danger">
                <p>No cancelled bookings found.</p>
            </div>
            <%
                } else {
                    for (Booking booking : cancelledBookings) {
            %>
            <div class="col-md-6 col-lg-4">
                <div class="card booking-card">
                    <div class="card-body">
                        <h5 class="card-title"><%= booking.getCustomerName() %></h5>
                        <p><strong>Order Number:</strong> <%= booking.getOrderNumber() %></p>
                        <p><strong>Date/Time:</strong> <%= booking.getPickupDateTime() %></p>
                        <p><strong>Car Type:</strong> <%= booking.getCarType() %></p>
                        <p><strong>Status:</strong> <span class="text-danger fw-bold"><%= booking.getStatus() %></span></p>

                        <!-- Button to trigger modal -->
                        <button type="button" class="btn btn-info btn-sm" data-bs-toggle="modal" data-bs-target="#cancelledBookingModal<%= booking.getOrderNumber() %>">
                            View Locations
                        </button>
                    </div>
                </div>
            </div>

            <!-- Modal for showing locations -->
            <div class="modal fade" id="cancelledBookingModal<%= booking.getOrderNumber() %>" tabindex="-1" aria-labelledby="cancelledBookingModalLabel<%= booking.getOrderNumber() %>" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content dark-modal">
                        <div class="modal-header">
                            <h5 class="modal-title" id="cancelledBookingModalLabel<%= booking.getOrderNumber() %>">Booking Locations</h5>
                            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <p><strong>Pickup Location:</strong> <%= booking.getPickupLocation() %></p>
                            <p><strong>Destination:</strong> <%= booking.getDestination() %></p>
                            <p><strong>Distance:</strong> <%= booking.getDistance() %> KM</p>
                        </div>
                    </div>
                </div>
            </div>
            <%
                    }
                }
            %>
        </div>
    </div>
</main>

<%@ include file="footer.jsp" %>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
