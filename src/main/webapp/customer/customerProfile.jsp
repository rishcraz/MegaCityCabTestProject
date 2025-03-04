<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ page import="model.User" %>
<%@ page import="dao.UserDAO" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%
    HttpSession userSession = request.getSession(false);
    String userId = (userSession != null) ? (String) userSession.getAttribute("userId") : null;

    if (userId == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp"); // Redirect to login if not logged in
        return;
    }
%>

<!-- Include the header -->
<%@ include file="header.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Profile</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .profile-card {
            max-width: 600px;
            margin: 50px auto;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
            overflow: hidden;
        }
        .card-header {
            background: #007bff;
            color: white;
            text-align: center;
            padding: 20px;
        }
        .card-body {
            padding: 30px;
        }
        .edit-btn {
            display: block;
            width: 100%;
        }
        .hidden-form {
            display: none;
        }
    </style>
</head>
<body>
<%
    HttpSession sessionObj = request.getSession(false);
    if (sessionObj == null || sessionObj.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    User loggedInUser = (User) sessionObj.getAttribute("user");
    UserDAO userDAO = new UserDAO();
    User user = userDAO.getCustomerById(loggedInUser.getUserId());

    String success = request.getParameter("success");
    String error = request.getParameter("error");
%>

<div class="container">
    <% if ("1".equals(success)) { %>
        <div class="alert alert-success text-center">Profile updated successfully!</div>
    <% } else if ("1".equals(error)) { %>
        <div class="alert alert-danger text-center">Failed to update profile. Please try again!</div>
    <% } %>

    <!-- Profile Card -->
    <div class="card profile-card">
        <div class="card-header">
            <h3><%= user.getName() %></h3>
        </div>
        <div class="card-body">
            <p><strong>Email:</strong> <%= user.getEmail() %></p>
            <p><strong>Phone:</strong> <%= user.getPhone() %></p>
            <p><strong>NIC:</strong> <%= user.getNic() %></p>
            <p><strong>Address:</strong> <%= user.getAddress() %></p>

            <button class="btn btn-primary edit-btn" onclick="toggleForm()">Edit Profile</button>
        </div>
    </div>

    <!-- Hidden Profile Edit Form -->
    <div class="card profile-card hidden-form" id="editForm">
        <div class="card-header">
            <h3>Edit Profile</h3>
        </div>
        <div class="card-body">
            <form action="UpdateProfileServlet" method="post" class="needs-validation" novalidate>
                <input type="hidden" name="userId" value="<%= user.getUserId() %>">

                <div class="mb-3">
                    <label for="name" class="form-label">Full Name</label>
                    <input type="text" class="form-control" id="name" name="name" value="<%= user.getName() %>" required>
                </div>

                <div class="mb-3">
                    <label for="email" class="form-label">Email</label>
                    <input type="email" class="form-control" id="email" name="email" value="<%= user.getEmail() %>" required>
                </div>

                <div class="mb-3">
                    <label for="phone" class="form-label">Phone</label>
                    <input type="text" class="form-control" id="phone" name="phone" value="<%= user.getPhone() %>" required>
                </div>

                <div class="mb-3">
                    <label for="nic" class="form-label">NIC</label>
                    <input type="text" class="form-control" id="nic" name="nic" value="<%= user.getNic() %>" required>
                </div>

                <div class="mb-3">
                    <label for="address" class="form-label">Address</label>
                    <textarea class="form-control" id="address" name="address" rows="3" required><%= user.getAddress() %></textarea>
                </div>

                <button type="submit" class="btn btn-success">Save Changes</button>
                <button type="button" class="btn btn-secondary" onclick="toggleForm()">Cancel</button>
            </form>
        </div>
    </div>
</div>

<script>
    function toggleForm() {
        const form = document.getElementById('editForm');
        form.classList.toggle('hidden-form');
    }
</script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>

<!-- Include the footer -->
<%@ include file="footer.jsp" %>
</body>
</html>
