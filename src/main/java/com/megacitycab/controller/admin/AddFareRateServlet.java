package com.megacitycab.controller.admin;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.megacitycab.dao.admin.FareRateDAO;
import com.megacitycab.model.admin.FareRate;

@WebServlet("/admin/AddFareRateServlet")
public class AddFareRateServlet extends HttpServlet {
    
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String carType = request.getParameter("carType");
        double baseFare = Double.parseDouble(request.getParameter("baseFare"));
        double perKmRate = Double.parseDouble(request.getParameter("perKmRate"));
        boolean multiplierEnabled = request.getParameter("multiplierEnabled") != null;
        double multiplier = Double.parseDouble(request.getParameter("multiplier"));
        boolean taxEnabled = request.getParameter("taxEnabled") != null;
        double taxRate = Double.parseDouble(request.getParameter("taxRate"));
        double discount = Double.parseDouble(request.getParameter("discount"));

        FareRate fareRate = new FareRate(0, carType, baseFare, perKmRate, multiplierEnabled, multiplier, taxEnabled, taxRate, discount);
        FareRateDAO fareDAO = new FareRateDAO();
        
        if (fareDAO.addFareRate(fareRate)) {
            response.sendRedirect("FareRates.jsp");
        } else {
            response.getWriter().write("Error adding fare rate.");
        }
    }
}
