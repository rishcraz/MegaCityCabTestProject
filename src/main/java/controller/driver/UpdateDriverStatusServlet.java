package controller.driver;

import dao.admin.EmployeeDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/UpdateDriverStatusServlet")
public class UpdateDriverStatusServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String driverId = request.getParameter("driverId");
        String status = request.getParameter("status");

        if (driverId == null || status == null || driverId.isEmpty() || status.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/driver/driverViewAssignedBooking.jsp?error=InvalidInput");
            return;
        }

        EmployeeDAO employeeDAO = new EmployeeDAO();
        boolean updateSuccess = employeeDAO.updateDriverStatus(driverId, status);

        if (updateSuccess) {
            response.sendRedirect(request.getContextPath() + "/driver/driverViewAssignedBooking.jsp?statusUpdated=true");
        } else {
            response.sendRedirect(request.getContextPath() + "/driver/driverViewAssignedBooking.jsp?statusUpdated=false");
        }
    }
}
