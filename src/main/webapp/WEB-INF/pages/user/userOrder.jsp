<%@ page import="java.util.List" %>
<%@ page import="com.dineease.model.Order" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    List<Order> orderList = (List<Order>) request.getAttribute("orderList");
    String editId = request.getParameter("editId");
%>

<!DOCTYPE html>
<html>
<head>
    <title>DineEase | User Orders</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/UserOrder.css">
</head>

<body>

<div class="page-container">

    <!-- HEADER -->
    <div class="header">

        <a href="${pageContext.request.contextPath}/user/dashboard"
           class="dashboard-btn">
            ← Back to Dashboard
        </a>

        <div class="title-section">
            <h1>User Order Management</h1>
            <p>Place orders, manage food items and track order status.</p>
        </div>

    </div>

    <!-- ORDER FORM -->
    <div class="card">

        <h2>Place New Order</h2>

        <form action="${pageContext.request.contextPath}/user/orders"
              method="post"
              class="order-form">

            <input type="hidden" name="action" value="add">

            <div class="input-group">
                <label>Customer Name</label>
                <input type="text"
                       name="customerName"
                       placeholder="Enter customer name"
                       required>
            </div>

            <div class="input-group">
                <label>Item Name</label>
                <input type="text"
                       name="itemName"
                       placeholder="Enter food item"
                       required>
            </div>

            <div class="input-group">
                <label>Quantity</label>
                <input type="number"
                       name="quantity"
                       placeholder="Quantity"
                       required>
            </div>

            <div class="input-group">
                <label>Total Price</label>
                <input type="number"
                       step="0.01"
                       name="totalPrice"
                       placeholder="Total price"
                       required>
            </div>

            <div class="form-button">
                <button type="submit">
                    Place Order
                </button>
            </div>

        </form>

    </div>

    <!-- TABLE -->
    <div class="card">

        <h2>Order List</h2>

        <table>

            <thead>
            <tr>
                <th>ID</th>
                <th>Customer</th>
                <th>Item</th>
                <th>Quantity</th>
                <th>Total Price</th>
                <th>Status</th>
                <th>Actions</th>
            </tr>
            </thead>

            <tbody>

            <%
                if (orderList != null && !orderList.isEmpty()) {

                    for (Order order : orderList) {

                        boolean isEditing =
                                editId != null &&
                                editId.equals(String.valueOf(order.getId()));
            %>

            <tr>

                <%
                    if (isEditing) {
                %>

                <form action="${pageContext.request.contextPath}/user/orders"
                      method="post">

                    <input type="hidden" name="action" value="update">
                    <input type="hidden" name="id"
                           value="<%= order.getId() %>">

                    <td><%= order.getId() %></td>

                    <td>
                        <input type="text"
                               name="customerName"
                               value="<%= order.getCustomerName() %>"
                               class="edit-input">
                    </td>

                    <td>
                        <input type="text"
                               name="itemName"
                               value="<%= order.getItemName() %>"
                               class="edit-input">
                    </td>

                    <td>
                        <input type="number"
                               name="quantity"
                               value="<%= order.getQuantity() %>"
                               class="edit-input">
                    </td>

                    <td>
                        <input type="number"
                               step="0.01"
                               name="totalPrice"
                               value="<%= order.getTotalPrice() %>"
                               class="edit-input">
                    </td>

                    <td>

                        <select name="orderStatus"
                                class="status-select">

                            <option value="Pending"
                                    <%= order.getOrderStatus().equals("Pending") ? "selected" : "" %>>
                                Pending
                            </option>

                            <option value="Completed"
                                    <%= order.getOrderStatus().equals("Completed") ? "selected" : "" %>>
                                Completed
                            </option>

                            <option value="Cancelled"
                                    <%= order.getOrderStatus().equals("Cancelled") ? "selected" : "" %>>
                                Cancelled
                            </option>

                        </select>

                    </td>

                    <td class="action-buttons">

                        <button type="submit"
                                class="update-btn">
                            Update
                        </button>

                        <a href="${pageContext.request.contextPath}/user/orders"
                           class="cancel-btn">
                            Cancel
                        </a>

                    </td>

                </form>

                <%
                } else {
                %>

                <td><%= order.getId() %></td>
                <td><%= order.getCustomerName() %></td>
                <td><%= order.getItemName() %></td>
                <td><%= order.getQuantity() %></td>
                <td>$<%= order.getTotalPrice() %></td>

                <td>
                        <span class="status <%= order.getOrderStatus() %>">
                            <%= order.getOrderStatus() %>
                        </span>
                </td>

                <td class="action-buttons">

                    <a href="${pageContext.request.contextPath}/user/orders?editId=<%= order.getId() %>"
                       class="edit-btn">
                        Edit
                    </a>

                    <form action="${pageContext.request.contextPath}/user/orders"
                          method="post"
                          class="delete-form">

                        <input type="hidden"
                               name="action"
                               value="delete">

                        <input type="hidden"
                               name="id"
                               value="<%= order.getId() %>">

                        <button type="submit"
                                class="delete-btn">
                            Delete
                        </button>

                    </form>

                </td>

                <%
                        }
                    }
                } else {
                %>

                <tr>
                    <td colspan="7" class="empty-message">
                        No orders available.
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