package controller;

import dao.UserDAO;
import model.User;
import util.UserServiceFactory;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Hardcoded admin credentials
    private static final String ADMIN_EMAIL = "admin@megacitycab.com";
    private static final String ADMIN_PASSWORD = "4321";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        HttpSession session = request.getSession();

        // Check if the hardcoded admin is logging in
        if (ADMIN_EMAIL.equals(email) && ADMIN_PASSWORD.equals(password)) {
            session.setAttribute("adminId", "EMP001"); // Hardcoded admin employee ID
            session.setAttribute("adminName", "Admin User");
            System.out.println("Admin logged in successfully!");

            response.sendRedirect(request.getContextPath() + "/admin/AdminDashboard.jsp");
            return; // Important to stop further processing
        }

        // For non-admin users, continue with database authentication
        UserDAO userDAO = UserServiceFactory.getUserDAO();
        User user = null;

        try {
            user = userDAO.loginUser(email, password);
        } catch (IllegalStateException e) {
            // Account is deactivated
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        if (user != null) {
            session.setAttribute("user", user);

            String role = user.getRole().toLowerCase().trim(); // Normalize role case
            System.out.println("User Role: " + role);

            String redirectURL = request.getContextPath();
            switch (role) {
                case "manager":
                    session.setAttribute("managerId", user.getUserId());
                    redirectURL += "/manager/managerDashboard.jsp";
                    break;
                case "driver":
                    session.setAttribute("driverId", user.getUserId());
                    redirectURL += "/driver/driverDashboard.jsp";
                    break;
                case "customer":
                    session.setAttribute("userId", user.getUserId());
                    redirectURL += "/customer/CustomerDashboard.jsp";
                    break;
                default:
                    request.setAttribute("error", "Unauthorized access!");
                    request.getRequestDispatcher("login.jsp").forward(request, response);
                    return;
            }

            System.out.println("Redirecting to: " + redirectURL);
            response.sendRedirect(redirectURL);
        } else {
            request.setAttribute("error", "Invalid credentials!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
