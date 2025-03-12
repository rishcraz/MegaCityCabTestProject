package com.megacitycab.controller.customer;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.megacitycab.dao.UserDAO;
import com.megacitycab.model.User;

import java.io.IOException;

@WebServlet("/customer/UpdateProfileServlet")
public class UpdateProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        User loggedInUser = (User) session.getAttribute("user");

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String nic = request.getParameter("nic");
        String address = request.getParameter("address");

        UserDAO userDAO = new UserDAO();
        User user = new User();
        user.setUserId(loggedInUser.getUserId());
        user.setName(name);
        user.setEmail(email);
        user.setPhone(phone);
        user.setNic(nic);
        user.setAddress(address);

        boolean isUpdated = userDAO.updateCustomerProfile(user);

        if (isUpdated) {
            session.setAttribute("user", user);
            response.sendRedirect("customerProfile.jsp?success=1");
        } else {
            response.sendRedirect("customerProfile.jsp?error=1");
        }
    }
}
