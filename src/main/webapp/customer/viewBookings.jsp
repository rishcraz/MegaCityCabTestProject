<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="java.time.format.DateTimeFormatter"%>
<%@ page import="model.customer.Booking"%>
<%@ page import="dao.customer.BookingDAO"%>
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
        <h2 class="mb-4 text-center">Your Bookings</h2>

        <%
            BookingDAO bookingDAO = new BookingDAO();
            List<Booking> bookings = bookingDAO.getAllBookings();
            DateTimeFormatter displayFormat = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
        %>

        <div class="table-responsive">
            <table class="table table-hover align-middle">
                <thead class="table-dark text-center">
                    <tr>
                        <th>Order No</th>
                        <th>Customer Name</th>
                        <th>Telephone</th>
                        <th>Pickup Location</th>
                        <th>Destination</th>
                        <th>Date/Time</th>
                        <th>Car Type</th>
                        <th>Status</th>
                        <th>Distance (KM)</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (Booking booking : bookings) { %>
                    <tr>
                        <td><%=booking.getOrderNumber()%></td>
                        <td><%=booking.getCustomerName()%></td>
                        <td><%=booking.getTelephone()%></td>
                        <td>
                            <button class="btn btn-info btn-sm" data-bs-toggle="modal" data-bs-target="#locationModal<%=booking.getOrderNumber()%>">
                                See More
                            </button>
                        </td>
                        <td>
                            <button class="btn btn-info btn-sm" data-bs-toggle="modal" data-bs-target="#destinationModal<%=booking.getOrderNumber()%>">
                                See More
                            </button>
                        </td>
                        <td><%=booking.getPickupDateTime().format(displayFormat)%></td>
                        <td><%=booking.getCarType()%></td>
                        <td>
                            <% if ("Cancelled by Manager".equalsIgnoreCase(booking.getStatus())) { %>
                                <span class="badge bg-danger">Cancelled by Manager</span>
                            <% } else { %>
                                <span class="badge <%= "Confirmed".equals(booking.getStatus()) ? "bg-success" : "bg-warning" %>">
                                    <%=booking.getStatus()%>
                                </span>
                            <% } %>
                        </td>
                        <td><%=booking.getDistance()%>KM</td>
                        <td>
                            <% if ("Pending".equals(booking.getStatus())) { %>
                                <div class="d-flex gap-2 justify-content-center">
                                    <a href="EditBooking.jsp?orderNumber=<%=booking.getOrderNumber()%>" class="btn btn-warning btn-sm">Edit</a>
                                    <a href="CancelBookingServlet?orderNumber=<%=booking.getOrderNumber()%>"
                                       class="btn btn-danger btn-sm"
                                       onclick="return confirm('Are you sure you want to cancel this booking?');">
                                        Cancel
                                    </a>
                                </div>
                            <% } else { %>
                                <span class="text-muted">No Actions</span>
                            <% } %>
                        </td>
                    </tr>

                    <!-- Pickup Location Modal -->
                    <div class="modal fade" id="locationModal<%=booking.getOrderNumber()%>" tabindex="-1" aria-labelledby="locationLabel" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="locationLabel">Pickup Location</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body">
                                    <%=booking.getPickupLocation()%>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Destination Modal -->
                    <div class="modal fade" id="destinationModal<%=booking.getOrderNumber()%>" tabindex="-1" aria-labelledby="destinationLabel" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="destinationLabel">Destination</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body">
                                    <%=booking.getDestination()%>
                                </div>
                            </div>
                        </div>
                    </div>
                    <% } %>
                </tbody>
            </table>
        </div>

        <div class="text-center mt-4">
            <a href="CustomerDashboard.jsp" class="btn btn-secondary">Back to Dashboard</a>
        </div>
    </div>
</div>

<%@ include file="footer.jsp" %>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
