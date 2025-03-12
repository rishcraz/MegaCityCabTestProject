<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="dao.admin.EmployeeDAO" %>
<%@ page import="dao.customer.BookingDAO" %>
<%@ page import="model.admin.Employee" %>
<%@ page import="model.customer.Booking" %>
<%@ include file="header.jsp" %>
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
    <title>Assign Driver to Booking</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/all_css/manager/Assign.css">
</head>
<body class="bg-dark text-white">

<div class="container my-5">
    <h2 class="text-center mb-4">Assign Driver to Booking</h2>

    <div class="form-group">
        <label for="driverId" class="form-label">Driver Employee ID</label>
        <input type="text" class="form-control" id="driverId" placeholder="e.g. EMP003">
    </div>

    <div class="form-group mt-4">
        <label for="orderNumber" class="form-label">Order Number</label>
        <input type="text" class="form-control" id="orderNumber" placeholder="e.g. 63D32A6C">
    </div>

    <button class="btn btn-primary mt-4" id="getDetailsBtn">Get Details</button>

    <div class="mt-5">
        <div id="driverDetails" class="details-box" style="display: none;">
            <h5>Driver Information</h5>
            <p><strong>Name:</strong> <span id="driverName"></span></p>
            <p><strong>Email:</strong> <span id="driverEmail"></span></p>
        </div>

        <div id="bookingDetails" class="details-box" style="display: none;">
            <h5>Booking Information</h5>
            <p><strong>Customer Name:</strong> <span id="customerName"></span></p>
            <p><strong>Customer Phone:</strong> <span id="telephone"></span></p>
            <p><strong>Pickup Location:</strong> <span id="pickupLocation"></span></p>
            <p><strong>Destination:</strong> <span id="destination"></span></p>
            <!-- Removed Pickup Date & Time -->
        </div>
    </div>

    <form action="<%= request.getContextPath() %>/manager/AssignDriverServlet" method="post">
        <input type="hidden" name="driverId" id="hiddenDriverId">
        <input type="hidden" name="orderNumber" id="hiddenOrderNumber">
        <button class="btn btn-success mt-4" id="assignBtn" type="submit" style="display: none;">Assign Driver</button>
    </form>
</div>

<%@ include file="footer.jsp" %>

<script>
    document.getElementById('getDetailsBtn').addEventListener('click', function () {
        const driverId = document.getElementById('driverId').value.trim();
        const orderNumber = document.getElementById('orderNumber').value.trim();

        if (!driverId || !orderNumber) {
            alert("Please enter both Driver Employee ID and Order Number.");
            return;
        }

        Promise.all([
            fetch('<%= request.getContextPath() %>/manager/FetchDriverServlet?driverId=' + driverId)
                .then(response => response.json()),

            fetch('<%= request.getContextPath() %>/manager/FetchBookingServlet?orderNumber=' + orderNumber)
                .then(response => response.json())
        ])
        .then(([driverData, bookingData]) => {
            let driverFound = false;
            let bookingFound = false;

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

            if (bookingData && bookingData.customerName) {
                document.getElementById('customerName').textContent = bookingData.customerName;
                document.getElementById('telephone').textContent = bookingData.telephone || 'N/A';
                document.getElementById('pickupLocation').textContent = bookingData.pickupLocation;
                document.getElementById('destination').textContent = bookingData.destination;
                // Removed Pickup Date & Time from here
                document.getElementById('bookingDetails').style.display = 'block';
                document.getElementById('hiddenOrderNumber').value = orderNumber;
                bookingFound = true;
            } else {
                document.getElementById('bookingDetails').style.display = 'none';
                alert("Booking not found!");
            }

            document.getElementById('assignBtn').style.display = (driverFound && bookingFound) ? 'block' : 'none';
        })
        .catch(error => {
            console.error('Error fetching data:', error);
            alert("Failed to fetch details. Please try again.");
        });
    });
</script>
</body>
</html>
