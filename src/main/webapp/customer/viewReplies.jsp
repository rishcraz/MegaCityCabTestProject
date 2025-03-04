<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>  
<%@ page import="dao.customer.InquiryDAO" %>
<%@ page import="model.customer.Inquiry" %>
<%@ page import="java.util.List" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<%@ include file="header.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Inquiries & Replies</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f4f7f6;
        }

        .inquiries-container {
            max-width: 90%;
            margin: 50px auto;
        }

        .table th {
            background-color: #007bff;
            color: white;
            text-align: center;
        }

        .table-striped tbody tr:nth-of-type(odd) {
            background-color: #f8f9fa;
        }

        .status-pending {
            color: #ffc107;
            font-weight: bold;
        }

        .status-replied {
            color: #28a745;
            font-weight: bold;
        }

        .no-replies {
            color: #dc3545;
            font-weight: bold;
        }
    </style>
</head>
<body>
<%-- Session check for customer --%>
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
    <h2 class="text-center mb-4">My Inquiries & Replies</h2>

    <div class="table-responsive">
        <table class="table table-bordered table-striped">
            <thead>
                <tr>
                    <th>Inquiry No</th>
                    <th>Subject</th>
                    <th>Message</th>
                    <th>Status</th>
                    <th>MegaCityCab</th>
                </tr>
            </thead>
            <tbody>
            <% if (inquiries.isEmpty()) { %>
                <tr>
                    <td colspan="6" class="text-center text-muted">No inquiries found.</td>
                </tr>
            <% } else { 
                for (Inquiry inquiry : inquiries) { %>
                <tr>
                    <td class="text-center"><%= inquiry.getInquiryId() %></td>
                    <td><%= inquiry.getSubject() %></td>
                    <td><%= inquiry.getMessage() %></td>
                    <td class="text-center">
                        <% if ("Pending".equalsIgnoreCase(inquiry.getStatus())) { %>
                            <span class="status-pending">Pending</span>
                        <% } else { %>
                            <span class="status-replied">Replied</span>
                        <% } %>
                    </td>
                    <td>
                        <%= (inquiry.getReply() != null && !inquiry.getReply().isEmpty()) ? inquiry.getReply() : "<span class='no-replies'>No reply yet</span>" %>
                    </td>
                </tr>
            <% } } %>
            </tbody>
        </table>
    </div>
</div>

<%@ include file="footer.jsp" %>
</body>
</html>
