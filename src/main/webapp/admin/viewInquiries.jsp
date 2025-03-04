<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ page import="dao.customer.InquiryDAO" %>
<%@ page import="model.customer.Inquiry" %>
<%@ page import="java.util.List" %>
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


<%@ include file="header.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Customer Inquiries</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h2 class="text-center mb-4">Customer Inquiries</h2>

    <%
        InquiryDAO inquiryDAO = new InquiryDAO();
        List<Inquiry> inquiries = inquiryDAO.getAllInquiries();
    %>

    <table class="table table-bordered table-striped">
        <thead>
            <tr>
                <th>Inquiry ID</th>
                <th>Name</th>
                <th>Email</th>
                <th>Subject</th>
                <th>Status</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
        <% for (Inquiry inquiry : inquiries) { %>
            <tr>
                <td><%= inquiry.getInquiryId() %></td>
                <td><%= inquiry.getName() %></td>
                <td><%= inquiry.getEmail() %></td>
                <td><%= inquiry.getSubject() %></td>
                <td><%= inquiry.getStatus() %></td>
                <td>
                    <a href="replyInquiry.jsp?inquiryId=<%= inquiry.getInquiryId() %>" class="btn btn-info btn-sm">View & Reply</a>
                </td>
            </tr>
        <% } %>
        </tbody>
    </table>
</div>

<%@ include file="footer.jsp" %>
</body>
</html>
