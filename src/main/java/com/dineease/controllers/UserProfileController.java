package com.dineease.controllers;

import com.dineease.model.User;
import com.dineease.service.UserService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/user/profile")
public class UserProfileController extends HttpServlet {

    private UserService userService;

    @Override
    public void init() {
        userService = new UserService();
    }

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("userId") == null) {

            response.sendRedirect(
                    request.getContextPath() + "/user/login"
            );

            return;
        }

        int userId = (int) session.getAttribute("userId");

        User user = userService.getUserById(userId);

        request.setAttribute("user", user);

        request.getRequestDispatcher(
                "/WEB-INF/pages/user/userProfile.jsp"
        ).forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("userId") == null) {

            response.sendRedirect(
                    request.getContextPath() + "/user/login"
            );

            return;
        }

        int userId = (int) session.getAttribute("userId");

        String fullName = request.getParameter("fullName");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");

        if (fullName == null || fullName.trim().isEmpty()) {

            request.setAttribute(
                    "error",
                    "Full name is required."
            );

            reloadPage(request, response, userId);
            return;
        }

        if (!fullName.matches("^[A-Za-z ]+$")) {

            request.setAttribute(
                    "error",
                    "Full name must contain letters only."
            );

            reloadPage(request, response, userId);
            return;
        }

        if (!phone.matches("^[0-9]{10}$")) {

            request.setAttribute(
                    "error",
                    "Phone number must be exactly 10 digits."
            );

            reloadPage(request, response, userId);
            return;
        }

        User user = new User();

        user.setId(userId);
        user.setFullName(fullName);
        user.setPhone(phone);
        user.setAddress(address);

        boolean updated = userService.updateUserProfile(user);

        if (updated) {

            request.setAttribute(
                    "success",
                    "Profile updated successfully."
            );

        } else {

            request.setAttribute(
                    "error",
                    "Database update failed."
            );
        }

        reloadPage(request, response, userId);
    }

    private void reloadPage(HttpServletRequest request,
                            HttpServletResponse response,
                            int userId)
            throws ServletException, IOException {

        User user = userService.getUserById(userId);

        request.setAttribute("user", user);

        request.getRequestDispatcher(
                "/WEB-INF/pages/user/userProfile.jsp"
        ).forward(request, response);
    }
}