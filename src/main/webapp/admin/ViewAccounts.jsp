<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.megacitycab.model.User"%>
<%@ page import="com.megacitycab.dao.UserDAO"%>
<%@ page session="true" %>
<%
    String adminId = (String) session.getAttribute("adminId");
    if (adminId == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    UserDAO userDAO = new UserDAO();
    List<User> customers = userDAO.getAllCustomers();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>View Accounts</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/all_css/admin/Useraccounts.css">
</head>
<body class="bg-dark text-light">

<%@ include file="header.jsp" %>

<div class="container mt-5">
    <div class="dashboard-container bg-dark text-light">
        <h1 class="text-center mb-4">Customer Accounts</h1>
        <table class="table table-striped table-dark table-bordered">
            <thead>
                <tr>
                    <th>Customer ID</th>
                    <th>Full Name</th>
                    <th>Email</th>
                    <th>Phone</th>
                    <th>Address</th>
                    <th>Status</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <% for (User customer : customers) { %>
                <tr>
                    <td><%= customer.getUserId() %></td>
                    <td><%= customer.getName() %></td>
                    <td><%= customer.getEmail() %></td>
                    <td><%= customer.getPhone() %></td>
                    <td><%= customer.getAddress() != null ? customer.getAddress() : "N/A" %></td>
                    <td>
                        <% if ("Customer".equals(customer.getRole())) { %>
                            <span class="badge bg-success">Active</span>
                        <% } else { %>
                            <span class="badge bg-danger">Deactivated</span>
                        <% } %>
                    </td>
                    <td>
                        <% if ("Customer".equals(customer.getRole())) { %>
                            <a href="DeactivateCustomerServlet?id=<%= customer.getUserId() %>" class="btn btn-warning btn-sm">Deactivate</a>
                        <% } else { %>
                            <span class="text-muted">Deactivated</span>
                        <% } %>
                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>
</div>

<%@ include file="footer.jsp" %>

</body>
</html>
