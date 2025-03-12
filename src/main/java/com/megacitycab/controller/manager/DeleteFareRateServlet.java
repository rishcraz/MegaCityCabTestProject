package com.megacitycab.controller.manager;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.megacitycab.dao.admin.FareRateDAO;

@WebServlet("/manager/DeleteFareRateServlet")
public class DeleteFareRateServlet extends HttpServlet {
    
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        FareRateDAO fareDAO = new FareRateDAO();

        if (fareDAO.deleteFareRate(id)) {
            response.sendRedirect("FareRates.jsp");
        } else {
            response.getWriter().write("Error deleting fare rate.");
        }
    }
}
