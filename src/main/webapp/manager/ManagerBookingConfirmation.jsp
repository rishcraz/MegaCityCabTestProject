<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="model.customer.Booking"%>
<%@ page import="dao.customer.BookingDAO"%>
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
    <title>Confirm Bookings - Manager Dashboard</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/all_css/manager/managebooking.css">
</head>
<body>

<%@ include file="header.jsp" %>

<div class="main-content">
    <div class="container mt-5">
        <h2 class="text-center mb-4">Confirm Bookings</h2>

        <div class="table-responsive">
            <table class="table table-striped table-bordered align-middle text-center">
                <thead class="table-dark">
                    <tr>
                        <th>Order No</th>
                        <th>Customer Name</th>
                        <th>Telephone</th>
                        <th>Pickup Location</th>
                        <th>Destination</th>
                        <th>Date/Time</th>
                        <th>Car Type</th>
                        <th>Status</th>
                        <th>Distance (km)</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        BookingDAO bookingDAO = new BookingDAO();
                        List<Booking> pendingBookings = bookingDAO.getPendingBookings();
                        for (Booking booking : pendingBookings) {
                    %>
                    <tr>
                        <td><%=booking.getOrderNumber()%></td>
                        <td><%=booking.getCustomerName()%></td>
                        <td><%=booking.getTelephone()%></td>
                        <td><%=booking.getPickupLocation()%></td>
                        <td><%=booking.getDestination()%></td>
                        <td><%=booking.getPickupDateTime()%></td>
                        <td><%=booking.getCarType()%></td>
                        <td>
                            <span class="badge bg-warning text-dark"><%=booking.getStatus()%></span>
                        </td>
                        <td><%=booking.getDistance()%>KM</td>
                        <td>
                            <div class="action-buttons">
                                <form action="<%=request.getContextPath()%>/manager/ConfirmBookingServlet" method="POST">
                                    <input type="hidden" name="orderNumber" value="<%=booking.getOrderNumber()%>">
                                    <button type="submit" class="btn btn-success action-btn">Confirm</button>
                                </form>
                                <form action="<%=request.getContextPath()%>/manager/RejectBookingServlet" method="POST">
                                    <input type="hidden" name="orderNumber" value="<%=booking.getOrderNumber()%>">
                                    <button type="submit" class="btn btn-danger action-btn"
                                            onclick="return confirm('Are you sure you want to reject this booking?');">
                                        Reject
                                    </button>
                                </form>
                            </div>
                        </td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        </div>
    </div>
</div>

<%@ include file="footer.jsp" %>

</body>
</html>
