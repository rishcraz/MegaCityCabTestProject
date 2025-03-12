<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ page import="dao.customer.BookingDAO" %>
<%@ page import="model.customer.Booking" %>
<%@ page import="java.util.List" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
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
    <title>Edit Booking</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/all_css/customer/EditBooking.css">
</head>
<body class="bg-light text-dark">
<%@ include file="header.jsp" %>
    <div class="container mt-5">
        <div class="card shadow-lg p-4 bg-white text-dark">
            <h2 class="mb-4 text-center text-black">Edit Booking</h2>
            <%
                String orderNumber = request.getParameter("orderNumber");
                BookingDAO bookingDAO = new BookingDAO();
                Booking booking = bookingDAO.getBookingByOrderNumber(orderNumber);
            %>
           <form action="<%= request.getContextPath() %>/customer/UpdateBookingServlet" method="POST">
                <input type="hidden" name="orderNumber" value="<%= booking.getOrderNumber() %>">

                <div class="mb-3">
                    <label class="form-label">Pickup Location:</label>
                    <input type="text" name="pickupLocation" class="form-control" value="<%= booking.getPickupLocation() %>" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Destination:</label>
                    <input type="text" name="destination" class="form-control" value="<%= booking.getDestination() %>" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Date/Time:</label>
                    <input type="datetime-local" name="pickupDate" class="form-control"
                           value="<%= booking.getPickupDateTime().format(DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm")) %>" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Car Type:</label>
                    <select name="carType" class="form-select" required>
                        <option value="Hatchback" <% if(booking.getCarType().equals("Hatchback")) out.print("selected"); %>>Hatchback</option>
                        <option value="Luxury" <% if(booking.getCarType().equals("Luxury")) out.print("selected"); %>>Luxury</option>
                        <option value="SUV" <% if(booking.getCarType().equals("SUV")) out.print("selected"); %>>SUV</option>
                    </select>
                </div>

                <div class="d-grid">
                    <button type="submit" class="btn btn-primary">Update</button>
                </div>
            </form>

          
        </div>
    </div>
    <%@ include file="footer.jsp" %>
</body>
</html>
