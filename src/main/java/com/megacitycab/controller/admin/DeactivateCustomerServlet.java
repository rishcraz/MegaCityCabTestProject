package com.megacitycab.controller.admin;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.megacitycab.dao.UserDAO;

import java.io.IOException;

@WebServlet("/admin/DeactivateCustomerServlet")
public class DeactivateCustomerServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String customerId = request.getParameter("id");
        UserDAO userDAO = new UserDAO();

        if (userDAO.deactivateCustomer(customerId)) {
            response.sendRedirect("ViewAccounts.jsp?message=Customer Deactivated Successfully");
        } else {
            response.sendRedirect("ViewAccounts.jsp?error=Failed to Deactivate Customer");
        }
    }
}
