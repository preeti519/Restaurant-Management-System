package com.dineease.controllers;

import java.io.IOException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/admin-login")
public class AdminLoginController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Opens admin login page
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher("/WEB-INF/pages/admin/adminLogin.jsp")
               .forward(request, response);
    }

    // Checks admin login details
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Temporary admin login details
        if ("admin@dineease.com".equals(email) && "admin123".equals(password)) {

            request.getSession().setAttribute("admin", email);

            response.sendRedirect(request.getContextPath() + "/admin/dashboard");

        } else {

            request.setAttribute("error", "Invalid admin email or password.");

            RequestDispatcher dispatcher =
                    request.getRequestDispatcher("/WEB-INF/pages/admin/adminLogin.jsp");

            dispatcher.forward(request, response);
        }
    }
}