<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="com.megacitycab.dao.admin.EmployeeDAO" %>
<%@ page import="com.megacitycab.dao.admin.CarDAO" %>
<%@ page import="com.megacitycab.model.admin.Employee" %>
<%@ page import="com.megacitycab.model.admin.Car" %>
<%@ page session="true" %>

<%
    // Check if admin session exists
    String adminId = (String) session.getAttribute("adminId");

    if (adminId == null) {
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
        car = carDAO.findCarById(carIdStr);
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Assign Car to Driver</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/all_css/admin/Assign.css">
</head>
<body>
<%@ include file="header.jsp" %>

<div class="container">
    <h2 class="text-center">Assign Car to Driver </h2>

    <!-- Form to fetch details -->
    <form method="get" class="dark-form">
        <div class="mb-4">
            <label for="employeeId" class="form-label">Employee ID</label>
            <input type="text" class="form-control" id="employeeId" name="employeeId" placeholder="EMP001" required>
        </div>

        <div class="mb-4">
            <label for="carId" class="form-label">Car ID</label>
            <input type="text" class="form-control" id="carId" name="carId" placeholder="CAR001" required>
        </div>

        <button type="submit" class="btn btn-primary w-100">Get Details</button>
    </form>

    <!-- Employee Details Card -->
    <% if (employee != null) { %>
        <div class="card dark-card mt-4">
            <div class="card-body">
                <h5 class="card-title"> Employee Details</h5>
                <ul>
                    <li><strong>ID:</strong> <%= employee.getEmployeeID() %></li>
                    <li><strong>Username:</strong> <%= employee.getUsername() %></li>
                    <li><strong>Email:</strong> <%= employee.getEmail() %></li>
                </ul>
            </div>
        </div>
    <% } else if (employeeId != null) { %>
        <div class="alert alert-danger text-center mt-4">No employee found with ID: <%= employeeId %></div>
    <% } %>

    <!-- Car Details Card -->
    <% if (car != null) { %>
        <div class="card dark-card mt-4">
            <div class="card-body">
                <h5 class="card-title"> Car Details</h5>
                <ul>
                    <li><strong>ID:</strong> <%= car.getCarID() %></li>
                    <li><strong>Model:</strong> <%= car.getModel() %></li>
                    <li><strong>Plate:</strong> <%= car.getPlateNumber() %></li>
                    <li><strong>Status:</strong> <%= car.getStatus() %></li>
                </ul>
            </div>
        </div>
    <% } else if (carIdStr != null) { %>
        <div class="alert alert-danger text-center mt-4">No car found with ID: <%= carIdStr %></div>
    <% } %>

    <!-- Assign Car Button -->
    <% if (employee != null && car != null) { %>
        <form method="post" action="<%= request.getContextPath() %>/AssignCarServlet" class="mt-4">
            <input type="hidden" name="employeeId" value="<%= employee.getEmployeeID() %>">
            <input type="hidden" name="carId" value="<%= car.getCarID() %>">

            <button type="submit" class="btn btn-success w-100"> Assign Car</button>
        </form>
    <% } %>
</div>

<%@ include file="footer.jsp" %>
</body>
</html>
