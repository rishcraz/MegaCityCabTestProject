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
<html>
<head>
    <meta charset="UTF-8">
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

    <!-- Booking Form Section -->
    <div class="container">
        <h2>Book Your Cab</h2>
        <form action="<%= request.getContextPath() %>/customer/BookingServlet" method="POST">
            <!-- Hidden Order Number -->
            <input type="hidden" name="orderNumber" value="<%= System.currentTimeMillis() %>">

            <label>Customer Name:</label>
            <input type="text" name="customerName" required>

            <label>Address:</label>
            <input type="text" name="address" required>

            <label>Telephone Number:</label>
            <input type="tel" name="telephone" pattern="[0-9]{10}" required>

            <label>Pickup Location (Click on Map):</label>
            <input type="text" id="pickupLocation" name="pickupLocation" readonly required>

            <label>Destination (Click on Map):</label>
            <input type="text" id="destination" name="destination" readonly required>

            <div id="map"></div> <!-- Map Container -->

            <label>Distance (km):</label>
            <input type="text" id="distance" name="distance" readonly>

            <label>Date/Time:</label>
            <input type="datetime-local" name="pickupDate" required>

            <label>Car Type:</label>
            <select name="carType" required>
                <option value="Standard">Standard</option>
                <option value="Luxury">Luxury</option>
                <option value="SUV">SUV</option>
            </select>

            <button type="submit">Confirm Booking</button>
        </form>
    </div>

    <!-- Footer Section -->
    <div class="footer-container">
        <%@ include file="footer.jsp" %>
    </div>
</body>
</html>
