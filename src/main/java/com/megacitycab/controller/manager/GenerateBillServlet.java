package controller.manager;

import dao.customer.BillingDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/manager/GenerateBillServlet")
public class GenerateBillServlet extends HttpServlet {
  
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String orderNumber = request.getParameter("orderNumber");
        int fareId = Integer.parseInt(request.getParameter("fareId"));

        BillingDAO billingDAO = new BillingDAO();
        boolean success = billingDAO.generateBill(orderNumber, fareId);

        if (success) {
            response.sendRedirect("generateBill.jsp?message=Bill Generated Successfully");
        } else {
            response.sendRedirect("generateBill.jsp?error=Failed to Generate Bill");
        }
    }
}
