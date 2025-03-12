<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, model.admin.Employee, dao.admin.EmployeeDAO" %>
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

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Employee Management</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/all_css/admin/Employee.css">
</head>
<body class="bg-dark text-light">

<%@ include file="header.jsp" %>

<div class="container mt-5">
    <h2 class="text-center my-4">Employee Management</h2>
    
    <div class="text-end mb-3">

    </div>

    <div class="list-group">
        <%
            EmployeeDAO employeeDAO = new EmployeeDAO();
            List<Employee> employees = employeeDAO.getAllEmployees();
            for (Employee emp : employees) {
        %>
        <div class="list-group-item d-flex justify-content-between align-items-center bg-secondary text-white mb-3">
            <div>
                <h5 class="mb-1"><%= emp.getUsername() %></h5>
                <p class="mb-1">
                    <strong>Employee ID:</strong> <%= emp.getEmployeeID() %><br>
                    <strong>Email:</strong> <%= emp.getEmail() %><br>
                    <strong>Role:</strong> <%= emp.getRole() %>
                </p>
            </div>
            <div class="action-buttons">
                <a href="EditEmployee.jsp?id=<%= emp.getEmployeeID() %>" class="btn btn-warning btn-sm">Edit</a>
                <a href="DeleteEmployeeServlet?id=<%= emp.getEmployeeID() %>" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure?');">Delete</a>
            </div>
        </div>
        <% } %>
    </div>
</div>

<%@ include file="footer.jsp" %>

</body>
</html>
