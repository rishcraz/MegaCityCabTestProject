package controller.customer;

import dao.customer.BookingDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/customer/CancelBookingServlet")
public class CancelBookingServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private BookingDAO bookingDAO = new BookingDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String orderNumber = request.getParameter("orderNumber");

        boolean success = bookingDAO.cancelBooking(orderNumber);

        if (success) {
            response.sendRedirect(request.getContextPath() + "/customer/viewBookings.jsp?message=Booking canceled successfully!");
        } else {
            response.sendRedirect(request.getContextPath() + "/customer/viewBookings.jsp?error=Failed to cancel booking! Booking may already be completed.");
        }
    }
}
