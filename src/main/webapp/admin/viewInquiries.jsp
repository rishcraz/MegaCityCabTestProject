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

    InquiryDAO inquiryDAO = new InquiryDAO();
    List<Inquiry> inquiries = inquiryDAO.getAllInquiries();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Customer Inquiries</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/all_css/admin/Complaint.css">
</head>
<body class="dark-theme">
<%@ include file="header.jsp" %>

<div class="container mt-5">
    <h2 class="text-center text-warning mb-4">Customer Inquiries</h2>
    
    <div class="row">
        <% if (inquiries.isEmpty()) { %>
            <div class="text-center text-light">
                <p>No customer inquiries found.</p>
            </div>
        <% } else { %>
            <% for (Inquiry inquiry : inquiries) { %>
                <div class="col-md-6 mb-4">
                    <div class="card bg-dark text-light shadow-sm">
                        <div class="card-body">
                            <h5 class="card-title"><%= inquiry.getSubject() %></h5>
                            <p class="card-text"><strong>From:</strong> <%= inquiry.getName() %> (<%= inquiry.getEmail() %>)</p>
                            <p class="card-text"><strong>Status:</strong> 
                                <span class="<%= inquiry.getStatus().equals("Pending") ? "text-danger" : "text-success" %>">
                                    <%= inquiry.getStatus() %>
                                </span>
                            </p>
                            <a href="replyInquiry.jsp?inquiryId=<%= inquiry.getInquiryId() %>" class="btn btn-warning btn-sm">
                                View
                            </a>
                        </div>
                    </div>
                </div>
            <% } %>
        <% } %>
    </div>
</div>

<%@ include file="footer.jsp" %>
</body>
</html>
