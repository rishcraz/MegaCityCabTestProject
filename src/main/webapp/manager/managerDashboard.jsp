<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<%
    HttpSession sessionObj = request.getSession(false);
    String managerId = (sessionObj != null) ? (String) sessionObj.getAttribute("managerId") : null;

    if (managerId == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manager Dashboard</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/all_css/manager/Managerdashboard.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
</head>
<body class="bg-dark text-light">

<%@ include file="header.jsp" %>

<main class="dashboard-container">
    <div class="container text-center">
        <h1 class="dashboard-title">Manager Dashboard</h1>
        <div class="row justify-content-center">
            <!-- Booking Management -->
            <div class="col-md-3 mb-4">
                <a href="ManagerBookingConfirmation.jsp" class="dashboard-card">
                    <div class="card text-white bg-primary">
                        <div class="card-body">
                            <i class="fas fa-calendar-check fa-3x mb-3"></i>
                            <h5 class="card-title">Booking Management</h5>
                        </div>
                    </div>
                </a>
            </div>

            <!-- Billing Management -->
            <div class="col-md-3 mb-4">
                <a href="generateBill.jsp" class="dashboard-card">
                    <div class="card text-white bg-warning">
                        <div class="card-body">
                            <i class="fas fa-file-invoice-dollar fa-3x mb-3"></i>
                            <h5 class="card-title">Billing Management</h5>
                        </div>
                    </div>
                </a>
            </div>

            <!-- Fare Management -->
            <div class="col-md-3 mb-4">
                <a href="EditFareRate.jsp" class="dashboard-card">
                    <div class="card text-white bg-success">
                        <div class="card-body">
                            <i class="fas fa-money-bill-wave fa-3x mb-3"></i>
                            <h5 class="card-title">Fare Management</h5>
                        </div>
                    </div>
                </a>
            </div>

            <!-- Assign Driver -->
            <div class="col-md-3 mb-4">
                <a href="assignDriver.jsp" class="dashboard-card">
                    <div class="card text-white bg-info">
                        <div class="card-body">
                            <i class="fas fa-user-tie fa-3x mb-3"></i>
                            <h5 class="card-title">Assign Driver</h5>
                        </div>
                    </div>
                </a>
            </div>

            <!-- Pending Bills -->
            <div class="col-md-3 mb-4">
                <a href="confirmBill.jsp" class="dashboard-card">
                    <div class="card text-white bg-danger">
                        <div class="card-body">
                            <i class="fas fa-exclamation-circle fa-3x mb-3"></i>
                            <h5 class="card-title">Pending Bills</h5>
                        </div>
                    </div>
                </a>
            </div>

            <!-- Driver Responses -->
            <div class="col-md-3 mb-4">
                <a href="managerViewDriverResponses.jsp" class="dashboard-card">
                    <div class="card text-white bg-dark">
                        <div class="card-body">
                            <i class="fas fa-comments fa-3x mb-3"></i>
                            <h5 class="card-title">Driver Responses</h5>
                        </div>
                    </div>
                </a>
            </div>

            <!-- Cancelled Bookings -->
            <div class="col-md-3 mb-4">
                <a href="CancelledBookings.jsp" class="dashboard-card">
                    <div class="card text-white bg-secondary">
                        <div class="card-body">
                            <i class="fas fa-times-circle fa-3x mb-3"></i>
                            <h5 class="card-title">Cancelled Bookings</h5>
                        </div>
                    </div>
                </a>
            </div>

            <!-- Confirmed Bookings -->
            <div class="col-md-3 mb-4">
                <a href="ConfirmedBookings.jsp" class="dashboard-card">
                    <div class="card text-white bg-success">
                        <div class="card-body">
                            <i class="fas fa-check-circle fa-3x mb-3"></i>
                            <h5 class="card-title">Confirmed Bookings</h5>
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
