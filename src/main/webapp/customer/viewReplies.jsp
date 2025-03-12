<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>   
<%@ page import="com.megacitycab.dao.customer.InquiryDAO" %>
<%@ page import="com.megacitycab.model.customer.Inquiry" %>
<%@ page import="java.util.List" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<%@ include file="header.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Inquiries & Replies</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/all_css/customer/inquiries.css">
</head>
<body>
<%
    HttpSession sessionObj = request.getSession(false);
    String userId = (sessionObj != null) ? (String) sessionObj.getAttribute("userId") : null;

    if (userId == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    InquiryDAO inquiryDAO = new InquiryDAO();
    List<Inquiry> inquiries = inquiryDAO.getInquiriesByUserId(userId);
%>

<div class="inquiries-container">
    <div class="header-section text-center">
        <h2>My Inquiries & Replies</h2>
        <p class="lead">Track your inquiries and view responses from MegaCityCab support.</p>
    </div>

    <% if (inquiries.isEmpty()) { %>
        <div class="alert alert-info text-center" role="alert">
            You haven't made any inquiries yet.
        </div>
    <% } else { %>
        <div class="inquiry-cards">
            <% for (Inquiry inquiry : inquiries) { %>
                <div class="inquiry-card">
                    <div class="inquiry-header">
                        <h5>Inquiry #<%= inquiry.getInquiryId() %></h5>
                        <span class="badge <%= "Pending".equalsIgnoreCase(inquiry.getStatus()) ? "bg-warning text-dark" : "bg-success" %>">
                            <%= inquiry.getStatus() %>
                        </span>
                    </div>
                    <div class="inquiry-body">
                        <p><strong>Subject:</strong> <%= inquiry.getSubject() %></p>
                        <p><strong>Message:</strong> <%= inquiry.getMessage() %></p>
                    </div>
                    <div class="inquiry-reply">
                        <h6>Response:</h6>
                        <p>
                            <%= (inquiry.getReply() != null && !inquiry.getReply().isEmpty()) ? 
                                "<span class='text-success'>" + inquiry.getReply() + "</span>" : 
                                "<span class='text-muted'>No reply yet</span>" %>
                        </p>
                    </div>
                </div>
            <% } %>
        </div>
    <% } %>
</div>

<%@ include file="footer.jsp" %>
</body>
</html>
