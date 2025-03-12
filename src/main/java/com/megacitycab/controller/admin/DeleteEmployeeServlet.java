package controller.admin;


import dao.admin.EmployeeDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/admin/DeleteEmployeeServlet")
public class DeleteEmployeeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String employeeId = request.getParameter("id");
        EmployeeDAO employeeDAO = new EmployeeDAO();

        if (employeeDAO.deleteEmployee(employeeId)) {
            response.sendRedirect("EmployeeSection.jsp");
        } else {
            response.getWriter().println("Error deleting employee.");
        }
    }
}
