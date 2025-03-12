<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.megacitycab.dao.admin.FareRateDAO,com.megacitycab.model.admin.FareRate" %>
<%@ page session="true" %>
<%
    HttpSession sessionObj = request.getSession(false); // Don't create a new session if none exists
    String managerId = (sessionObj != null) ? (String) sessionObj.getAttribute("managerId") : null;

    if (managerId == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp"); // Redirect to login if not logged in
        return;
    }
%>

<%
    String idParam = request.getParameter("id");
    if (idParam == null || idParam.isEmpty()) {
        response.sendRedirect(request.getContextPath() + "/manager/FareRates.jsp");
        return;
    }

    int id = Integer.parseInt(idParam);
    FareRateDAO fareDAO = new FareRateDAO();
    FareRate fare = fareDAO.getFareRateById(id);
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit Fare Rate</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/all_css/admin/EditFare.css">
</head>
<body>
<%@ include file="header.jsp" %>
    <div class="dashboard-container">
        <h1>Edit Fare Rate</h1>
        <form action="/manager/EditFareRateServlet" method="post" class="form-container">
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

    
    </div>
    <%@ include file="footer.jsp" %>
</body>
</html>
