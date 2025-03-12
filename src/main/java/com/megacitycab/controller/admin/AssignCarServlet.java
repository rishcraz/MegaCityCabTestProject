package com.megacitycab.controller.admin;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.megacitycab.dao.admin.CarDAO;

import java.io.IOException;

@WebServlet("/AssignCarServlet")
public class AssignCarServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String employeeId = request.getParameter("employeeId");
        String carIdStr = request.getParameter("carId");

        try {
            int carId = Integer.parseInt(carIdStr);
            CarDAO carDAO = new CarDAO();

            boolean success = carDAO.assignCarToEmployee(employeeId, carId);
            if (success) {
                response.sendRedirect(request.getContextPath() + "/admin/adminAssignCar.jsp?assigned=true");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/adminAssignCar.jsp?assigned=false");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/adminAssignCar.jsp?assigned=invalid");
        }
    }
}
