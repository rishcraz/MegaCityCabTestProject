<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/all_css/header.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
</head>
<body>
    <header class="header">
        <!-- Logo & Branding -->
        <div class="logo-container">
            <img src="<%= request.getContextPath() %>/component/pictures/car6.png" alt="MegaCityCab Logo" class="logo">
            <h1 class="brand-name">Mega<span class="yellow-text">City</span>Cab</h1>
        </div>

        <!-- Navigation Links -->
        <nav class="nav-links">
            <a href="<%= request.getContextPath() %>/customer/CustomerDashboard.jsp" class="nav-item"><i class="fas fa-home"></i> Home</a>
            <a href="<%= request.getContextPath() %>/customer/booking.jsp" class="nav-item"><i class="fas fa-taxi"></i> Book Now</a>
            <a href="<%= request.getContextPath() %>/customer/billing.jsp" class="nav-item"><i class="fas fa-file-invoice-dollar"></i> Billing</a>
            <a href="<%= request.getContextPath() %>/customer/AboutUs.jsp" class="nav-item"><i class="fas fa-info-circle"></i> About Us</a>
            <a href="<%= request.getContextPath() %>/customer/contactUs.jsp" class="nav-item"><i class="fas fa-envelope"></i> Contact Us</a>
        </nav>

        <!-- Profile & Logout Icons -->
        <div class="nav-icons">
            <a href="<%= request.getContextPath() %>/customer/customerProfile.jsp" class="profile-icon" title="Profile">
                <i class="fas fa-user"></i>
            </a>
            <a href="<%= request.getContextPath() %>/landing.jsp" class="exit-icon" title="Logout">
                <i class="fas fa-sign-out-alt"></i>
            </a>
        </div>
    </header>
</body>
</html>
