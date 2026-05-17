package com.dineease.service;

import com.dineease.config.DBConnection;
import com.dineease.model.User;

import java.sql.*;

/**
 * Service layer for user-related business logic.
 * Handles authentication, account locking, profile management.
 */
public class UserService {

    private static final int    MAX_FAILED_ATTEMPTS  = 3;
    private static final String LOCK_DURATION_SQL    = "DATE_ADD(NOW(), INTERVAL 1 MINUTE)";

    // ── Authentication ───────────────────────────────────────────────────────

    /**
     * Authenticates a user with the given email and password.
     *
     * @return Result codes:
     *   SUCCESS        – credentials correct, login allowed
     *   INVALID_EMAIL  – no user found with this email
     *   WRONG_N        – wrong password; N = current failed attempt count (1 or 2)
     *   LOCK_NOW       – account just locked after 3rd failed attempt
     *   LOCKED         – account already locked (lock_until is in the future)
     *   INACTIVE       – account status is not active
     *   ERROR          – unexpected database or system error
     */
    public String loginUser(String email, String password) {
        String sql = "SELECT * FROM users WHERE email = ? AND LOWER(role) = 'user'";
        Timestamp now = new Timestamp(System.currentTimeMillis());

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, email.trim());
            ResultSet rs = ps.executeQuery();

            // No user found with this email
            if (!rs.next()) {
                return "INVALID_EMAIL";
            }

            String    dbPassword    = rs.getString("password");
            String    status        = rs.getString("status");
            int       failedAttempts = rs.getInt("failed_attempts");
            Timestamp lockUntil     = rs.getTimestamp("lock_until");

            // Check if account is inactive
            if (status != null && status.equalsIgnoreCase("inactive")) {
                return "INACTIVE";
            }

            // Account is currently locked
            if (lockUntil != null && lockUntil.after(now)) {
                return "LOCKED";
            }

            // Lock has expired — clear it before continuing
            if (lockUntil != null && lockUntil.before(now)) {
                resetFailedAttempts(email);
                failedAttempts = 0;
            }

            // Password check (plain-text comparison; upgrade to BCrypt when possible)
            if (dbPassword == null || !dbPassword.equals(password.trim())) {
                failedAttempts++;

                if (failedAttempts >= MAX_FAILED_ATTEMPTS) {
                    lockUser(email);
                    return "LOCK_NOW";
                }

                updateFailedAttempts(email, failedAttempts);
                return "WRONG_" + failedAttempts;
            }

            // Credentials correct
            resetFailedAttempts(email);
            return "SUCCESS";

        } catch (Exception e) {
            e.printStackTrace();
            return "ERROR";
        }
    }

    // ── User retrieval ───────────────────────────────────────────────────────

    /**
     * Finds a regular user by their email address.
     *
     * @return User object, or null if not found.
     */
    public User getUserByEmail(String email) {
        String sql = "SELECT * FROM users WHERE email = ? AND LOWER(role) = 'user'";
        return querySingleUser(sql, stmt -> stmt.setString(1, email.trim()));
    }

    /**
     * Finds any user by their primary key ID.
     *
     * @return User object, or null if not found.
     */
    public User getUserById(int userId) {
        String sql = "SELECT * FROM users WHERE id = ?";
        return querySingleUser(sql, stmt -> stmt.setInt(1, userId));
    }

    // ── Profile update ───────────────────────────────────────────────────────

    /**
     * Updates a user's mutable profile fields (name, phone, address).
     *
     * @return true if the update affected at least one row, false otherwise.
     */
    public boolean updateUserProfile(User user) {
        String sql = "UPDATE users SET full_name = ?, phone = ?, address = ? WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, user.getFullName());
            ps.setString(2, user.getPhone());
            ps.setString(3, user.getAddress());
            ps.setInt(4, user.getId());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // ── Private helpers ──────────────────────────────────────────────────────

    /**
     * Updates the failed-attempt counter for a user.
     */
    private void updateFailedAttempts(String email, int attempts) {
        String sql = "UPDATE users SET failed_attempts = ? " +
                     "WHERE email = ? AND LOWER(role) = 'user'";
        executeUpdate(sql, ps -> {
            ps.setInt(1, attempts);
            ps.setString(2, email.trim());
        });
    }

    /**
     * Locks a user account for 1 minute and sets failed_attempts to max.
     */
    private void lockUser(String email) {
        String sql = "UPDATE users SET failed_attempts = " + MAX_FAILED_ATTEMPTS +
                     ", lock_until = " + LOCK_DURATION_SQL +
                     " WHERE email = ? AND LOWER(role) = 'user'";
        executeUpdate(sql, ps -> ps.setString(1, email.trim()));
    }

    /**
     * Clears failed_attempts and removes any lock from the user's account.
     */
    private void resetFailedAttempts(String email) {
        String sql = "UPDATE users SET failed_attempts = 0, lock_until = NULL " +
                     "WHERE email = ? AND LOWER(role) = 'user'";
        executeUpdate(sql, ps -> ps.setString(1, email.trim()));
    }

    /**
     * Generic helper: run a single-row SELECT and map the result to a User.
     */
    private User querySingleUser(String sql, PreparedStatementSetter setter) {
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            setter.set(ps);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return mapUser(rs);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Generic helper: run a DML statement with a lambda for parameter binding.
     */
    private void executeUpdate(String sql, PreparedStatementSetter setter) {
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            setter.set(ps);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * Maps a ResultSet row to a User model object.
     */
    private User mapUser(ResultSet rs) throws SQLException {
        User user = new User();
        user.setId(rs.getInt("id"));
        user.setFullName(rs.getString("full_name"));
        user.setEmail(rs.getString("email"));
        user.setPhone(rs.getString("phone"));
        user.setAddress(rs.getString("address"));
        user.setRole(rs.getString("role"));
        user.setStatus(rs.getString("status"));
        user.setFailedAttempts(rs.getInt("failed_attempts"));
        user.setLockUntil(rs.getTimestamp("lock_until"));
        return user;
    }

    // ── Functional interface for lambda-based PreparedStatement binding ──────

    @FunctionalInterface
    private interface PreparedStatementSetter {
        void set(PreparedStatement ps) throws SQLException;
    }
    public boolean resetPassword(String email, String newPassword) {

        String sql =
                "UPDATE users SET password = ? WHERE email = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, newPassword);
            ps.setString(2, email);

            int rows = ps.executeUpdate();

            return rows > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }
}