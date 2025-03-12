<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>  
<%@ page import="com.megacitycab.dao.customer.BillingDAO,com.megacitycab.model.customer.Billing, java.util.List" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<%
    HttpSession sessionObj = request.getSession(false);
    String managerId = (sessionObj != null) ? (String) sessionObj.getAttribute("managerId") : null;

    if (managerId == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    BillingDAO billingDAO = new BillingDAO();
    List<Billing> pendingBills = billingDAO.getPendingBills(); 
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Confirm Pending Bills - Manager</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/all_css/manager/Confirm.css">
</head>
<body>
<%@ include file="header.jsp" %>

<div class="bill-container">
    <h2 class="text-center">Pending Bills for Approval</h2>

    <% if (pendingBills.isEmpty()) { %>
        <p class="text-center text-danger">No pending bills for approval.</p>
    <% } else { %>
        <div class="grid-layout">
            <% for (Billing bill : pendingBills) { %>
                <div class="bill-tile">
                    <h3>Order #<%= bill.getOrderNumber() %></h3>
                    <p><strong>Customer:</strong> <%= bill.getCustomerName() %></p>
                    <p><strong>Pickup:</strong> <%= bill.getPickupLocation() %></p>
                    <p><strong>Destination:</strong> <%= bill.getDestination() %></p>
                    <p><strong>Total Fare:</strong> $<%= bill.getTotalFare() %></p>
                    <p><strong>Tax:</strong> $<%= bill.getTaxAmount() %></p>
                    <p><strong>Discount:</strong> $<%= bill.getDiscountAmount() %></p>
                    <p><strong>Final Amount:</strong> $<%= bill.getFinalAmount() %></p>
                    <p><strong>Status:</strong> <%= bill.getPaymentStatus() %></p>

                    <form action="ConfirmBillServlet" method="post">
                        <input type="hidden" name="orderNumber" value="<%= bill.getOrderNumber() %>">
                        <button type="submit" class="btn btn-approve">
                            <i class="bi bi-check-circle"></i> Approve
                        </button>
                    </form>
                </div>
            <% } %>
        </div>
    <% } %>

  
</div>

<%@ include file="footer.jsp" %>
</body>
</html>
