<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="dao.admin.EmployeeDAO" %>
<%@ page import="model.admin.Employee" %>

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
    <style>
        .container {
            max-width: 600px;
            margin: 50px auto;
        }
        .card {
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
    </style>
    <script>
        function toggleForm() {
            const form = document.getElementById('updateForm');
            const card = document.getElementById('profileCard');
            if (form.style.display === 'none') {
                form.style.display = 'block';
                card.style.display = 'none';
            } else {
                form.style.display = 'none';
                card.style.display = 'block';
            }
        }
    </script>
</head>
<body>

<%@ include file="header.jsp" %>

<div class="container">
    <h2 class="text-center mb-4">My Profile</h2>

    <% if (driver != null) { %>
        <!-- Driver Profile Card -->
        <div class="card" id="profileCard">
            <h5 class="text-center mb-4">Driver Details</h5>
            <p><strong>Employee ID:</strong> <%= driver.getEmployeeID() %></p>
            <p><strong>Full Name:</strong> <%= driver.getUsername() %></p>
            <p><strong>Email:</strong> <%= driver.getEmail() %></p>
            <p><strong>Phone Number:</strong> <%= driver.getPhone() != null ? driver.getPhone() : "Enter Your Phone No" %></p>
            <button type="button" class="btn btn-primary w-100 mt-3" onclick="toggleForm()">Update Profile</button>
        </div>

        <!-- Update Profile Form (Hidden by Default) -->
        <form method="post" action="<%= request.getContextPath() %>/UpdateDriverProfileServlet" style="display: none;" id="updateForm">
            <input type="hidden" name="employeeId" value="<%= driver.getEmployeeID() %>">

            <div class="mb-3">
                <label for="username" class="form-label">Full Name</label>
                <input type="text" class="form-control" id="username" name="username" value="<%= driver.getUsername() %>" required>
            </div>

            <div class="mb-3">
                <label for="email" class="form-label">Email</label>
                <input type="email" class="form-control" id="email" name="email" value="<%= driver.getEmail() %>" required>
            </div>

            <div class="mb-3">
                <label for="phone" class="form-label">Phone Number</label>
                <input type="text" class="form-control" id="phone" name="phone" value="<%= driver.getPhone() != null ? driver.getPhone() : "" %>">
            </div>

            <button type="submit" class="btn btn-success w-100">Save Changes</button>
            <button type="button" class="btn btn-secondary w-100 mt-2" onclick="toggleForm()">Cancel</button>
        </form>
    <% } else { %>
        <p class="text-center text-danger">Driver profile not found.</p>
    <% } %>
</div>

<%@ include file="footer.jsp" %>

</body>
</html>
