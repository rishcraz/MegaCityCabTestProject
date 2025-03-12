<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.megacitycab.model.admin.Car" %>
<%@ page import="com.megacitycab.dao.admin.CarDAO" %>
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
    <link rel="stylesheet" href="<%= request.getContextPath() %>/all_css/admin/Car.css">
</head>
<body class="bg-dark text-light">
<%@ include file="header.jsp" %>

    <div class="container mt-5">
        <div class="card bg-secondary border-light rounded shadow-lg">
            <div class="card-header text-center text-white">
                <h1>Car Management</h1>
            </div>
            <div class="card-body">
                <div class="row">
                    <div class="col-12 col-md-6 mx-auto">
                        <form action="AddCarServlet" method="post">
                            <div class="mb-3">
                                <input type="text" name="model" placeholder="Car Model" class="form-control" required>
                            </div>
                            <div class="mb-3">
                                <input type="text" name="plateNumber" placeholder="Plate Number" class="form-control" required>
                            </div>
                            <div class="mb-3">
                                <select name="status" class="form-select" required>
                                    <option value="Available">Available</option>
                                    <option value="Unavailable">Unavailable</option>
                                </select>
                            </div>
                            <button type="submit" class="btn btn-primary w-100">Add Car</button>
                        </form>
                    </div>
                </div>

                <div class="table-responsive mt-5">
                    <table class="table table-dark table-hover table-bordered">
                        <thead>
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
            </div>
        </div>
    </div>

<%@ include file="footer.jsp" %>
</body>
</html>
