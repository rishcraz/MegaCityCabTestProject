package controller.driver;

import dao.customer.BookingDAO;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/DriverResponseServlet")
public class DriverResponseServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String orderNumber = request.getParameter("orderNumber");
        String driverId = request.getParameter("driverId");
        String action = request.getParameter("action");

        BookingDAO bookingDAO = new BookingDAO();
        boolean success = false;

        switch (action) {
            case "accept":
                success = bookingDAO.updateDriverResponse(orderNumber, driverId, "Accepted");
                break;
            case "decline":
                success = bookingDAO.updateDriverResponse(orderNumber, driverId, "Declined");
                break;
            case "completed":
                success = bookingDAO.updateDriverResponse(orderNumber, driverId, "Completed");
                break;
            default:
                System.out.println("Invalid action: " + action);
                break;
        }

        if (success) {
            response.sendRedirect(request.getContextPath() + "/driver/driverViewAssignedBooking.jsp?success=true");
        } else {
            response.sendRedirect(request.getContextPath() + "/driver/driverViewAssignedBooking.jsp?error=true");
        }
    }
}
