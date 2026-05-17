package com.dineease.service;

import com.dineease.config.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class DashboardService {

    private int getCount(String sql) {
        int count = 0;

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                count = rs.getInt(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return count;
    }

    public int getTotalMenuItems() {
        return getCount("SELECT COUNT(*) FROM menu");
    }

    public int getTotalOrders() {
        return getCount("SELECT COUNT(*) FROM orders");
    }

    public int getTotalReservations() {
        return getCount("SELECT COUNT(*) FROM reservations");
    }

    public int getTotalCustomers() {
        return getCount("SELECT COUNT(*) FROM users WHERE role = 'USER'");
    }

    public double getTotalRevenue() {
        double revenue = 0;

        String sql = "SELECT COALESCE(SUM(total_price), 0) FROM orders WHERE order_status = 'Completed'";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                revenue = rs.getDouble(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return revenue;
    }

    public int getPendingOrders() {
        return getCount("SELECT COUNT(*) FROM orders WHERE order_status = 'Pending'");
    }

    public int getPreparingOrders() {
        return getCount("SELECT COUNT(*) FROM orders WHERE order_status = 'Preparing'");
    }

    public int getCompletedOrders() {
        return getCount("SELECT COUNT(*) FROM orders WHERE order_status = 'Completed'");
    }

    public int getCancelledOrders() {
        return getCount("SELECT COUNT(*) FROM orders WHERE order_status = 'Cancelled'");
    }
}