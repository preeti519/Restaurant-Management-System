package com.dineease.model;

public class UserDashboard {

    private int totalOrders;
    private int totalReservations;
    private int availableMenuItems;
    private int pendingOrders;

    public int getTotalOrders() {
        return totalOrders;
    }

    public void setTotalOrders(int totalOrders) {
        this.totalOrders = totalOrders;
    }

    public int getTotalReservations() {
        return totalReservations;
    }

    public void setTotalReservations(int totalReservations) {
        this.totalReservations = totalReservations;
    }

    public int getAvailableMenuItems() {
        return availableMenuItems;
    }

    public void setAvailableMenuItems(int availableMenuItems) {
        this.availableMenuItems = availableMenuItems;
    }

    public int getPendingOrders() {
        return pendingOrders;
    }

    public void setPendingOrders(int pendingOrders) {
        this.pendingOrders = pendingOrders;
    }
}