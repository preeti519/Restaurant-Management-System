package com.dineease.service;

import com.dineease.config.DBConnection;
import com.dineease.model.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class CustomerService {

    public List<User> getAllCustomers() {
        List<User> customers = new ArrayList<>();

        String sql = "SELECT id, full_name, email, phone, address, role FROM users WHERE role = 'user'";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                User user = new User();

                user.setId(rs.getInt("id"));
                user.setFullName(rs.getString("full_name"));
                user.setEmail(rs.getString("email"));
                user.setPhone(rs.getString("phone"));
                user.setAddress(rs.getString("address"));
                user.setRole(rs.getString("role"));

                customers.add(user);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return customers;
    }

    public List<User> searchCustomers(String keyword) {
        List<User> customers = new ArrayList<>();

        String sql = "SELECT id, full_name, email, phone, address, role FROM users " +
                     "WHERE role = 'user' AND (full_name LIKE ? OR email LIKE ? OR phone LIKE ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            String searchValue = "%" + keyword + "%";

            ps.setString(1, searchValue);
            ps.setString(2, searchValue);
            ps.setString(3, searchValue);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                User user = new User();

                user.setId(rs.getInt("id"));
                user.setFullName(rs.getString("full_name"));
                user.setEmail(rs.getString("email"));
                user.setPhone(rs.getString("phone"));
                user.setAddress(rs.getString("address"));
                user.setRole(rs.getString("role"));

                customers.add(user);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return customers;
    }
}