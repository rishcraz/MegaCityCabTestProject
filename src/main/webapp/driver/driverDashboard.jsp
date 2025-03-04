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
    <link rel="stylesheet" href="<%= request.getContextPath() %>/all_css/driver/dashboard.css">
</head>
<body>

<%@ include file="header.jsp" %>

<main class="dashboard-container">
    <div class="container text-center">
        <h1 class="dashboard-title">Driver Dashboard</h1>
        <div class="row justify-content-center">
            <div class="col-md-3">
                <a href="driverProfile.jsp" class="dashboard-card">
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title">My Profile</h5>
                        </div>
                    </div>
                </a>
            </div>
            <div class="col-md-3">
                <a href="driverViewAssignedBooking.jsp" class="dashboard-card">
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title">Assigned Bookings</h5>
                        </div>
                    </div>
                </a>
            </div>
            <div class="col-md-3">
                <a href="driverViewCarDetails.jsp" class="dashboard-card">
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title">My Car Details</h5>
                        </div>
                    </div>
                </a>
            </div>
        </div>
    </div>
</main>

<%@ include file="footer.jsp" %>

</body>
</html>
