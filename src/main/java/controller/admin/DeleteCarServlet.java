package controller.admin;

import dao.admin.CarDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/admin/DeleteCarServlet")
public class DeleteCarServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String carID = request.getParameter("id");
        CarDAO carDAO = new CarDAO();
        carDAO.deleteCar(carID);
        response.sendRedirect("CarSection.jsp");
    }
}
