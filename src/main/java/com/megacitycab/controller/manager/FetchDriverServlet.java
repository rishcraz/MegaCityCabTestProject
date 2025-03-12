package com.megacitycab.controller.manager;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import com.google.gson.Gson;
import com.megacitycab.dao.admin.EmployeeDAO;
import com.megacitycab.model.admin.Employee;

@WebServlet("/manager/FetchDriverServlet")
public class FetchDriverServlet extends HttpServlet {
    
	private static final long serialVersionUID = 1L;

	@Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String driverId = request.getParameter("driverId");
        EmployeeDAO employeeDAO = new EmployeeDAO();
        Employee driver = employeeDAO.getDriverById(driverId);

        response.setContentType("application/json");
        response.getWriter().write(new Gson().toJson(driver));
    }
}
