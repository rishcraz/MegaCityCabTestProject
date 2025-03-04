<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="dao.admin.CarDAO" %>
<%@ page import="model.admin.Car" %>

<%
    // Get driverId from session
    String driverId = (String) session.getAttribute("driverId");

    if (driverId == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    // Fetch assigned car details
    CarDAO carDAO = new CarDAO();
    Car assignedCar = carDAO.getAssignedCarByDriverId(driverId);
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Assigned Car</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<%@ include file="header.jsp" %>

<div class="container mt-5">
    <h2 class="text-center mb-4">My Assigned Car</h2>

    <% if (assignedCar != null) { %>
        <div class="card">
            <div class="card-body">
                <h5 class="card-title">Car Details</h5>
                <p><strong>Car ID:</strong> <%= assignedCar.getCarID() %></p>
                <p><strong>Model:</strong> <%= assignedCar.getModel() %></p>
                <p><strong>Plate Number:</strong> <%= assignedCar.getPlateNumber() %></p>
                <p><strong>Status:</strong> <%= assignedCar.getStatus() %></p>
            </div>
        </div>
    <% } else { %>
        <div class="alert alert-warning text-center">No car has been assigned to you yet.</div>
    <% } %>
</div>

<%@ include file="footer.jsp" %>

</body>
</html>
