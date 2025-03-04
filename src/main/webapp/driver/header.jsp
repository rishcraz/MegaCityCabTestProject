<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/all_css/driver/header.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
</head>
<body>
    <header class="header">
        <!-- Logo & Branding -->
        <div class="logo-container">
            <img src="<%= request.getContextPath() %>/component/pictures/car7.png" alt="MegaCityCab Logo" class="logo">
            <h1 class="brand-name">
                <span class="white-text">Mega</span><span class="yellow-text">City</span><span class="white-text">Cab</span> 
                <span class="yellow-text">| Welcome</span> <span class="white-text">Driver</span>
            </h1>
        </div>

        <!-- Navigation Links -->
        <nav class="nav-links">
            <a href="<%= request.getContextPath() %>/driver/driverDashboard.jsp" class="nav-item"><i class="fas fa-home"></i> Home</a>
            <a href="<%= request.getContextPath() %>/driver/driverProfile.jsp" class="nav-item"><i class="fas fa-user"></i> My Profile</a>
            <a href="<%= request.getContextPath() %>/driver/driverViewAssignedBooking.jsp" class="nav-item"><i class="fas fa-taxi"></i> Assigned Rides</a>
            <a href="<%= request.getContextPath() %>/driver/driverViewCarDetails.jsp" class="nav-item"><i class="fas fa-car"></i> My Car Details</a>
        </nav>

        <!-- Profile & Logout Icons -->
        <div class="nav-icons">
            <a href="<%= request.getContextPath() %>/driver/driverProfile.jsp" class="profile-icon" title="Profile">
                <i class="fas fa-user"></i>
            </a>
            <a href="<%= request.getContextPath() %>/landing.jsp" class="exit-icon" title="Logout">
                <i class="fas fa-sign-out-alt"></i>
            </a>
        </div>
    </header>
</body>
</html>
