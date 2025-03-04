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
    <link rel="stylesheet" href="<%= request.getContextPath() %>/all_css/admin/employee.css">
</head>
<body>
<%@ include file="header.jsp" %>

<div class="container">
    <h2 class="text-center my-4">Employee Management</h2>
    
    <div class="text-end mb-3">
        <a href="EmployeeRegister.jsp" class="btn btn-primary">Add Employee</a>
    </div>

    <table class="table table-bordered text-center">
        <thead class="table-dark">
            <tr>
                <th>Employee ID</th>
                <th>Username</th>
                <th>Email</th>
                <th>Role</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            <%
                EmployeeDAO employeeDAO = new EmployeeDAO();
                List<Employee> employees = employeeDAO.getAllEmployees();
                for (Employee emp : employees) {
            %>
            <tr>
                <td><%= emp.getEmployeeID() %></td>
                <td><%= emp.getUsername() %></td>
                <td><%= emp.getEmail() %></td>
                <td><%= emp.getRole() %></td>
                

<td class="action-buttons">
    <a href="EditEmployee.jsp?id=<%= emp.getEmployeeID() %>" class="edit-btn">Edit</a>
    <a href="DeleteEmployeeServlet?id=<%= emp.getEmployeeID() %>" class="delete-btn" onclick="return confirm('Are you sure?');">Delete</a>
</td>

            </tr>
            <% } %>
        </tbody>
    </table>
</div>
<%@ include file="footer.jsp" %>
</body>
</html>
