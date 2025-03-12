<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/all_css/admin/AdminDashboard.css">
    <script src="https://kit.fontawesome.com/a076d05399.js"></script> 
</head>
<body class="bg-dark text-light">

<%@ include file="header.jsp" %>

<%
    // Check if admin session exists
    String adminId = (String) session.getAttribute("adminId");

    if (adminId == null) {
        // If admin session is missing, redirect to login page
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
%>

<main class="dashboard-container">
    <div class="container text-center">
        <h1 class="dashboard-title">Admin Dashboard</h1>

        <div class="row justify-content-center">
           
            <div class="col-md-3 mb-4">
                <a href="ViewAccounts.jsp" class="dashboard-card">
                    <div class="card text-white bg-primary">
                        <div class="card-body">
                            <i class="fas fa-users fa-3x mb-3"></i>
                            <h5 class="card-title">Customer Accounts</h5>
                        </div>
                    </div>
                </a>
            </div>

           
            <div class="col-md-3 mb-4">
                <a href="EmployeeSection.jsp" class="dashboard-card">
                    <div class="card text-white bg-dark">
                        <div class="card-body">
                            <i class="fas fa-briefcase fa-3x mb-3"></i>
                            <h5 class="card-title">Employee Details</h5>
                        </div>
                    </div>
                </a>
            </div>

           
            <div class="col-md-3 mb-4">
                <a href="CarSection.jsp" class="dashboard-card">
                    <div class="card text-white bg-success">
                        <div class="card-body">
                            <i class="fas fa-car fa-3x mb-3"></i>
                            <h5 class="card-title">Manage Car</h5>
                        </div>
                    </div>
                </a>
            </div>

            
            <div class="col-md-3 mb-4">
                <a href="viewInquiries.jsp" class="dashboard-card">
                    <div class="card text-white bg-warning">
                        <div class="card-body">
                            <i class="fas fa-comment-dots fa-3x mb-3"></i>
                            <h5 class="card-title">Customer Service</h5>
                        </div>
                    </div>
                </a>
            </div>

          
            <div class="col-md-3 mb-4">
                <a href="FareManagement.jsp" class="dashboard-card">
                    <div class="card text-white bg-info">
                        <div class="card-body">
                            <i class="fas fa-dollar-sign fa-3x mb-3"></i>
                            <h5 class="card-title">Rate Regulation</h5>
                        </div>
                    </div>
                </a>
            </div>

            
            <div class="col-md-3 mb-4">
                <a href="assignCar.jsp" class="dashboard-card">
                    <div class="card text-white bg-secondary">
                        <div class="card-body">
                            <i class="fas fa-car fa-3x mb-3"></i>
                            <h5 class="card-title">Assign Cars</h5>
                        </div>
                    </div>
                </a>
            </div>

            
            <div class="col-md-3 mb-4">
                <a href="EmployeeRegister.jsp" class="dashboard-card">
                    <div class="card text-white bg-danger">
                        <div class="card-body">
                            <i class="fas fa-user-plus fa-3x mb-3"></i>
                            <h5 class="card-title">Add Employee</h5>
                        </div>
                    </div>
                </a>
            </div>

           
            <div class="col-md-3 mb-4">
                <a href="FareRates.jsp" class="dashboard-card">
                        <div class="card text-white bg-primary">
                        <div class="card-body">
                            <i class="fas fa-dollar-sign fa-3x mb-3"></i>
                            <h5 class="card-title">Check Rates</h5>
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
