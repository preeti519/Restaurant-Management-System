<%@ page import="java.util.List" %>
<%@ page import="com.dineease.model.Reservation" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    List<Reservation> reservationList = (List<Reservation>) request.getAttribute("reservationList");
%>

<!DOCTYPE html>
<html>
<head>
    <title>DineEase | Book Table</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/userReservation.css">
</head>
<body>

<div class="page-wrapper">

    <div class="top-bar">
        <div>
            <h1>Book Your Table</h1>
            <p>Reserve your table easily and check your booking status.</p>
        </div>

        <a href="${pageContext.request.contextPath}/user/dashboard" class="back-btn">
            Back to Dashboard
        </a>
    </div>

    <div class="reservation-container">

        <div class="form-card">
            <h2>New Reservation</h2>

            <form action="${pageContext.request.contextPath}/user/reservation" method="post">

                <label>Customer Name</label>
                <input type="text" name="customerName" placeholder="Enter your name" required>

                <label>Phone Number</label>
                <input type="text" name="phone" placeholder="Enter phone number" required>

                <label>Reservation Date</label>
                <input type="date" name="reservationDate" required>

                <label>Reservation Time</label>
                <input type="time" name="reservationTime" required>

                <label>Total People</label>
                <input type="number" name="totalPeople" min="1" placeholder="Example: 4" required>

                <label>Table Number</label>
                <input type="number" name="tableNumber" min="1" placeholder="Example: 2" required>

                <button type="submit">Book Table</button>
            </form>
        </div>

        <div class="table-card">
            <h2>Your Reservations</h2>

            <table>
                <thead>
                <tr>
                    <th>Name</th>
                    <th>Phone</th>
                    <th>Date</th>
                    <th>Time</th>
                    <th>People</th>
                    <th>Table</th>
                    <th>Status</th>
                </tr>
                </thead>

                <tbody>
                <%
                    if (reservationList != null && !reservationList.isEmpty()) {
                        for (Reservation r : reservationList) {
                %>
                <tr>
                    <td><%= r.getCustomerName() %></td>
                    <td><%= r.getPhone() %></td>
                    <td><%= r.getReservationDate() %></td>
                    <td><%= r.getReservationTime() %></td>
                    <td><%= r.getTotalPeople() %></td>
                    <td><%= r.getTableNumber() %></td>
                    <td>
                        <span class="status"><%= r.getReservationStatus() %></span>
                    </td>
                </tr>
                <%
                        }
                    } else {
                %>
                <tr>
                    <td colspan="7" class="empty">No reservations found.</td>
                </tr>
                <%
                    }
                %>
                </tbody>
            </table>
        </div>

    </div>

</div>

</body>
</html>