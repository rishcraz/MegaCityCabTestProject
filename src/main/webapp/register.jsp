<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MegaCityCab - Signup</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/all_css/Style.css">
    <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
</head>
<body>
    <div class="auth-container">
        <div class="auth-box">
            <h2>Sign Up for <span class="megacity">Mega</span><span class="city">City</span><span class="cab">Cab</span></h2>
            <%-- Display error message if registration fails --%>
            <% if (request.getAttribute("error") != null) { %>
                <div class="alert alert-danger"><%= request.getAttribute("error") %></div>
            <% } %>

            <form action="register" method="post">
                <div class="input-box">
                    <label for="name">Full Name</label>
                    <input type="text" id="name" name="name" placeholder="Enter full name" required>
                </div>
                <div class="input-box">
                    <label for="email">Email</label>
                    <input type="email" id="email" name="email" placeholder="Enter email" required>
                </div>
                <div class="input-box">
                    <label for="phone">Phone Number</label>
                    <input type="tel" id="phone" name="phone" placeholder="Enter phone number" pattern="[0-9]{10}" required>
                </div>
                <div class="input-box">
                    <label for="nic">NIC (Optional)</label>
                    <input type="text" id="nic" name="nic" placeholder="Enter NIC (optional)">
                </div>
                <div class="input-box">
                    <label for="address">Address</label>
                    <input type="text" id="address" name="address" placeholder="Enter address" required>
                </div>
                <div class="input-box">
                    <label for="password">Password</label>
                    <input type="password" id="password" name="password" placeholder="Enter password" required>
                </div>
                <div class="input-box">
                    <label for="confirmPassword">Confirm Password</label>
                    <input type="password" id="confirmPassword" name="confirmPassword" placeholder="Confirm password" required>
                </div>
                <button type="submit" class="auth-btn">Sign Up</button>
                <p class="auth-text">Already have an account? <a href="login.jsp">Login</a></p>
            </form>
        </div>
    </div>
</body>
</html>
