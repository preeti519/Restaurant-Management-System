package com.dineease.model;

public class Reservation {

    private int id;
    private String customerName;
    private String phone;
    private String reservationDate;
    private String reservationTime;
    private int totalPeople;
    private int tableNumber;
    private String reservationStatus;

    public Reservation() {
    }

    public Reservation(int id, String customerName, String phone,
                       String reservationDate, String reservationTime,
                       int totalPeople, int tableNumber,
                       String reservationStatus) {

        this.id = id;
        this.customerName = customerName;
        this.phone = phone;
        this.reservationDate = reservationDate;
        this.reservationTime = reservationTime;
        this.totalPeople = totalPeople;
        this.tableNumber = tableNumber;
        this.reservationStatus = reservationStatus;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }


    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }


    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }


    public String getReservationDate() {
        return reservationDate;
    }

    public void setReservationDate(String reservationDate) {
        this.reservationDate = reservationDate;
    }


    public String getReservationTime() {
        return reservationTime;
    }

    public void setReservationTime(String reservationTime) {
        this.reservationTime = reservationTime;
    }


    public int getTotalPeople() {
        return totalPeople;
    }

    public void setTotalPeople(int totalPeople) {
        this.totalPeople = totalPeople;
    }


    public int getTableNumber() {
        return tableNumber;
    }

    public void setTableNumber(int tableNumber) {
        this.tableNumber = tableNumber;
    }


    public String getReservationStatus() {
        return reservationStatus;
    }

    public void setReservationStatus(String reservationStatus) {
        this.reservationStatus = reservationStatus;
    }
}