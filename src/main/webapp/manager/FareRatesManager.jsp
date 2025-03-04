<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, model.admin.FareRate, dao.admin.FareRateDAO" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<%
    HttpSession sessionObj = request.getSession(false); // Don't create a new session if none exists
    String managerId = (sessionObj != null) ? (String) sessionObj.getAttribute("managerId") : null;

    if (managerId == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp"); // Redirect to login if not logged in
        return;
    }
%>




<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Fare Rates</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/all_css/manager/fareRates.css">
</head>
<body>

<%@ include file="header.jsp" %>

<div class="main-content">
    <div class="container">
        <h2 class="text-center">Fare Rates</h2>

        <table class="table table-bordered table-hover mt-4">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Car Type</th>
                    <th>Base Fare</th>
                    <th>Per Km Rate</th>
                    <th>Multiplier</th>
                    <th>Tax Rate</th>
                    <th>Discount</th>
                </tr>
            </thead>
            <tbody>
                <%
                    FareRateDAO fareRateDAO = new FareRateDAO();
                    List<FareRate> fareRates = fareRateDAO.getAllFareRates();
                    for (FareRate fareRate : fareRates) {
                %>
                <tr>
                    <td data-label="ID"><%= fareRate.getId() %></td>
                    <td data-label="Car Type"><%= fareRate.getCarType() %></td>
                    <td data-label="Base Fare">$<%= fareRate.getBaseFare() %></td>
                    <td data-label="Per Km Rate">$<%= fareRate.getPerKmRate() %></td>
                    <td data-label="Multiplier">x<%= fareRate.getMultiplier() %></td>
                    <td data-label="Tax Rate"><%= fareRate.getTaxRate() %>%</td>
                    <td data-label="Discount"><%= fareRate.getDiscount() %>%</td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>
</div>

<%@ include file="footer.jsp" %>

</body>
</html>
