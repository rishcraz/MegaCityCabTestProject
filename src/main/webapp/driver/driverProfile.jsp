<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="com.megacitycab.dao.admin.EmployeeDAO" %>
<%@ page import="com.megacitycab.model.admin.Employee" %>

<%
    // Get driverId from session
    String driverId = (String) session.getAttribute("driverId");

    if (driverId == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    // Fetch driver details
    EmployeeDAO employeeDAO = new EmployeeDAO();
    Employee driver = employeeDAO.findEmployeeById(driverId); // Renamed method
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Driver Profile</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
<link rel="stylesheet" href="<%= request.getContextPath() %>/all_css/driver/profile.css">
</head>
<body>

<%@ include file="header.jsp" %>

<div class="profile-container">
    <h2 class="text-center">My Profile</h2>

    <% if (driver != null) { %>
        <!-- Driver Profile Details -->
        <div class="profile-details" id="profileDetails">
            <h4 class="text-center">Driver Details</h4>
            <p><strong>Employee ID:</strong> <%= driver.getEmployeeID() %></p>
            <p><strong>Full Name:</strong> <%= driver.getUsername() %></p>
            <p><strong>Email:</strong> <%= driver.getEmail() %></p>
            <p><strong>Phone Number:</strong> <%= driver.getPhone() != null ? driver.getPhone() : "Enter Your Phone No" %></p>
            <button type="button" class="btn btn-primary" onclick="toggleForm()">Update Profile</button>
        </div>

        <!-- Update Profile Form (Hidden by Default) -->
        <form method="post" action="<%= request.getContextPath() %>/UpdateDriverProfileServlet" style="display: none;" id="updateForm">
            <input type="hidden" name="employeeId" value="<%= driver.getEmployeeID() %>">

            <div class="form-group">
                <label for="username">Full Name</label>
                <input type="text" class="form-control" id="username" name="username" value="<%= driver.getUsername() %>" required>
            </div>

            <div class="form-group">
                <label for="email">Email</label>
                <input type="email" class="form-control" id="email" name="email" value="<%= driver.getEmail() %>" required>
            </div>

            <div class="form-group">
                <label for="phone">Phone Number</label>
                <input type="text" class="form-control" id="phone" name="phone" value="<%= driver.getPhone() != null ? driver.getPhone() : "" %>">
            </div>

            <div class="button-container">
                <button type="submit" class="btn btn-success">Save Changes</button>
                <button type="button" class="btn btn-secondary" onclick="toggleForm()">Cancel</button>
            </div>
        </form>
    <% } else { %>
        <p class="text-center text-danger">Driver profile not found.</p>
    <% } %>
</div>

<%@ include file="footer.jsp" %>

<script>
    function toggleForm() {
        const form = document.getElementById('updateForm');
        const details = document.getElementById('profileDetails');
        if (form.style.display === 'none') {
            form.style.display = 'block';
            details.style.display = 'none';
        } else {
            form.style.display = 'none';
            details.style.display = 'block';
        }
    }
</script>

</body>
</html>
