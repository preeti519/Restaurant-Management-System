package com.dineease.controllers;

import com.dineease.model.Reservation;
import com.dineease.service.ReservationService;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;
import java.util.List;

@WebServlet("/user/reservation")
public class UserReservationController extends HttpServlet {

    private ReservationService service = new ReservationService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Reservation> reservationList = service.getAllReservations();
        request.setAttribute("reservationList", reservationList);

        RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/pages/user/userReservation.jsp");
        rd.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String customerName = request.getParameter("customerName");
        String phone = request.getParameter("phone");
        String reservationDate = request.getParameter("reservationDate");
        String reservationTime = request.getParameter("reservationTime");
        int totalPeople = Integer.parseInt(request.getParameter("totalPeople"));
        int tableNumber = Integer.parseInt(request.getParameter("tableNumber"));

        Reservation reservation = new Reservation();
        reservation.setCustomerName(customerName);
        reservation.setPhone(phone);
        reservation.setReservationDate(reservationDate);
        reservation.setReservationTime(reservationTime);
        reservation.setTotalPeople(totalPeople);
        reservation.setTableNumber(tableNumber);
        reservation.setReservationStatus("Pending");

        service.addReservation(reservation);

        response.sendRedirect(request.getContextPath() + "/user/reservation");
    }
}