<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.admin.Car" %>
<%@ page import="dao.admin.CarDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="javax.servlet.http.HttpServletRequest" %>
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
    String carID = request.getParameter("id");
    CarDAO carDAO = new CarDAO();
    Car car = carDAO.getCarById(carID);
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Update Car</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/all_css/admin/Carupdate.css">
</head>
<body class="bg-dark text-light">
<%@ include file="header.jsp" %>

    <div class="container py-5">
        <div class="card mx-auto" style="max-width: 600px;">
            <div class="card-header text-center">
                <h3>Update Car Information</h3>
            </div>
            <div class="card-body">
                <form action="UpdateCarServlet" method="post">
                    <input type="hidden" name="carID" value="<%= car.getCarID() %>">

                    <div class="mb-3">
                        <label class="form-label">Model:</label>
                        <input type="text" name="model" class="form-control" value="<%= car.getModel() %>" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Plate Number:</label>
                        <input type="text" name="plateNumber" class="form-control" value="<%= car.getPlateNumber() %>" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Status:</label>
                        <select name="status" class="form-select">
                            <option value="Available" <%= car.getStatus().equals("Available") ? "selected" : "" %>>Available</option>
                            <option value="Unavailable" <%= car.getStatus().equals("Unavailable") ? "selected" : "" %>>Unavailable</option>
                        </select>
                    </div>

                    <div class="d-grid gap-2">
                        <button type="submit" class="btn btn-primary">Update Car</button>
                        <a href="CarSection.jsp" class="btn btn-secondary">Cancel</a>
                    </div>
                </form>
            </div>
        </div>
    </div>

<%@ include file="footer.jsp" %>

</body>
</html>
