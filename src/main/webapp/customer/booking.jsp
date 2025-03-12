<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    HttpSession userSession = request.getSession(false);
    String userId = (userSession != null) ? (String) userSession.getAttribute("userId") : null;

    if (userId == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp"); // Redirect to login if not logged in
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book a Cab | MegaCityCab</title>
    <link rel="stylesheet" href="https://unpkg.com/leaflet/dist/leaflet.css" />
    <link rel="stylesheet" href="<%= request.getContextPath() %>/all_css/customer/booking.css">
    <script src="https://unpkg.com/leaflet/dist/leaflet.js"></script>
    <script defer src="<%= request.getContextPath() %>/Javascript/maps.js"></script>
</head>
<body>

    <!-- Header Section -->
    <div class="header-container">
        <%@ include file="header.jsp" %>
    </div>

    <!-- Booking Section -->
    <section class="booking-section">
        <h2 class="title">Book Your Taxi</h2>
        <form action="<%= request.getContextPath() %>/customer/BookingServlet" method="POST" class="booking-form">
            <!-- Hidden Order Number -->
            <input type="hidden" name="orderNumber" value="<%= System.currentTimeMillis() %>">

            <div class="form-group">
                <label for="customerName">Customer Name:</label>
                <input type="text" name="customerName" id="customerName" required>
            </div>

            <div class="form-group">
                <label for="address">Address:</label>
                <input type="text" name="address" id="address" required>
            </div>

            <div class="form-group">
                <label for="telephone">Contact Number:</label>
                <input type="tel" name="telephone" id="telephone" pattern="[0-9]{10}" required>
            </div>

            <div class="form-group">
                <label for="pickupLocation">Pickup Location (Click on Map):</label>
                <input type="text" id="pickupLocation" name="pickupLocation" readonly required>
            </div>

            <div class="form-group">
                <label for="destination">Destination (Click on Map):</label>
                <input type="text" id="destination" name="destination" readonly required>
            </div>

            <div id="map" class="map-container"></div> <!-- Map Container -->

            <div class="form-group">
                <label for="distance">Distance (km):</label>
                <input type="text" id="distance" name="distance" readonly>
            </div>

            <div class="form-group">
                <label for="pickupDate">Date/Time:</label>
                <input type="datetime-local" name="pickupDate" id="pickupDate" required>
            </div>

            <div class="form-group">
                <label for="carType">Car Type:</label>
                <select name="carType" id="carType" required>
                    <option value="Hatchback">Hatchback</option>
                    <option value="Luxury">Luxury</option>
                    <option value="SUV">SUV</option>
                </select>
            </div>

            <button type="submit" class="submit-btn">Book Now</button>
        </form>
    </section>

    <!-- Footer Section -->
    <div class="footer-container">
        <%@ include file="footer.jsp" %>
    </div>

</body>
</html>
