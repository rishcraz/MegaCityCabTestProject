package controller.customer;

import dao.customer.BookingDAO;
import model.customer.Booking;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@WebServlet("/customer/EditBookingServlet")
public class EditBookingServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private BookingDAO bookingDAO = new BookingDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String orderNumber = request.getParameter("orderNumber");
        String customerName = request.getParameter("customerName");
        String address = request.getParameter("address");
        String telephone = request.getParameter("telephone");
        String pickupLocation = request.getParameter("pickupLocation");
        String destination = request.getParameter("destination");
        String pickupDateTimeStr = request.getParameter("pickupDateTime");
        String carType = request.getParameter("carType");

        LocalDateTime pickupDateTime = LocalDateTime.parse(pickupDateTimeStr, DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm"));

        // Create updated booking object
        Booking updatedBooking = new Booking(orderNumber, customerName, address, telephone,
                pickupLocation, destination, pickupDateTime, carType, "Pending", 0.0);

        // Update in database
        boolean success = bookingDAO.addBooking(updatedBooking);

        if (success) {
            response.sendRedirect("ViewBookings.jsp?message=Booking updated successfully");
        } else {
            response.sendRedirect("EditBooking.jsp?orderNumber=" + orderNumber + "&error=Update failed!");
        }
    }
}
