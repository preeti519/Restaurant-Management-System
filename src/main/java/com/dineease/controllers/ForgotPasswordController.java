package com.dineease.controllers;

import com.dineease.service.UserService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet(name = "ForgotPasswordController", urlPatterns = {"/user/forgot-password"})
public class ForgotPasswordController extends HttpServlet {

    private UserService userService;

    @Override
    public void init() {
        userService = new UserService();
    }

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

    	request.getRequestDispatcher("/WEB-INF/pages/user/forgotPassword.jsp")
        .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String newPassword = request.getParameter("newPassword");

        boolean updated = userService.resetPassword(email, newPassword);

        if (updated) {
            request.setAttribute(
                    "success",
                    "Password updated successfully."
            );

            request.getRequestDispatcher(
                    "/WEB-INF/pages/user/userLogin.jsp"
            ).forward(request, response);

        } else {

            request.setAttribute(
                    "error",
                    "Email not found."
            );

            request.getRequestDispatcher(
                    "/WEB-INF/pages/user/forgotPassword.jsp"
            ).forward(request, response);
        }
    }
}