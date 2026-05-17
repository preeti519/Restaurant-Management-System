<%@ page import="java.util.List" %>
<%@ page import="com.dineease.model.Reservation" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    List<Reservation> reservationList =
            (List<Reservation>) request.getAttribute("reservationList");

    String editId = request.getParameter("editId");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">

    <title>DineEase | Reservation Management</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/reservation.css">
</head>

<body>

<div class="page-container">

    <!-- TOP BAR -->
    <div class="top-bar">

        <div>
            <h1>Reservation Management</h1>
            <p>Manage restaurant reservations easily.</p>
        </div>

        <a href="${pageContext.request.contextPath}/admin/dashboard"
           class="back-btn">
            Back to Dashboard
        </a>

    </div>

    <!-- ADD FORM -->
    <div class="form-card">

        <h2>Add New Reservation</h2>

        <form action="${pageContext.request.contextPath}/admin/reservations"
              method="post"
              class="main-form">

            <input type="hidden"
                   name="action"
                   value="add">

            <input type="text"
                   name="customerName"
                   placeholder="Customer Name"
                   required>

            <input type="text"
                   name="phone"
                   placeholder="Phone Number"
                   required>

            <input type="date"
                   name="reservationDate"
                   required>

            <input type="time"
                   name="reservationTime"
                   required>

            <input type="number"
                   name="totalPeople"
                   placeholder="Total People"
                   required>

            <input type="number"
                   name="tableNumber"
                   placeholder="Table Number"
                   required>

            <input type="text"
                   name="reservationStatus"
                   placeholder="Reservation Status"
                   required>

            <button type="submit"
                    class="add-btn">
                Add Reservation
            </button>

        </form>

    </div>

    <!-- TABLE -->
    <div class="table-card">

        <h2>Reservation List</h2>

        <table>

            <thead>
            <tr>
                <th>Customer Name</th>
                <th>Phone</th>
                <th>Date</th>
                <th>Time</th>
                <th>Total People</th>
                <th>Table No</th>
                <th>Status</th>
                <th>Action</th>
            </tr>
            </thead>

            <tbody>

            <%
                if (reservationList != null &&
                        !reservationList.isEmpty()) {

                    for (Reservation reservation : reservationList) {

                        String currentId =
                                String.valueOf(reservation.getId());
            %>

            <tr>

                <%
                    if (editId != null &&
                            editId.equals(currentId)) {
                %>

                <!-- EDIT MODE -->

                <form action="${pageContext.request.contextPath}/admin/reservations"
                      method="post">

                    <input type="hidden"
                           name="action"
                           value="update">

                    <input type="hidden"
                           name="id"
                           value="<%= reservation.getId() %>">

                    <td>
                        <input type="text"
                               name="customerName"
                               value="<%= reservation.getCustomerName() %>"
                               required>
                    </td>

                    <td>
                        <input type="text"
                               name="phone"
                               value="<%= reservation.getPhone() %>"
                               required>
                    </td>

                    <td>
                        <input type="date"
                               name="reservationDate"
                               value="<%= reservation.getReservationDate() %>"
                               required>
                    </td>

                    <td>
                        <input type="time"
                               name="reservationTime"
                               value="<%= reservation.getReservationTime() %>"
                               required>
                    </td>

                    <td>
                        <input type="number"
                               name="totalPeople"
                               value="<%= reservation.getTotalPeople() %>"
                               required>
                    </td>

                    <td>
                        <input type="number"
                               name="tableNumber"
                               value="<%= reservation.getTableNumber() %>"
                               required>
                    </td>

                    <td>
                        <input type="text"
                               name="reservationStatus"
                               value="<%= reservation.getReservationStatus() %>"
                               required>
                    </td>

                    <td class="action-box">

                        <button type="submit"
                                class="update-btn">
                            Update
                        </button>

                        <a href="${pageContext.request.contextPath}/admin/reservations"
                           class="cancel-btn">
                            Cancel
                        </a>

                    </td>

                </form>

                <%
                    } else {
                %>

                <!-- NORMAL VIEW -->

                <td><%= reservation.getCustomerName() %></td>

                <td><%= reservation.getPhone() %></td>

                <td><%= reservation.getReservationDate() %></td>

                <td><%= reservation.getReservationTime() %></td>

                <td><%= reservation.getTotalPeople() %></td>

                <td><%= reservation.getTableNumber() %></td>

                <td><%= reservation.getReservationStatus() %></td>

                <td class="action-box">

                    <a href="${pageContext.request.contextPath}/admin/reservations?editId=<%= reservation.getId() %>"
                       class="edit-btn">
                        Edit
                    </a>

                    <form action="${pageContext.request.contextPath}/admin/reservations"
                          method="post"
                          class="delete-form">

                        <input type="hidden"
                               name="action"
                               value="delete">

                        <input type="hidden"
                               name="id"
                               value="<%= reservation.getId() %>">

                        <button type="submit"
                                class="delete-btn">
                            Delete
                        </button>

                    </form>

                </td>

                <%
                    }
                %>

            </tr>

            <%
                    }
                } else {
            %>

            <tr>
                <td colspan="8"
                    class="empty-text">
                    No reservations found.
                </td>
            </tr>

            <%
                }
            %>

            </tbody>

        </table>

    </div>

</div>

</body>
</html>