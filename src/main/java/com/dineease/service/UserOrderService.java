package com.dineease.service;

import com.dineease.config.DBConnection;
import com.dineease.model.Order;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class UserOrderService {

    public boolean placeOrder(Order order) {
        String sql = "INSERT INTO orders (customer_name, item_name, quantity, total_price, order_status) VALUES (?, ?, ?, ?, ?)";

        try {
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setString(1, order.getCustomerName());
            ps.setString(2, order.getItemName());
            ps.setInt(3, order.getQuantity());
            ps.setDouble(4, order.getTotalPrice());
            ps.setString(5, "Pending");

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }


    public List<Order> getAllOrders() {
        List<Order> orderList = new ArrayList<>();

        String sql = "SELECT * FROM orders ORDER BY id DESC";

        try {
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Order order = new Order();

                order.setId(rs.getInt("id"));
                order.setCustomerName(rs.getString("customer_name"));
                order.setItemName(rs.getString("item_name"));
                order.setQuantity(rs.getInt("quantity"));
                order.setTotalPrice(rs.getDouble("total_price"));
                order.setOrderStatus(rs.getString("order_status"));

                orderList.add(order);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return orderList;
    }


    public boolean deleteOrder(int id) {
        String sql = "DELETE FROM orders WHERE id = ?";

        try {
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setInt(1, id);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }
}