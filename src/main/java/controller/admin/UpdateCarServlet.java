package controller.admin;

import dao.admin.CarDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/admin/UpdateCarServlet")
public class UpdateCarServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String carID = request.getParameter("carID");
        String model = request.getParameter("model");
        String plateNumber = request.getParameter("plateNumber");
        String status = request.getParameter("status");

        CarDAO carDAO = new CarDAO();
        boolean success = carDAO.updateCar(carID, model, plateNumber, status);

        if (success) {
            response.sendRedirect("CarSection.jsp?update=success");
        } else {
            response.sendRedirect("UpdateCar.jsp?id=" + carID + "&error=failed");
        }
    }
}
