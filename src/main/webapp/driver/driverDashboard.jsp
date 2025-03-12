<%@ page language="java" contentType="text/html; charset=UTF-8" %> 
<%
    // Get driverId from session
    String driverId = (String) session.getAttribute("driverId");

    if (driverId == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Driver Dashboard</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/all_css/driver/Driverdashboard.css">
    <script src="https://kit.fontawesome.com/a076d05399.js"></script> <!-- For icons -->
</head>
<body class="bg-dark text-light">

<%@ include file="header.jsp" %>

<main class="dashboard-container">
    <div class="container text-center">
        <h1 class="dashboard-title">Driver Dashboard</h1>
        <div class="row justify-content-center">
            <!-- Profile Management -->
            <div class="col-md-3 mb-4">
                <a href="driverProfile.jsp" class="dashboard-card">
                    <div class="card text-white bg-info">
                        <div class="card-body">
                            <i class="fas fa-user-circle fa-3x mb-3"></i>
                            <h5 class="card-title">My Profile</h5>
                        </div>
                    </div>
                </a>
            </div>

            <!-- Assigned Bookings -->
            <div class="col-md-3 mb-4">
                <a href="driverViewAssignedBooking.jsp" class="dashboard-card">
                    <div class="card text-white bg-warning">
                        <div class="card-body">
                            <i class="fas fa-bookmark fa-3x mb-3"></i>
                            <h5 class="card-title">Assigned Bookings</h5>
                        </div>
                    </div>
                </a>
            </div>

            <!-- Car Details -->
            <div class="col-md-3 mb-4">
                <a href="driverViewCarDetails.jsp" class="dashboard-card">
                    <div class="card text-white bg-success">
                        <div class="card-body">
                            <i class="fas fa-car fa-3x mb-3"></i>
                            <h5 class="card-title">My Car Details</h5>
                        </div>
                    </div>
                </a>
            </div>
        </div>
    </div>
</main>

<%@ include file="footer.jsp" %>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
