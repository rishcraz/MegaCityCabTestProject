package controller.customer;

import dao.customer.BillingDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/customer/ConfirmPaymentServlet")
public class ConfirmPaymentServlet extends HttpServlet {
    
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String orderNumber = request.getParameter("orderNumber");
        String paymentMethod = request.getParameter("paymentMethod");

        BillingDAO billingDAO = new BillingDAO();
        boolean success = billingDAO.updatePaymentStatus(orderNumber, paymentMethod);

        if (success) {
            response.sendRedirect("billing.jsp?orderNumber=" + orderNumber + "&message=Payment Successful");
        } else {
            response.sendRedirect("billing.jsp?error=Payment Failed");
        }
    }
}
