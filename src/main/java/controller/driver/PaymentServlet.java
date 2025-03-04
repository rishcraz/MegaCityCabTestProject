package controller.driver;

import dao.customer.BookingDAO;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/PaymentServlet")
public class PaymentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String orderNumber = request.getParameter("orderNumber");
        String driverId = request.getParameter("driverId");
        String paymentMethod = request.getParameter("paymentMethod");

        BookingDAO bookingDAO = new BookingDAO();
        boolean success = bookingDAO.updatePaymentMethod(orderNumber, driverId, paymentMethod);

        if (success) {
            response.sendRedirect(request.getContextPath() + "/driver/driverViewAssignedBooking.jsp?paymentUpdated=true");
        } else {
            response.sendRedirect(request.getContextPath() + "/driver/driverViewAssignedBooking.jsp?paymentUpdated=false");
        }
    }
}
