package com.megacitycab.controller.customer;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.megacitycab.dao.customer.BookingDAO;
import com.megacitycab.model.customer.Booking;

@WebServlet("/customer/BookingServlet")
public class BookingServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private BookingDAO bookingDAO = new BookingDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        String orderNumber = UUID.randomUUID().toString().replaceAll("-", "").substring(0, 8).toUpperCase();
        String customerName = request.getParameter("customerName");
        String address = request.getParameter("address");
        String telephone = request.getParameter("telephone");
        String pickupLocation = request.getParameter("pickupLocation");
        String destination = request.getParameter("destination");
        String pickupDateTimeStr = request.getParameter("pickupDate");
        String carType = request.getParameter("carType");

        
        String distanceStr = request.getParameter("distance").replace(" km", "").trim();
        double distance = Double.parseDouble(distanceStr); 

        
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");
        LocalDateTime pickupDateTime = LocalDateTime.parse(pickupDateTimeStr, formatter);

       
        Booking booking = new Booking(orderNumber, customerName, address, telephone, 
                                      pickupLocation, destination, pickupDateTime, carType, "Pending", distance);

        
        boolean success = bookingDAO.addBooking(booking);

        if (success) {
            response.sendRedirect(request.getContextPath() + "/customer/viewBookings.jsp?message=Booking successful!");
        } else {
            response.sendRedirect(request.getContextPath() + "/customer/booking.jsp?error=Booking failed!");
        }
    }
}
