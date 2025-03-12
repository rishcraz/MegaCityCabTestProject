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
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/driverAssignedCar.css">
</head>
<body class="bg-dark text-light">

<%@ include file="header.jsp" %>

<div class="container mt-5">
    <h2 class="text-center text-info mb-4">Assigned Car for You</h2>

    <% if (assignedCar != null) { %>
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card bg-dark text-white shadow-lg">
                    <div class="card-header text-center bg-primary">
                        <h4>Car Details</h4>
                    </div>
                    <div class="card-body">
                        <ul class="list-unstyled">
                            <li><strong>Car ID:</strong> <%= assignedCar.getCarID() %></li>
                            <li><strong>Model:</strong> <%= assignedCar.getModel() %></li>
                            <li><strong>Plate Number:</strong> <%= assignedCar.getPlateNumber() %></li>
                            <li><strong>Status:</strong> <%= assignedCar.getStatus() %></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    <% } else { %>
        <div class="alert alert-warning text-center mt-5" role="alert">
            No car has been assigned to you yet.
        </div>
    <% } %>
</div>

<%@ include file="footer.jsp" %>

<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
</body>
</html>
