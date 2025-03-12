package controller.admin;

import dao.admin.SystemSettingsDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/admin/UpdateSystemSettingsServlet")
public class UpdateSystemSettingsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            double baseFare = Double.parseDouble(request.getParameter("baseFare"));
            double perKmRate = Double.parseDouble(request.getParameter("perKmRate"));
            double sedanMultiplier = Double.parseDouble(request.getParameter("sedanMultiplier"));
            double suvMultiplier = Double.parseDouble(request.getParameter("suvMultiplier"));
            double luxuryMultiplier = Double.parseDouble(request.getParameter("luxuryMultiplier"));
            double taxRate = Double.parseDouble(request.getParameter("taxRate"));
            double discountRate = Double.parseDouble(request.getParameter("discountRate"));

            SystemSettingsDAO settingsDAO = new SystemSettingsDAO();
            settingsDAO.updateSettings(baseFare, perKmRate, sedanMultiplier, suvMultiplier, luxuryMultiplier, taxRate, discountRate);

            response.sendRedirect("SystemSettings.jsp?success=1");
        } catch (Exception e) {
            response.sendRedirect("SystemSettings.jsp?error=1");
        }
    }
}
