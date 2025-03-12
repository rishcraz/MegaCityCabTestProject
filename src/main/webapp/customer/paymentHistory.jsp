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
    <h2 class="text-center">Payment History</h2>

    <%
        BillingDAO billingDAO = new BillingDAO();
        List<Billing> paymentHistory = billingDAO.getCompletedPayments(); // Fetch all completed payments
    %>

    <% if (paymentHistory.isEmpty()) { %>
        <div class="alert alert-danger text-center mt-4">No completed payments found.</div>
    <% } else { %>
        <div class="row">
            <% for (Billing bill : paymentHistory) { %>
                <div class="col-lg-4 col-md-6 mb-4">
                    <div class="card payment-card shadow">
                        <div class="card-body">
                            <h5 class="card-title text-primary">Order #<%= bill.getOrderNumber() %></h5>
                            <p class="card-text"><strong>Total Fare:</strong> Rs <%= bill.getTotalFare() %></p>
                            <p class="card-text"><strong>Tax Amount:</strong> Rs <%= bill.getTaxAmount() %></p>
                            <p class="card-text"><strong>Discount:</strong> -Rs <%= bill.getDiscountAmount() %></p>
                            <p class="card-text"><strong>Final Amount:</strong> Rs <%= bill.getFinalAmount() %></p>
                            <p class="card-text"><strong>Payment Method:</strong> <%= bill.getPaymentMethod() %></p>
                            <p class="card-text">
                                <span class="badge bg-success"><%= bill.getPaymentStatus() %></span>
                            </p>
                            <p class="card-text"><strong>Paid On:</strong> <%= bill.getGeneratedAt() %></p>
                            <a href="DownloadBillServlet?orderNumber=<%= bill.getOrderNumber() %>" class="btn btn-download">Download PDF</a>
                        </div>
                    </div>
                </div>
            <% } %>
        </div>
    <% } %>

    
</div>

<%@ include file="footer.jsp" %>

</body>
</html>
