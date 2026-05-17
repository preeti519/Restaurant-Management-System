package com.dineease.controllers;

import com.dineease.model.Reservation;
import com.dineease.service.ReservationService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/admin/reservations")
public class AdminReservationController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private ReservationService reservationService;

    @Override
    public void init() {
        reservationService = new ReservationService();
    }

    // Load reservation page
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setAttribute("reservationList",
                reservationService.getAllReservations());

        request.getRequestDispatcher("/WEB-INF/pages/admin/reservations.jsp")
                .forward(request, response);
    }

    // Handle CRUD operations
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        String action = request.getParameter("action");

        // Add reservation
        if ("add".equals(action)) {

            Reservation reservation = new Reservation();

            reservation.setCustomerName(request.getParameter("customerName"));
            reservation.setPhone(request.getParameter("phone"));
            reservation.setReservationDate(request.getParameter("reservationDate"));
            reservation.setReservationTime(request.getParameter("reservationTime"));
            reservation.setTotalPeople(Integer.parseInt(request.getParameter("totalPeople")));
            reservation.setTableNumber(Integer.parseInt(request.getParameter("tableNumber")));
            reservation.setReservationStatus(request.getParameter("reservationStatus"));

            reservationService.addReservation(reservation);
        }

        // Update reservation
        else if ("update".equals(action)) {

            Reservation reservation = new Reservation();

            reservation.setId(Integer.parseInt(request.getParameter("id")));
            reservation.setCustomerName(request.getParameter("customerName"));
            reservation.setPhone(request.getParameter("phone"));
            reservation.setReservationDate(request.getParameter("reservationDate"));
            reservation.setReservationTime(request.getParameter("reservationTime"));
            reservation.setTotalPeople(Integer.parseInt(request.getParameter("totalPeople")));
            reservation.setTableNumber(Integer.parseInt(request.getParameter("tableNumber")));
            reservation.setReservationStatus(request.getParameter("reservationStatus"));

            reservationService.updateReservation(reservation);
        }

        // Delete reservation
        else if ("delete".equals(action)) {

            int id = Integer.parseInt(request.getParameter("id"));

            reservationService.deleteReservation(id);
        }

        response.sendRedirect(request.getContextPath() + "/admin/reservations");
    }
}