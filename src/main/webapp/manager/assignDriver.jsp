<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="dao.admin.EmployeeDAO" %>
<%@ page import="dao.customer.BookingDAO" %>
<%@ page import="model.admin.Employee" %>
<%@ page import="model.customer.Booking" %>
<%@ include file="header.jsp" %>
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
    <title>Assign Driver to Booking</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .container {
            max-width: 800px;
            margin: 50px auto;
            background: #f8f9fa;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        h2 { text-align: center; }
        .info-card {
            background: #ffffff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
            margin-bottom: 20px;
        }
        .info-card h5 {
            margin-bottom: 20px;
            font-weight: bold;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Assign Driver to Booking</h2>

    <!-- Input fields -->
    <div class="mb-4">
        <label for="driverId" class="form-label">Driver Employee ID</label>
        <input type="text" class="form-control" id="driverId" placeholder="e.g. EMP003" required>
    </div>
    <div class="mb-4">
        <label for="orderNumber" class="form-label">Order Number</label>
        <input type="text" class="form-control" id="orderNumber" placeholder="e.g. 63D32A6C" required>
    </div>

    <!-- Get Details Button -->
    <button type="button" class="btn btn-info w-100" onclick="getDetails()">Get Details</button>

    <!-- Driver Details Card -->
    <div class="info-card mt-4" id="driverDetails" style="display: none;">
        <h5>Driver Information</h5>
        <p><strong>Name:</strong> <span id="driverName"></span></p>
        <p><strong>Email:</strong> <span id="driverEmail"></span></p>
    </div>

    <!-- Booking Details Card -->
    <div class="info-card mt-4" id="bookingDetails" style="display: none;">
        <h5>Booking Information</h5>
        <p><strong>Customer Name:</strong> <span id="customerName"></span></p>
        <p><strong>Customer Address:</strong> <span id="address"></span></p>
        <p><strong>Customer Phone:</strong> <span id="telephone"></span></p>
        <p><strong>Pickup Location:</strong> <span id="pickupLocation"></span></p>
        <p><strong>Destination:</strong> <span id="destination"></span></p>
        <p><strong>Pickup Date & Time:</strong> <span id="pickupDatetime"></span></p>
    </div>

    <!-- Assign Driver Form -->
    <form action="<%= request.getContextPath() %>/manager/AssignDriverServlet" method="post">
        <input type="hidden" name="driverId" id="hiddenDriverId">
        <input type="hidden" name="orderNumber" id="hiddenOrderNumber">

        <button type="submit" class="btn btn-primary w-100 mt-4" id="assignBtn" style="display: none;">Assign Driver</button>
    </form>
</div>

<%@ include file="footer.jsp" %>

<script>
function getDetails() {
    const driverId = document.getElementById('driverId').value.trim();
    const orderNumber = document.getElementById('orderNumber').value.trim();

    console.log("Driver ID entered:", driverId);
    console.log("Order Number entered:", orderNumber);

    if (!driverId || !orderNumber) {
        alert("Please enter both Driver Employee ID and Order Number.");
        return;
    }

    // Fetch both driver and booking details at the same time
    Promise.all([
        fetch('<%= request.getContextPath() %>/manager/FetchDriverServlet?driverId=' + driverId)
            .then(response => response.json()),

        fetch('<%= request.getContextPath() %>/manager/FetchBookingServlet?orderNumber=' + orderNumber)
            .then(response => response.json())
    ])
    .then(([driverData, bookingData]) => {
        console.log("Driver API response:", driverData);
        console.log("Booking API response:", bookingData);

        let driverFound = false;
        let bookingFound = false;

        // Update driver details
        if (driverData && driverData.username) {
            document.getElementById('driverName').textContent = driverData.username;
            document.getElementById('driverEmail').textContent = driverData.email;
            document.getElementById('driverDetails').style.display = 'block';
            document.getElementById('hiddenDriverId').value = driverId;
            driverFound = true;
        } else {
            document.getElementById('driverDetails').style.display = 'none';
            alert("Driver not found!");
        }

        // Update booking details
        if (bookingData && bookingData.customerName) {
            document.getElementById('customerName').textContent = bookingData.customerName;
            document.getElementById('address').textContent = bookingData.address || 'N/A';
            document.getElementById('telephone').textContent = bookingData.telephone || 'N/A';
            document.getElementById('pickupLocation').textContent = bookingData.pickupLocation;
            document.getElementById('destination').textContent = bookingData.destination;
            document.getElementById('pickupDatetime').textContent = bookingData.pickupDatetime;
            document.getElementById('bookingDetails').style.display = 'block';
            document.getElementById('hiddenOrderNumber').value = orderNumber;
            bookingFound = true;
        } else {
            document.getElementById('bookingDetails').style.display = 'none';
            alert("Booking not found!");
        }

        // Show Assign Driver button only if both details are found
        document.getElementById('assignBtn').style.display = (driverFound && bookingFound) ? 'block' : 'none';
    })
    .catch(error => {
        console.error('Error fetching data:', error);
        alert("Failed to fetch details. Please try again.");
    });
}
</script>
</body>
</html>
