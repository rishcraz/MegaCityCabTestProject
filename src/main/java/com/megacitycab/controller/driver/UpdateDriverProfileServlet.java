package com.megacitycab.controller.driver;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.megacitycab.dao.admin.EmployeeDAO;
import com.megacitycab.model.admin.Employee;

import java.io.IOException;

@WebServlet("/UpdateDriverProfileServlet")
public class UpdateDriverProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String employeeId = request.getParameter("employeeId");
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");

        Employee driver = new Employee();
        driver.setEmployeeID(employeeId);
        driver.setUsername(username);
        driver.setEmail(email);
        driver.setPhone(phone);

        EmployeeDAO employeeDAO = new EmployeeDAO();
        boolean updated = employeeDAO.updateDriverProfile(driver);

        if (updated) {
            response.sendRedirect(request.getContextPath() + "/driver/driverProfile.jsp?success=true");
        } else {
            response.sendRedirect(request.getContextPath() + "/driver/driverProfile.jsp?error=true");
        }
    }
}
