package com.dineease.service;

import com.dineease.config.DBConnection;
import com.dineease.model.Reservation;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ReservationService {

    // Fetch all reservations
    public List<Reservation> getAllReservations() {

        List<Reservation> reservationList = new ArrayList<>();

        String sql = "SELECT * FROM reservations ORDER BY id DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {

                Reservation reservation = new Reservation();

                reservation.setId(rs.getInt("id"));
                reservation.setCustomerName(rs.getString("customer_name"));
                reservation.setPhone(rs.getString("phone"));
                reservation.setReservationDate(rs.getString("reservation_date"));
                reservation.setReservationTime(rs.getString("reservation_time"));
                reservation.setTotalPeople(rs.getInt("total_people"));
                reservation.setTableNumber(rs.getInt("table_number"));
                reservation.setReservationStatus(rs.getString("reservation_status"));

                reservationList.add(reservation);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return reservationList;
    }

    // Add reservation
    public void addReservation(Reservation reservation) {

        String sql = "INSERT INTO reservations (customer_name, phone, reservation_date, reservation_time, total_people, table_number, reservation_status) VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, reservation.getCustomerName());
            ps.setString(2, reservation.getPhone());
            ps.setString(3, reservation.getReservationDate());
            ps.setString(4, reservation.getReservationTime());
            ps.setInt(5, reservation.getTotalPeople());
            ps.setInt(6, reservation.getTableNumber());
            ps.setString(7, reservation.getReservationStatus());

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Update reservation
    public void updateReservation(Reservation reservation) {

        String sql = "UPDATE reservations SET customer_name=?, phone=?, reservation_date=?, reservation_time=?, total_people=?, table_number=?, reservation_status=? WHERE id=?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, reservation.getCustomerName());
            ps.setString(2, reservation.getPhone());
            ps.setString(3, reservation.getReservationDate());
            ps.setString(4, reservation.getReservationTime());
            ps.setInt(5, reservation.getTotalPeople());
            ps.setInt(6, reservation.getTableNumber());
            ps.setString(7, reservation.getReservationStatus());
            ps.setInt(8, reservation.getId());

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Delete reservation
    public void deleteReservation(int id) {

        String sql = "DELETE FROM reservations WHERE id=?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}