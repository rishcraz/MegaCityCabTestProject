<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.customer.BillingDAO, model.customer.Billing" %>
<%
    HttpSession userSession = request.getSession(false);
    String userId = (userSession != null) ? (String) userSession.getAttribute("userId") : null;

    if (userId == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Customer Billing</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/all_css/customer/bill.css">
</head>
<body>
<%@ include file="header.jsp" %>

<div class="billing-container">
    <h2>Billing Section</h2>

    <div class="input-section">
        <form method="post" action="RequestBillServlet">
            <label for="orderNumber">Enter Order Number:</label>
            <input type="text" id="orderNumber" name="orderNumber" placeholder="Order Number" required>
            <button type="submit">Request Bill</button>
        </form>
    </div>

    <%
        String orderNumber = request.getParameter("orderNumber");
        if (orderNumber != null) {
            BillingDAO billingDAO = new BillingDAO();
            Billing bill = billingDAO.getBillByOrder(orderNumber);
            if (bill != null) {
    %>
    <div class="billing-details">
        <h3>Billing Details</h3>
        <ul>
            <li><strong>Order Number:</strong> <%= bill.getOrderNumber() %></li>
            <li><strong>Customer Name:</strong> <%= bill.getCustomerName() %></li>
            <li><strong>Pickup Location:</strong> <%= bill.getPickupLocation() %></li>
            <li><strong>Destination:</strong> <%= bill.getDestination() %></li>
            <li><strong>Total Fare:</strong> Rs <%= bill.getTotalFare() %></li>
            <li><strong>Tax Amount:</strong> Rs <%= bill.getTaxAmount() %></li>
            <li><strong>Discount:</strong> -Rs <%= bill.getDiscountAmount() %></li>
            <li><strong>Final Amount:</strong> Rs <%= bill.getFinalAmount() %></li>
            <li><strong>Status:</strong> <%= bill.getPaymentStatus() %></li>
        </ul>

        <% if ("Pending Payment".equals(bill.getPaymentStatus())) { %>
        <div class="payment-section">
            <form action="ConfirmPaymentServlet" method="post">
                <input type="hidden" name="orderNumber" value="<%= bill.getOrderNumber() %>">
                <label>Select Payment Method:</label>
                <label><input type="radio" name="paymentMethod" value="Cash" required> Cash</label>
                <label><input type="radio" name="paymentMethod" value="Card" required> Card</label>
                <button type="submit">Make Payment</button>
            </form>
        </div>
        <% } else if ("Paid".equals(bill.getPaymentStatus())) { %>
        <a href="DownloadBillServlet?orderNumber=<%= bill.getOrderNumber() %>" class="download-btn">Download PDF</a>
        <% } else if ("Awaiting Manager Approval".equals(bill.getPaymentStatus())) { %>
        <p class="waiting-approval">Waiting for Manager Approval</p>
        <% } %>
    </div>
    <% } else { %>
    <p class="error-message">No bill found for this order number.</p>
    <% } } %>
</div>

<%@ include file="footer.jsp" %>
</body>
</html>
