package com.dineease.controllers;

import com.dineease.config.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 * Controller for handling user registration.
 * Validates input, checks for duplicate email, and inserts new user into DB.
 */
@WebServlet("/user/register")
public class UserRegisterController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/pages/user/userRegister.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String fullName = request.getParameter("fullName");
        String email    = request.getParameter("email");
        String password = request.getParameter("password");

        // ── 1. Empty field check ──────────────────────────────────
        if (fullName == null || fullName.trim().isEmpty() ||
            email    == null || email.trim().isEmpty()    ||
            password == null || password.trim().isEmpty()) {

            request.setAttribute("error", "All fields are required.");
            request.getRequestDispatcher("/WEB-INF/pages/user/userRegister.jsp")
                    .forward(request, response);
            return;
        }

        // ── 2. Full name: letters and spaces only ─────────────────
        if (!fullName.trim().matches("[a-zA-Z ]+")) {
            request.setAttribute("error", "Full name must contain letters only — no numbers or special characters.");
            request.getRequestDispatcher("/WEB-INF/pages/user/userRegister.jsp")
                    .forward(request, response);
            return;
        }

        // ── 3. Password length check ──────────────────────────────
        if (password.trim().length() < 6) {
            request.setAttribute("error", "Password must be at least 6 characters long.");
            request.getRequestDispatcher("/WEB-INF/pages/user/userRegister.jsp")
                    .forward(request, response);
            return;
        }

        // ── 4. Single connection for both check and insert ────────
        try (Connection conn = DBConnection.getConnection()) {

            // Duplicate email check
            String checkSql = "SELECT id FROM users WHERE email = ?";
            try (PreparedStatement checkPst = conn.prepareStatement(checkSql)) {
                checkPst.setString(1, email.trim());
                ResultSet rs = checkPst.executeQuery();
                if (rs.next()) {
                    request.setAttribute("error", "An account with this email already exists. Please login.");
                    request.getRequestDispatcher("/WEB-INF/pages/user/userRegister.jsp")
                            .forward(request, response);
                    return;
                }
            }

            // Insert new user
            String insertSql = "INSERT INTO users (full_name, email, password, role, status, failed_attempts) " +
                               "VALUES (?, ?, ?, 'user', 'active', 0)";
            try (PreparedStatement pst = conn.prepareStatement(insertSql)) {
                pst.setString(1, fullName.trim());
                pst.setString(2, email.trim());
                pst.setString(3, password.trim());
                int result = pst.executeUpdate();

                if (result > 0) {
                    response.sendRedirect(request.getContextPath() + "/user/login");
                } else {
                    request.setAttribute("error", "Registration failed. Please try again.");
                    request.getRequestDispatcher("/WEB-INF/pages/user/userRegister.jsp")
                            .forward(request, response);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/pages/user/userRegister.jsp")
                    .forward(request, response);
        }
    }
}