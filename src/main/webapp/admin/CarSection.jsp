<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.admin.Car" %>
<%@ page import="dao.admin.CarDAO" %>
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
    CarDAO carDAO = new CarDAO();
    List<Car> cars = carDAO.getAllCars();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Car Management</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/all_css/admin/car.css">
</head>
<body>
<%@ include file="header.jsp" %>
    <div class="dashboard-container">
        <h1>Car Management</h1>

        <form action="AddCarServlet" method="post">
            <input type="text" name="model" placeholder="Car Model" required>
            <input type="text" name="plateNumber" placeholder="Plate Number" required>
            <select name="status">
                <option value="Available">Available</option>
                <option value="Unavailable">Unavailable</option>
            </select>
            <button type="submit">Add Car</button>
        </form>

        <table class="table table-striped table-bordered mt-3">
            <thead class="table-primary">
                <tr>
                    <th>Car ID</th>
                    <th>Model</th>
                    <th>Plate Number</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <% for (Car car : cars) { %>
                <tr>
                    <td><%= car.getCarID() %></td>
                    <td><%= car.getModel() %></td>
                    <td><%= car.getPlateNumber() %></td>
                    <td><%= car.getStatus() %></td>
                    <td>
                        <a href="UpdateCar.jsp?id=<%= car.getCarID() %>" class="btn btn-warning btn-sm">Edit</a>
                        <a href="DeleteCarServlet?id=<%= car.getCarID() %>" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure?')">Delete</a>
                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>
    <%@ include file="footer.jsp" %>
</body>
</html>
