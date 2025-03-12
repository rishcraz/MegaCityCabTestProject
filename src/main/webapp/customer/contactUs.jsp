<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ page import="com.megacitycab.model.User" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%
    HttpSession userSession = request.getSession(false);
    String userId = (userSession != null) ? (String) userSession.getAttribute("userId") : null;

    if (userId == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp"); // Redirect to login if not logged in
        return;
    }
%>

<%@ include file="header.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact Us</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <style>
    body {
    background: linear-gradient(135deg, #eaf6ff, #d0eaff);
    font-family: Arial, sans-serif;
}
        .contact-container {
            max-width: 600px;
            margin: 50px auto;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            padding: 30px;
            border-radius: 10px;
            background: #f2f8ff;
        }
    </style>
</head>
<body>
<%
    HttpSession sessionObj = request.getSession(false);
    if (sessionObj == null || sessionObj.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    User user = (User) sessionObj.getAttribute("user");
    String success = request.getParameter("success");
    String error = request.getParameter("error");
%>

<div class="container">
    <% if ("1".equals(success)) { %>
        <div class="alert alert-success text-center">Your message has been sent successfully!</div>
    <% } else if ("1".equals(error)) { %>
        <div class="alert alert-danger text-center">Failed to send message. Please try again.</div>
    <% } %>

    <div class="contact-container">
        <h2 class="text-center mb-4">Contact Us</h2>
        <form action="SendInquiryServlet" method="post">
            <input type="hidden" name="userId" value="<%= user.getUserId() %>">

            <div class="mb-3">
                <label for="name" class="form-label">Your Name</label>
                <input type="text" class="form-control" id="name" name="name" value="<%= user.getName() %>" required>
            </div>

            <div class="mb-3">
                <label for="email" class="form-label">Your Email</label>
                <input type="email" class="form-control" id="email" name="email" value="<%= user.getEmail() %>" required>
            </div>

            <div class="mb-3">
                <label for="subject" class="form-label">Subject</label>
                <input type="text" class="form-control" id="subject" name="subject" required>
            </div>

            <div class="mb-3">
                <label for="message" class="form-label">Your Message</label>
                <textarea class="form-control" id="message" name="message" rows="4" required></textarea>
            </div>

            <button type="submit" class="btn btn-primary w-100 mb-2">Send Message</button>
        </form>

        <!-- New "View Replies" Button -->

    </div>
</div>

<%@ include file="footer.jsp" %>
</body>
</html>
