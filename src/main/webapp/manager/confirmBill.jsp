<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ page import="dao.customer.BillingDAO, model.customer.Billing, java.util.List" %>
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
<html>
<head>
    <meta charset="UTF-8">
    <title>Confirm Pending Bills - Manager</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/all_css/manager/confrim.css">
</head>
<body>
<%@ include file="header.jsp" %>
    <div class="container mt-5">
        <h2 class="text-center">Pending Bills for Approval</h2>

        <%
            BillingDAO billingDAO = new BillingDAO();
            List<Billing> pendingBills = billingDAO.getPendingBills(); 
        %>

        <% if (pendingBills.isEmpty()) { %>
            <p class="text-center text-danger">No pending bills for approval.</p>
        <% } else { %>
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th>Order Number</th>
                        <th>Customer Name</th>
                        <th>Pickup Location</th>
                        <th>Destination</th>
                        <th>Total Fare</th>
                        <th>Tax Amount</th>
                        <th>Discount Amount</th>
                        <th>Final Amount</th>
                        <th>Payment Status</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (Billing bill : pendingBills) { %>
                    <tr>
                        <td><%= bill.getOrderNumber() %></td>
                        <td><%= bill.getCustomerName() %></td>
                        <td><%= bill.getPickupLocation() %></td>
                        <td><%= bill.getDestination() %></td>
                        <td>$<%= bill.getTotalFare() %></td>
                        <td>$<%= bill.getTaxAmount() %></td>
                        <td>$<%= bill.getDiscountAmount() %></td>
                        <td><strong>$<%= bill.getFinalAmount() %></strong></td>
                        <td><%= bill.getPaymentStatus() %></td>
                        <td>
                            <form action="ConfirmBillServlet" method="post">
                                <input type="hidden" name="orderNumber" value="<%= bill.getOrderNumber() %>">
                                <button type="submit" class="btn btn-success">Approve</button>
                            </form>
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        <% } %>

        <div class="text-center mt-3">
            <a href="managerDashboard.jsp" class="btn btn-secondary">Back to Dashboard</a>
        </div>
    </div>
    <%@ include file="footer.jsp" %>
</body>
</html>
