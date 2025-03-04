<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ page import="dao.customer.InquiryDAO" %>
<%@ page import="model.customer.Inquiry" %>
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
    <title>Reply to Inquiry</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<%
    String inquiryId = request.getParameter("inquiryId");
    InquiryDAO inquiryDAO = new InquiryDAO();
    Inquiry inquiry = inquiryDAO.getInquiryById(Integer.parseInt(inquiryId));
%>

<div class="container mt-5">
    <h2>Reply to Inquiry</h2>
    <p><strong>From:</strong> <%= inquiry.getName() %> (<%= inquiry.getEmail() %>)</p>
    <p><strong>Subject:</strong> <%= inquiry.getSubject() %></p>
    <p><strong>Message:</strong> <%= inquiry.getMessage() %></p>

    <form action="SendReplyServlet" method="post">
        <input type="hidden" name="inquiryId" value="<%= inquiry.getInquiryId() %>">

        <div class="mb-3">
            <label for="reply" class="form-label">Your Reply</label>
            <textarea class="form-control" id="reply" name="reply" rows="4" required></textarea>
        </div>

        <button type="submit" class="btn btn-success">Send Reply</button>
    </form>
</div>

<%@ include file="footer.jsp" %>
</body>
</html>
