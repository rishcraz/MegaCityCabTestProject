<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="com.megacitycab.dao.customer.BookingDAO" %>
<%@ page import="com.megacitycab.model.customer.Booking" %>
<%@ page import="java.util.List" %>

<%
    // Get driverId from session
    String driverId = (String) session.getAttribute("driverId");

    // Redirect to login if session not set
    if (driverId == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    // Fetch assigned bookings for the driver
    BookingDAO bookingDAO = new BookingDAO();
    List<Booking> assignedBookings = bookingDAO.getBookingsByDriverId(driverId);

    // Get status update message from URL parameter
    String statusUpdated = request.getParameter("statusUpdated");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Assigned Bookings</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/all_css/driver/View.css">

    <!-- JavaScript to handle button visibility and modal functionality -->
    <script type="text/javascript">
        function handleAcceptClick(orderNumber) {
            // Hide 'Decline' button
            document.getElementById('decline-btn-' + orderNumber).style.display = 'none';
            // Show 'Complete' button
            document.getElementById('complete-btn-' + orderNumber).style.display = 'inline-block';
            // Optionally, disable the Accept button after it's clicked
            document.getElementById('accept-btn-' + orderNumber).disabled = true;
        }

        function handleDeclineClick(orderNumber) {
            // Hide 'Accept' button permanently when 'Decline' is clicked
            document.getElementById('accept-btn-' + orderNumber).style.display = 'none';
            // Optionally, disable the Decline button after it's clicked
            document.getElementById('decline-btn-' + orderNumber).disabled = true;
        }

        function handleCompleteClick(orderNumber) {
            // Hide 'Accept' and 'Decline' buttons when the ride is completed
            document.getElementById('accept-btn-' + orderNumber).style.display = 'none';
            document.getElementById('decline-btn-' + orderNumber).style.display = 'none';
            
            // Show payment buttons when ride is completed
            document.getElementById('payment-method-' + orderNumber).style.display = 'block';

            // Disable the 'Ride Completed' button
            document.getElementById('complete-btn-' + orderNumber).disabled = true;
        }


        function showLocationAndDestination(orderNumber) {
            // Trigger modal to show the location and destination using Bootstrap's modal API
            var myModal = new bootstrap.Modal(document.getElementById('locationDestinationModal-' + orderNumber));
            myModal.show();
        }
    </script>
</head>
<body>

<%@ include file="header.jsp" %>

<div class="container mt-5">
    <h2 class="text-center mb-4">My Assigned Bookings</h2>

    <!-- Status Update Messages -->
    <% if ("true".equals(statusUpdated)) { %>
        <div class="alert alert-success text-center">Availability status updated successfully!</div>
    <% } else if ("false".equals(statusUpdated)) { %>
        <div class="alert alert-danger text-center">Failed to update availability status. Please try again.</div>
    <% } %>

    <!-- Display assigned bookings -->
    <%
        if (assignedBookings.isEmpty()) {
    %>
        <p class="text-center text-danger">No bookings assigned yet.</p>
    <%
        } else {
    %>
        <div class="row">
            <%
                for (Booking booking : assignedBookings) {
            %>
            <div class="col-md-6 mb-4">
                <div class="booking-card">
                    <div class="card-body">
                        <h5 class="card-title">Order #: <%= booking.getOrderNumber() %></h5>
                        <p><strong>Customer:</strong> <%= booking.getCustomerName() %></p>
                        <p><strong>Pickup Time:</strong> <%= booking.getPickupDateTime() != null ? booking.getPickupDateTime() : "N/A" %></p>

                        <!-- Click Here to Show Location and Destination in Modal -->
                        <button type="button" class="btn btn-info btn-sm" onclick="showLocationAndDestination('<%= booking.getOrderNumber() %>')">Click Here</button>

                        <form method="post" action="<%= request.getContextPath() %>/DriverResponseServlet">
                            <input type="hidden" name="orderNumber" value="<%= booking.getOrderNumber() %>">
                            <input type="hidden" name="driverId" value="<%= driverId %>">
                            <!-- Accept Button -->
                            <button type="submit" name="action" value="accept" id="accept-btn-<%= booking.getOrderNumber() %>" class="btn btn-success btn-sm" onclick="handleAcceptClick('<%= booking.getOrderNumber() %>')">Accept</button>
                            <!-- Decline Button -->
                            <button type="submit" name="action" value="decline" id="decline-btn-<%= booking.getOrderNumber() %>" class="btn btn-danger btn-sm" onclick="handleDeclineClick('<%= booking.getOrderNumber() %>')">Decline</button>
                            <!-- Complete Button (Initially Hidden) -->
                            <button type="submit" name="action" value="completed" id="complete-btn-<%= booking.getOrderNumber() %>" class="btn btn-warning btn-sm" style="display:none;" onclick="handleCompleteClick('<%= booking.getOrderNumber() %>')">Ride Completed</button>
                        </form>

                        <!-- Payment Method Buttons (Initially Hidden) -->
                        <div id="payment-method-<%= booking.getOrderNumber() %>" class="payment-method" style="display:none;">
                            <form method="post" action="<%= request.getContextPath() %>/PaymentServlet">
                                <input type="hidden" name="orderNumber" value="<%= booking.getOrderNumber() %>">
                                <input type="hidden" name="driverId" value="<%= driverId %>">
                                <button type="submit" name="paymentMethod" value="Cash" class="btn btn-outline-success btn-sm">Cash</button>
                                <button type="submit" name="paymentMethod" value="Card" class="btn btn-outline-primary btn-sm">Card</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Modal for Location and Destination -->
            <div class="modal fade" id="locationDestinationModal-<%= booking.getOrderNumber() %>" tabindex="-1" aria-labelledby="locationDestinationModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="locationDestinationModalLabel">Booking Details</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <p><strong>Pickup Location:</strong> <%= booking.getPickupLocation() %></p>
                            <p><strong>Destination:</strong> <%= booking.getDestination() %></p>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
            </div>
            <%
                }
            %>
        </div>
    <% } %>
</div>

<!-- Update Availability Status Form -->
<div class="container mt-5">
    <h3 class="text-center mb-4">Update Status</h3>
    <form method="post" action="<%= request.getContextPath() %>/UpdateDriverStatusServlet">
        <input type="hidden" name="driverId" value="<%= driverId %>">
        <div class="mb-3">
            <label for="status" class="form-label">Select Availability Status:</label>
            <select class="form-select" name="status" id="status" required>
                <option value="Available">Available</option>
                <option value="On a Ride">On a Ride</option>
                <option value="Off Duty">Off Duty</option>
            </select>
        </div>
        <button type="submit" class="btn btn-primary w-100">Update Status</button>
    </form>
</div>

<%@ include file="footer.jsp" %>

<!-- Bootstrap JS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>

</body>
</html>
