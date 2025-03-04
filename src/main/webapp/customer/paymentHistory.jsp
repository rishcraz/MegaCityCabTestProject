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
    <title>Payment History</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/all_css/customer/PaymentHistory.css">
</head>
<body>

<%@ include file="header.jsp" %>

<div class="container payment-history">
    <h2 class="text-center">Your Payment History</h2>

    <%
        BillingDAO billingDAO = new BillingDAO();
        List<Billing> paymentHistory = billingDAO.getCompletedPayments(); // Fetch all completed payments
    %>

    <% if (paymentHistory.isEmpty()) { %>
        <div class="alert alert-danger text-center mt-4">No completed payments found.</div>
    <% } else { %>
        <div class="table-responsive">
            <table class="table table-hover custom-table">
                <thead>
                    <tr>
                        <th>Order Number</th>
                        <th>Total Fare</th>
                        <th>Tax Amount</th>
                        <th>Discount</th>
                        <th>Final Amount</th>
                        <th>Payment Method</th>
                        <th>Payment Status</th>
                        <th>Paid On</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (Billing bill : paymentHistory) { %>
                    <tr>
                        <td><%= bill.getOrderNumber() %></td>
                        <td>$<%= bill.getTotalFare() %></td>
                        <td>$<%= bill.getTaxAmount() %></td>
                        <td>-$<%= bill.getDiscountAmount() %></td>
                        <td><strong>$<%= bill.getFinalAmount() %></strong></td>
                        <td><%= bill.getPaymentMethod() %></td>
                        <td><span class="badge bg-success"><%= bill.getPaymentStatus() %></span></td>
                        <td><%= bill.getGeneratedAt() %></td>
                        <td>
                            <a href="DownloadBillServlet?orderNumber=<%= bill.getOrderNumber() %>" class="btn btn-download">Download PDF</a>
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    <% } %>

    <div class="text-center mt-4">
        <a href="customerDashboard.jsp" class="btn btn-back">Back to Dashboard</a>
    </div>
</div>

<%@ include file="footer.jsp" %>

</body>
</html>
