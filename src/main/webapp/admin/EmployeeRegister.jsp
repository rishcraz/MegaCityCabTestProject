<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.megacitycab.dao.admin.EmployeeDAO" %>
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
    // Fetch the last employee ID and generate the next one
    EmployeeDAO dao = new EmployeeDAO();
    String nextEmployeeID = dao.generateNextEmployeeID(); 
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Register Employee</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/all_css/admin/Register.css">
</head>
<body class="bg-dark text-light">

<%@ include file="header.jsp" %>

<div class="container mt-5">
    <h2 class="text-center my-4">Register Employee</h2>

    <div class="card bg-secondary text-white shadow-lg">
        <div class="card-body">
            <h5 class="card-title text-center mb-4">Employee Registration</h5>

            <form action="<%= request.getContextPath() %>/admin/RegisterEmployeeServlet" method="post">
                <div class="row mb-3">
                    <div class="col-12 col-md-6">
                        <label class="form-label">Employee ID</label>
                        <input type="text" name="employeeID" class="form-control" value="<%= nextEmployeeID %>" readonly>
                    </div>
                    <div class="col-12 col-md-6">
                        <label class="form-label">Username</label>
                        <input type="text" name="username" class="form-control" required>
                    </div>
                </div>

                <div class="mb-3">
                    <label class="form-label">Password</label>
                    <input type="password" name="password" class="form-control" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Email</label>
                    <input type="email" name="email" class="form-control" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Role</label>
                    <select name="role" class="form-select">
                        <option value="Admin">Admin</option>
                        <option value="Manager">Manager</option>
                        <option value="Driver">Driver</option>
                    </select>
                </div>

                <div class="d-flex justify-content-between">
                    <button type="submit" class="btn btn-success">Register Employee</button>
           
                </div>
            </form>
        </div>
    </div>
</div>

<%@ include file="footer.jsp" %>

</body>
</html>
