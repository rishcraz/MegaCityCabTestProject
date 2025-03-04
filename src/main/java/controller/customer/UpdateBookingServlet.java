package controller.customer;

import dao.customer.BookingDAO;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/customer/UpdateBookingServlet")
public class UpdateBookingServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private BookingDAO bookingDAO = new BookingDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String orderNumber = request.getParameter("orderNumber");
        String pickupLocation = request.getParameter("pickupLocation");
        String destination = request.getParameter("destination");
        String pickupDateTimeStr = request.getParameter("pickupDate");
        String carType = request.getParameter("carType");

        
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");
        LocalDateTime pickupDateTime = LocalDateTime.parse(pickupDateTimeStr, formatter);

       
        boolean success = bookingDAO.updateBooking(orderNumber, pickupLocation, destination, pickupDateTime, carType);

        if (success) {
            response.sendRedirect(request.getContextPath() + "/customer/viewBookings.jsp?message=Booking updated successfully!");
        } else {
            response.sendRedirect(request.getContextPath() + "/customer/EditBooking.jsp?orderNumber=" + orderNumber + "&error=Update failed!");
        }
    }
}
