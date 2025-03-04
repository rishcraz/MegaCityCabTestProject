package controller.admin;

import dao.admin.FareRateDAO;
import model.admin.FareRate;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/admin/EditFareRateServlet")
public class EditFareRateServlet extends HttpServlet {
    
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String carType = request.getParameter("carType");
        double baseFare = Double.parseDouble(request.getParameter("baseFare"));
        double perKmRate = Double.parseDouble(request.getParameter("perKmRate"));
        boolean multiplierEnabled = request.getParameter("multiplierEnabled") != null;
        double multiplier = Double.parseDouble(request.getParameter("multiplier"));
        boolean taxEnabled = request.getParameter("taxEnabled") != null;
        double taxRate = Double.parseDouble(request.getParameter("taxRate"));
        double discount = Double.parseDouble(request.getParameter("discount"));

        FareRate fareRate = new FareRate(id, carType, baseFare, perKmRate, multiplierEnabled, multiplier, taxEnabled, taxRate, discount);
        FareRateDAO fareDAO = new FareRateDAO();

        if (fareDAO.updateFareRate(fareRate)) {
            response.sendRedirect("FareRates.jsp");
        } else {
            response.getWriter().write("Error updating fare rate.");
        }
    }
}
