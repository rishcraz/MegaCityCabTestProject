<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ page import="java.util.List"%>
<%@ page import="java.time.format.DateTimeFormatter"%>
<%@ page import="com.megacitycab.model.customer.Booking"%>
<%@ page import="com.megacitycab.dao.customer.BookingDAO"%>
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
    <title>Your Bookings</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/all_css/customer/View.css">
</head>
<body>

<%@ include file="header.jsp" %>

<!-- Main Content Wrapper to Push Footer Down -->
<div class="main-content">

    <div class="container mt-5">
        <h2 class="mb-4 text-center">My Bookings</h2>

        <%
            BookingDAO bookingDAO = new BookingDAO();
            List<Booking> bookings = bookingDAO.getAllBookings();
            DateTimeFormatter displayFormat = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
        %>

        <div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 g-4">
            <% for (Booking booking : bookings) { %>
            <div class="col mb-4">
                <div class="booking-card p-4 shadow-sm rounded bg-light">
                    <h5 class="booking-title mb-3">Order No: <%= booking.getOrderNumber() %></h5>
                    <p><strong>Customer Name:</strong> <%= booking.getCustomerName() %></p>
                    <p><strong>Telephone:</strong> <%= booking.getTelephone() %></p>

                    
                    <p>
                        <button class="btn btn-primary btn-sm" data-bs-toggle="modal" data-bs-target="#locationModal<%= booking.getOrderNumber() %>">
                            Pickup Location
                        </button>
                    </p>

                   
                    <p>
                        <button class="btn btn-primary btn-sm" data-bs-toggle="modal" data-bs-target="#destinationModal<%= booking.getOrderNumber() %>">
                            Destination
                        </button>
                    </p>

                    <p><strong>Date/Time:</strong> <%= booking.getPickupDateTime().format(displayFormat) %></p>
                    <p><strong>Car Type:</strong> <%= booking.getCarType() %></p>

                    <p><strong>Status:</strong>
                        <% if ("Cancelled by Manager".equalsIgnoreCase(booking.getStatus())) { %>
                            <span class="badge bg-danger">Cancelled by Manager</span>
                        <% } else { %>
                            <span class="badge <%= "Confirmed".equals(booking.getStatus()) ? "bg-success" : "bg-warning" %>">
                                <%= booking.getStatus() %>
                            </span>
                        <% } %>
                    </p>
                    <p><strong>Distance:</strong> <%= booking.getDistance() %>KM</p>

                   
                    <div class="d-flex gap-2">
                        <% if ("Pending".equals(booking.getStatus())) { %>
                            <a href="EditBooking.jsp?orderNumber=<%= booking.getOrderNumber() %>" class="btn btn-warning btn-sm">Edit</a>
                            <a href="CancelBookingServlet?orderNumber=<%= booking.getOrderNumber() %>"
                               class="btn btn-danger btn-sm"
                               onclick="return confirm('Are you sure you want to cancel this booking?');">
                                Cancel
                            </a>
                        <% } else { %>
                            <span class="text-muted">No Actions</span>
                        <% } %>
                    </div>
                </div>
            </div>

            
            <div class="modal fade" id="locationModal<%= booking.getOrderNumber() %>" tabindex="-1" aria-labelledby="locationLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="locationLabel">Pickup Location</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <%= booking.getPickupLocation() %>
                        </div>
                    </div>
                </div>
            </div>

       
            <div class="modal fade" id="destinationModal<%= booking.getOrderNumber() %>" tabindex="-1" aria-labelledby="destinationLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="destinationLabel">Destination</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <%= booking.getDestination() %>
                        </div>
                    </div>
                </div>
            </div>
            <% } %>
        </div>

    </div>
</div>

<%@ include file="footer.jsp" %>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
