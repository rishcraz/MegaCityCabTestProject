<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ page import="dao.customer.BillingDAO, model.customer.Billing, java.util.List" %>
<%
    HttpSession userSession = request.getSession(false);
    String userId = (userSession != null) ? (String) userSession.getAttribute("userId") : null;

    if (userId == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp"); // Redirect to login if not logged in
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
    <div class="container mt-5">
        <h2 class="text-center">Billing Section</h2>
        
        <form method="post" action="RequestBillServlet">
            <div class="mb-3">
                <label for="orderNumber" class="form-label">Enter Order Number:</label>
                <input type="text" class="form-control" name="orderNumber" required>
            </div>
            <button type="submit" class="btn btn-primary">Request Bill</button>
        </form>

        <% 
            String orderNumber = request.getParameter("orderNumber");
            if (orderNumber != null) {
                BillingDAO billingDAO = new BillingDAO();
                Billing bill = billingDAO.getBillByOrder(orderNumber);
                if (bill != null) {
        %>
            <div class="card mt-4">
                <div class="card-body">
                    <h5 class="card-title">Billing Details</h5>
                    <p><strong>Order Number:</strong> <%= bill.getOrderNumber() %></p>
                    <p><strong>Customer Name:</strong> <%= bill.getCustomerName() %></p>
                    <p><strong>Pickup Location:</strong> <%= bill.getPickupLocation() %></p>
                    <p><strong>Destination:</strong> <%= bill.getDestination() %></p>
                    <p><strong>Total Fare:</strong> $<%= bill.getTotalFare() %></p>
                    <p><strong>Tax Amount:</strong> $<%= bill.getTaxAmount() %></p>
                    <p><strong>Discount:</strong> -$<%= bill.getDiscountAmount() %></p>
                    <p><strong>Final Amount:</strong> <strong>$<%= bill.getFinalAmount() %></strong></p>
                    <p><strong>Status:</strong> <%= bill.getPaymentStatus() %></p>

                    <% if ("Pending Payment".equals(bill.getPaymentStatus())) { %>
                        <form action="ConfirmPaymentServlet" method="post">
                            <input type="hidden" name="orderNumber" value="<%= bill.getOrderNumber() %>">
                            <label>Select Payment Method:</label><br>
                            <input type="radio" name="paymentMethod" value="Cash" required> Cash
                            <input type="radio" name="paymentMethod" value="Card" required> Card
                            <button type="submit" class="btn btn-success mt-2">Make Payment</button>
                        </form>
                    <% } else if ("Paid".equals(bill.getPaymentStatus())) { %>
                        <a href="DownloadBillServlet?orderNumber=<%= bill.getOrderNumber() %>" class="btn btn-info">Download PDF</a>
                    <% } else if ("Awaiting Manager Approval".equals(bill.getPaymentStatus())) { %>
                        <p class="text-danger">Waiting for Manager Approval</p>
                    <% } %>
                </div>
            </div>
        <% } else { %>
            <p class="text-danger mt-3">No bill found for this order number.</p>
        <% } } %>
    </div>
    <%@ include file="footer.jsp" %>
</body>
</html>
