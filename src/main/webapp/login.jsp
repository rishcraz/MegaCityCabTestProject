<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MegaCityCab - Login</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/all_css/Style.css">
    <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
</head>
<body>
    <div class="auth-container">
        <div class="auth-box">
            <h2>Login to <span class="megacity">Mega</span><span class="city">City</span><span class="cab">Cab</span></h2>
            <form action="login" method="post"> <!-- Corrected form action -->
                <div class="input-box">
                    <label for="email">Email</label>
                    <input type="email" id="email" name="email" placeholder="Enter email" required>
                </div>
                <div class="input-box">
                    <label for="password">Password</label>
                    <input type="password" id="password" name="password" placeholder="Enter password" required>
                </div>
                <button type="submit" class="auth-btn">Login</button>
                <p class="auth-text">Don't have an account? <a href="register.jsp">Sign up</a></p>
            </form>
            
            <!-- Social Login Buttons Below Sign Up -->
            <div class="login_option">
                <div class="option">
                    <a href="#" class="google-btn">
                        <img src="component/pictures/google.png" alt="Google">
                        <span>Login with Google</span>
                    </a>
                </div>
                <div class="option">
                    <a href="#" class="apple-btn">
                        <img src="component/pictures/apple.png" alt="Apple">
                        <span>Login with Apple</span>
                    </a>
                </div>
            </div>
        </div>
    </div>
</body>