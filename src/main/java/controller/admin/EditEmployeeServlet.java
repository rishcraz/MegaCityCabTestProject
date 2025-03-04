package controller.admin;

import dao.admin.EmployeeDAO;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/admin/EditEmployeeServlet")
public class EditEmployeeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private EmployeeDAO employeeDAO;

    public void init() {
        employeeDAO = new EmployeeDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String employeeId = request.getParameter("employeeId");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        String role = request.getParameter("role");

        boolean isUpdated = employeeDAO.updateEmployee(employeeId, username, password, email, role);

        if (isUpdated) {
            response.sendRedirect("EmployeeSection.jsp?success=Employee updated successfully!");
        } else {
            response.sendRedirect("EditEmployee.jsp?id=" + employeeId + "&error=Update failed. Try again.");
        }
    }
}
