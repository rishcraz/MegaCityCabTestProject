<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ page import="com.megacitycab.dao.admin.FareRateDAO,com.megacitycab.model.admin.FareRate, java.util.List" %>
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
    FareRateDAO fareDAO = new FareRateDAO();
    List<FareRate> fareRates = fareDAO.getAllFareRates();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Fare Management</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/all_css/admin/Fare.css">
</head>
<body>
<%@ include file="header.jsp" %>
    <div class="dashboard-container">
        <h1>Fare Management</h1>
        
        <!-- Fare Rate Form -->
        <form action="AddFareRateServlet" method="post" class="form-container">
            <label>Car Type:</label>
            <select name="carType" required>
                <option value="" disabled selected>Select Car Type</option>
                <option value="Sedan">Sedan</option>
                <option value="SUV">SUV</option>
                <option value="Luxury">Luxury</option>
            </select>

            <label>Base Fare:</label>
            <input type="number" step="0.01" name="baseFare" required>

            <label>Per KM Rate:</label>
            <input type="number" step="0.01" name="perKmRate" required>

            <div class="checkbox-container">
                <input type="checkbox" id="multiplierEnabled" name="multiplierEnabled">
                <label for="multiplierEnabled">Enable Vehicle Multiplier</label>
            </div>

            <label>Multiplier Value:</label>
            <input type="number" step="0.1" name="multiplier" value="1.0">

            <div class="checkbox-container">
                <input type="checkbox" id="taxEnabled" name="taxEnabled">
                <label for="taxEnabled">Enable Tax Rate</label>
            </div>

            <label>Tax Rate (%):</label>
            <input type="number" step="0.1" name="taxRate" value="0.0">

            <label>Discount (%):</label>
            <input type="number" step="0.1" name="discount" value="0.0">

            <button type="submit">Add Fare Rate</button>
        </form>

       
    </div>
    <%@ include file="footer.jsp" %>
    
</body>
</html>
