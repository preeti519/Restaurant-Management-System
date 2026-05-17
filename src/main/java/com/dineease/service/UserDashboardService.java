package com.dineease.service;

import com.dineease.config.DBConnection;
import com.dineease.model.UserDashboard;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDashboardService {

    public UserDashboard getDashboardData() {
        UserDashboard dashboard = new UserDashboard();

        dashboard.setTotalOrders(getCount("SELECT COUNT(*) FROM orders"));
        dashboard.setTotalReservations(getCount("SELECT COUNT(*) FROM reservations"));
        dashboard.setAvailableMenuItems(getCount("SELECT COUNT(*) FROM menu_items"));
        dashboard.setPendingOrders(getCount("SELECT COUNT(*) FROM orders WHERE order_status = 'Pending'"));

        return dashboard;
    }

    private int getCount(String sql) {
        int count = 0;

        try {
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                count = rs.getInt(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return count;
    }
}