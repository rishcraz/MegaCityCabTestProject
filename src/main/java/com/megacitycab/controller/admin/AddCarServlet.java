package com.megacitycab.controller.admin;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.megacitycab.dao.admin.CarDAO;

@WebServlet("/admin/AddCarServlet")
public class AddCarServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String model = request.getParameter("model");
        String plateNumber = request.getParameter("plateNumber");
        String status = request.getParameter("status");

        CarDAO carDAO = new CarDAO();
        carDAO.addCar(model, plateNumber, status);
        response.sendRedirect("CarSection.jsp");
    }
}
