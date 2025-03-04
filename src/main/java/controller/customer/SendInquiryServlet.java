package controller.customer;

import dao.customer.InquiryDAO;
import model.customer.Inquiry;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/customer/SendInquiryServlet")
public class SendInquiryServlet extends HttpServlet {
  
	private static final long serialVersionUID = 1L;

	@Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userId = request.getParameter("userId");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String subject = request.getParameter("subject");
        String message = request.getParameter("message");

        Inquiry inquiry = new Inquiry(userId, name, email, subject, message);
        InquiryDAO inquiryDAO = new InquiryDAO();

        boolean isSent = inquiryDAO.saveInquiry(inquiry);

        if (isSent) {
            response.sendRedirect("contactUs.jsp?success=1");
        } else {
            response.sendRedirect("contactUs.jsp?error=1");
        }
    }
}
