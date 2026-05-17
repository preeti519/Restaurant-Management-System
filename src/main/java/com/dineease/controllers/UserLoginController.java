package com.dineease.controllers;

import com.dineease.model.User;
import com.dineease.service.UserService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

/**
 * UserLoginController
 *
 * Handles GET  → display the user login page.
 * Handles POST → process login form, track failed attempts,
 *                lock after 3 failures, create session on success.
 */
@WebServlet("/user/login")
public class UserLoginController extends HttpServlet {

    private UserService userService;

    // ── Servlet lifecycle ────────────────────────────────────────────────────

    @Override
    public void init() {
        userService = new UserService();
    }

    // ── GET: show login page ─────────────────────────────────────────────────

    /**
     * If the user is already logged in, redirect straight to the dashboard.
     * Otherwise show the login page.
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession existingSession = request.getSession(false);

        if (existingSession != null && existingSession.getAttribute("user") != null) {
            response.sendRedirect(request.getContextPath() + "/user/dashboard");
            return;
        }

        request.getRequestDispatcher("/WEB-INF/pages/user/userLogin.jsp")
               .forward(request, response);
    }

    // ── POST: process login form ─────────────────────────────────────────────

    /**
     * Full login flow:
     *  1. Validate that email + password fields are not empty.
     *  2. Check session-based lock (active for 60 seconds after 3 failures).
     *  3. Authenticate via UserService.
     *  4. On any failure → increment session attempt counter; lock at 3.
     *  5. On success     → clear counters, create fresh session, redirect.
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email    = request.getParameter("email");
        String password = request.getParameter("password");

        // ── 1. Basic field validation ────────────────────────────────────────
        if (isNullOrEmpty(email) || isNullOrEmpty(password)) {
            forwardWithError(request, response, "Email and password are required.");
            return;
        }

        if (!isValidEmail(email.trim())) {
            forwardWithError(request, response, "Please enter a valid email address.");
            return;
        }

        // ── 2. Session-based attempt / lock tracking ─────────────────────────
        HttpSession session = request.getSession(true);

        Integer attempts = (Integer) session.getAttribute("loginAttempts");
        Long    lockedAt = (Long)    session.getAttribute("loginLockedAt");

        if (attempts == null) attempts = 0;
        if (lockedAt == null) lockedAt = 0L;

        long now = System.currentTimeMillis();

        // Account is currently locked — show countdown
        if (lockedAt > 0 && (now - lockedAt) < 60_000) {
            long secondsLeft = 60 - ((now - lockedAt) / 1000);
            forwardWithError(request, response,
                    "Your account is locked due to 3 failed login attempts. " +
                    "Please try again in " + secondsLeft + " second(s).");
            return;
        }

        // Lock window has expired — reset counters
        if (lockedAt > 0 && (now - lockedAt) >= 60_000) {
            session.setAttribute("loginAttempts", 0);
            session.setAttribute("loginLockedAt", 0L);
            attempts = 0;
            lockedAt = 0L;
        }

        // ── 3. Authenticate ──────────────────────────────────────────────────
        String result = userService.loginUser(email.trim(), password.trim());

        // ── 4. Handle failures ───────────────────────────────────────────────
        if (!result.equals("SUCCESS")) {

            attempts++;
            session.setAttribute("loginAttempts", attempts);

            // Lock the account after 3 failed attempts
            if (attempts >= 3) {
                session.setAttribute("loginLockedAt", System.currentTimeMillis());
                forwardWithError(request, response,
                        "Your account has been locked after 3 failed attempts. " +
                        "Please try again after 1 minute.");
                return;
            }

            // Build a specific but safe error message
            forwardWithError(request, response, buildErrorMessage(result, attempts));
            return;
        }

        // ── 5. Login successful ──────────────────────────────────────────────
        User user = userService.getUserByEmail(email.trim());

        if (user == null) {
            // Edge case: auth passed but user fetch failed
            forwardWithError(request, response,
                    "Something went wrong. Please try again.");
            return;
        }

        // Block inactive accounts
        if ("inactive".equalsIgnoreCase(user.getStatus())) {
            forwardWithError(request, response,
                    "Your account is inactive. Please contact support.");
            return;
        }

        // Clear attempt counters before invalidating session
        session.removeAttribute("loginAttempts");
        session.removeAttribute("loginLockedAt");

        // Invalidate old session → prevents session fixation attacks
        session.invalidate();

        // Create a fresh session and store user data
        HttpSession newSession = request.getSession(true);
        newSession.setAttribute("user",      user);
        newSession.setAttribute("userId",    user.getId());
        newSession.setAttribute("userName",  user.getFullName());
        newSession.setAttribute("userEmail", user.getEmail());
        newSession.setAttribute("role",      user.getRole());
        newSession.setMaxInactiveInterval(30 * 60); // 30-minute idle timeout

        response.sendRedirect(request.getContextPath() + "/user/dashboard");
    }

    // ── Private helpers ──────────────────────────────────────────────────────

    /**
     * Builds a user-facing error message based on the service result code.
     * Intentionally uses a generic "Invalid email or password" phrase for
     * INVALID_EMAIL so that attackers cannot enumerate valid accounts.
     *
     * @param result   result code from UserService.loginUser()
     * @param attempts current failed-attempt count this session
     * @return         error message string
     */
    private String buildErrorMessage(String result, int attempts) {

        String attemptInfo = " (Attempt " + attempts + " of 3"
                + (attempts == 2 ? " — one more will lock your account." : ".)");

        switch (result) {

            case "INVALID_EMAIL":
            case "WRONG_1":
            case "WRONG_2":
                return "Invalid email or password." + attemptInfo;

            case "LOCKED":
                // DB-level lock (from previous session / admin lock)
                return "This account is temporarily locked. Please try again after 1 minute.";

            case "LOCK_NOW":
                // DB just locked on this attempt — session lock covers it,
                // but return a safe message just in case.
                return "Your account has been locked after 3 failed attempts. " +
                       "Please try again after 1 minute.";

            case "INACTIVE":
                return "Your account is inactive. Please contact support.";

            case "ERROR":
                return "A system error occurred. Please try again later.";

            default:
                return "Invalid email or password." + attemptInfo;
        }
    }

    /**
     * Forwards the request to the login page with an error message attribute.
     */
    private void forwardWithError(HttpServletRequest request,
                                   HttpServletResponse response,
                                   String message)
            throws ServletException, IOException {
        request.setAttribute("error", message);
        request.getRequestDispatcher("/WEB-INF/pages/user/userLogin.jsp")
               .forward(request, response);
    }

    /**
     * Returns true if the string is null or contains only whitespace.
     */
    private boolean isNullOrEmpty(String value) {
        return value == null || value.trim().isEmpty();
    }

    /**
     * Simple regex-based email format check.
     * The server always re-validates; this is a quick sanity guard.
     */
    private boolean isValidEmail(String email) {
        return email.matches("^[\\w._%+\\-]+@[\\w.\\-]+\\.[a-zA-Z]{2,}$");
    }
}