package com.dineease.controllers;

import com.dineease.service.DashboardService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/admin/dashboard")
public class AdminDashboardController extends HttpServlet {

    private DashboardService dashboardService;

    @Override
    public void init() {
        dashboardService = new DashboardService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setAttribute("totalMenuItems", dashboardService.getTotalMenuItems());
        request.setAttribute("totalOrders", dashboardService.getTotalOrders());
        request.setAttribute("totalReservations", dashboardService.getTotalReservations());
        request.setAttribute("totalCustomers", dashboardService.getTotalCustomers());
        request.setAttribute("totalRevenue", dashboardService.getTotalRevenue());

        request.setAttribute("pendingOrders", dashboardService.getPendingOrders());
        request.setAttribute("preparingOrders", dashboardService.getPreparingOrders());
        request.setAttribute("completedOrders", dashboardService.getCompletedOrders());
        request.setAttribute("cancelledOrders", dashboardService.getCancelledOrders());

        request.getRequestDispatcher("/WEB-INF/pages/admin/adminDashboard.jsp")
                .forward(request, response);
    }
}