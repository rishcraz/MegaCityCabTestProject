<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.admin.FareRateDAO, model.admin.FareRate" %>
<%@ page session="true" %>
<%
    // Check if admin session exists
    String adminId = (String) session.getAttribute("adminId");

    if (adminId == null) {
        // If admin session is missing, redirect to login page
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
%>

<%
    int id = Integer.parseInt(request.getParameter("id"));
    FareRateDAO fareDAO = new FareRateDAO();
    FareRate fare = fareDAO.getFareRateById(id);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit Fare Rate</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/all_css/admin/Fare.css">
</head>
<body>
    <div class="dashboard-container">
        <h1>Edit Fare Rate</h1>
        <form action="/admin/EditFareRateServlet" method="post" class="form-container">
            <input type="hidden" name="id" value="<%= fare.getId() %>">

            <label>Car Type:</label>
            <input type="text" name="carType" value="<%= fare.getCarType() %>" required>

            <label>Base Fare:</label>
            <input type="number" name="baseFare" value="<%= fare.getBaseFare() %>" required>

            <label>Per KM Rate:</label>
            <input type="number" name="perKmRate" value="<%= fare.getPerKmRate() %>" required>

            <label>Multiplier Enabled:</label>
            <input type="checkbox" name="multiplierEnabled" <%= fare.isMultiplierEnabled() ? "checked" : "" %>>

            <label>Multiplier Value:</label>
            <input type="number" name="multiplier" value="<%= fare.getMultiplier() %>">

            <label>Tax Enabled:</label>
            <input type="checkbox" name="taxEnabled" <%= fare.isTaxEnabled() ? "checked" : "" %>>

            <label>Tax Rate:</label>
            <input type="number" name="taxRate" value="<%= fare.getTaxRate() %>">

            <label>Discount:</label>
            <input type="number" name="discount" value="<%= fare.getDiscount() %>">

            <button type="submit" class="btn">Update Fare</button>
        </form>

        <!-- Go Back Button -->
        <div class="button-container">
            <a href="FareRates.jsp" class="go-back-btn">Go Back</a>
        </div>
    </div>
</body>
</html>
