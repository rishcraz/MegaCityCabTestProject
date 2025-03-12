package com.megacitycab.controller.admin;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.megacitycab.dao.customer.InquiryDAO;

import java.io.IOException;

@WebServlet("/admin/SendReplyServlet")
public class SendReplyServlet extends HttpServlet {
   
	private static final long serialVersionUID = 1L;

	@Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int inquiryId = Integer.parseInt(request.getParameter("inquiryId"));
        String reply = request.getParameter("reply");

        InquiryDAO inquiryDAO = new InquiryDAO();
        boolean isReplied = inquiryDAO.sendReply(inquiryId, reply);

        if (isReplied) {
            response.sendRedirect("viewInquiries.jsp?success=1");
        } else {
            response.sendRedirect("replyInquiry.jsp?inquiryId=" + inquiryId + "&error=1");
        }
    }
}
