package com.dineease.service;

import com.dineease.config.DBConnection;
import com.dineease.model.Menu;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MenuService {

    public List<Menu> getAllMenuItems() {
        List<Menu> menuList = new ArrayList<>();

        String sql = "SELECT * FROM menu_items ORDER BY id DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Menu menu = new Menu();

                menu.setId(rs.getInt("id"));
                menu.setName(rs.getString("food_name"));
                menu.setCategory(rs.getString("category"));
                menu.setPrice(rs.getDouble("price"));
                menu.setDescription(rs.getString("description"));
                menu.setStatus(rs.getString("status"));
                menu.setImage(rs.getString("image"));

                menuList.add(menu);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return menuList;
    }

    public boolean addMenuItem(Menu menu) {
        String sql = "INSERT INTO menu_items (food_name, category, price, description, status, image) VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, menu.getName());
            ps.setString(2, menu.getCategory());
            ps.setDouble(3, menu.getPrice());
            ps.setString(4, menu.getDescription());
            ps.setString(5, menu.getStatus());
            ps.setString(6, menu.getImage());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    public boolean updateMenuItem(Menu menu) {
        String sql = "UPDATE menu_items SET food_name=?, category=?, price=?, description=?, status=?, image=? WHERE id=?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, menu.getName());
            ps.setString(2, menu.getCategory());
            ps.setDouble(3, menu.getPrice());
            ps.setString(4, menu.getDescription());
            ps.setString(5, menu.getStatus());
            ps.setString(6, menu.getImage());
            ps.setInt(7, menu.getId());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    public boolean deleteMenuItem(int id) {
        String sql = "DELETE FROM menu_items WHERE id=?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }
    public List<Menu> getAvailableMenuItems() {

        List<Menu> menuList = new ArrayList<>();

        String sql = "SELECT * FROM menu_items WHERE status='Available' ORDER BY id DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {

                Menu menu = new Menu();

                menu.setId(rs.getInt("id"));
                menu.setName(rs.getString("food_name"));
                menu.setCategory(rs.getString("category"));
                menu.setPrice(rs.getDouble("price"));
                menu.setDescription(rs.getString("description"));
                menu.setStatus(rs.getString("status"));
                menu.setImage(rs.getString("image"));

                menuList.add(menu);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return menuList;
    }
}