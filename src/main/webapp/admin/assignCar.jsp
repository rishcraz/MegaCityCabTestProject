<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="dao.admin.EmployeeDAO" %>
<%@ page import="dao.admin.CarDAO" %>
<%@ page import="model.admin.Employee" %>
<%@ page import="model.admin.Car" %>
<%@ page session="true" %>

<%
    // Check if admin session exists
    String adminId = (String) session.getAttribute("adminId");

    if (adminId == null) {
        // If admin session is missing, redirect to login page
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
%>

<%
    String employeeId = request.getParameter("employeeId");
    String carIdStr = request.getParameter("carId");

    Employee employee = null;
    Car car = null;

    if (employeeId != null && carIdStr != null) {
        EmployeeDAO employeeDAO = new EmployeeDAO();
        CarDAO carDAO = new CarDAO();

        employee = employeeDAO.findEmployeeById(employeeId);
        car = carDAO.findCarById(carIdStr); // Using String for carId since it's a VARCHAR in DB
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Assign Car to Driver</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .container {
            max-width: 600px;
            margin-top: 50px;
        }
        .card {
            background: #f8f9fa;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.05);
        }
        h2 { text-align: center; }
    </style>
</head>
<body>

<div class="container">
    <h2>Assign Car to Driver</h2>

    <!-- Form to get employee and car details -->
    <form method="get" class="mb-4">
        <div class="mb-3">
            <label for="employeeId" class="form-label">Employee ID</label>
            <input type="text" class="form-control" id="employeeId" name="employeeId" placeholder="e.g. EMP003" required>
        </div>

        <div class="mb-3">
            <label for="carId" class="form-label">Car ID</label>
            <input type="text" class="form-control" id="carId" name="carId" placeholder="e.g. CAR001" required>
        </div>

        <button type="submit" class="btn btn-info w-100">Get Details</button>
    </form>

    <!-- Employee Details Card -->
    <% if (employee != null) { %>
        <div class="card mb-4">
            <div class="card-body">
                <h5 class="card-title">Employee Details</h5>
                <p><strong>Employee ID:</strong> <%= employee.getEmployeeID() %></p>
                <p><strong>Username:</strong> <%= employee.getUsername() %></p>
                <p><strong>Email:</strong> <%= employee.getEmail() %></p>
            </div>
        </div>
    <% } else if (employeeId != null) { %>
        <div class="alert alert-danger text-center">No employee found with ID: <%= employeeId %></div>
    <% } %>

    <!-- Car Details Card -->
    <% if (car != null) { %>
        <div class="card mb-4">
            <div class="card-body">
                <h5 class="card-title">Car Details</h5>
                <p><strong>Car ID:</strong> <%= car.getCarID() %></p>
                <p><strong>Model:</strong> <%= car.getModel() %></p>
                <p><strong>Plate Number:</strong> <%= car.getPlateNumber() %></p>
                <p><strong>Status:</strong> <%= car.getStatus() %></p>
            </div>
        </div>
    <% } else if (carIdStr != null) { %>
        <div class="alert alert-danger text-center">No car found with ID: <%= carIdStr %></div>
    <% } %>

    <!-- Assign Car Button -->
    <% if (employee != null && car != null) { %>
        <form method="post" action="<%= request.getContextPath() %>/AssignCarServlet">
            <input type="hidden" name="employeeId" value="<%= employee.getEmployeeID() %>">
            <input type="hidden" name="carId" value="<%= car.getCarID() %>">

            <button type="submit" class="btn btn-success w-100">Assign Car</button>
        </form>
    <% } %>
</div>

</body>
</html>
