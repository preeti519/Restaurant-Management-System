package com.dineease.controllers;

import com.dineease.model.UserDashboard;
import com.dineease.service.UserDashboardService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/user/dashboard")
public class UserDashboardController extends HttpServlet {

    private UserDashboardService dashboardService;

    @Override
    public void init() {
        dashboardService = new UserDashboardService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/user/login");
            return;
        }

        UserDashboard dashboard = dashboardService.getDashboardData();

        request.setAttribute("dashboard", dashboard);

        request.getRequestDispatcher("/WEB-INF/pages/user/userDashboard.jsp")
                .forward(request, response);
    }
}