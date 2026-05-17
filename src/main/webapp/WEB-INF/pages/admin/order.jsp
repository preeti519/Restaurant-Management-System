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
    <title>DineEase | Order Management</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/order.css">
</head>
<body>

<div class="page-container">

    <div class="top-bar">
        <div>
            <h1>Order Management</h1>
            <p>Manage customer orders easily.</p>
        </div>
        <a href="${pageContext.request.contextPath}/admin/dashboard" class="back-btn">Back to Dashboard</a>
    </div>

    <div class="form-card">
        <h2>Add New Order</h2>

        <form action="${pageContext.request.contextPath}/admin/orders" method="post" class="main-form">
            <input type="hidden" name="action" value="add">

            <input type="text" name="customerName" placeholder="Customer Name" required>
            <input type="text" name="itemName" placeholder="Item Name" required>
            <input type="number" name="quantity" placeholder="Quantity" required>
            <input type="number" step="0.01" name="totalPrice" placeholder="Total Price" required>

            <button type="submit" class="add-btn">Add Order</button>
        </form>
    </div>

    <div class="table-card">
        <h2>Order List</h2>

        <table>
            <thead>
            <tr>
                <th>Customer Name</th>
                <th>Item Name</th>
                <th>Quantity</th>
                <th>Total Price</th>
                <th>Action</th>
            </tr>
            </thead>

            <tbody>
            <%
                if (orderList != null && !orderList.isEmpty()) {
                    for (Order order : orderList) {
                        String currentId = String.valueOf(order.getId());
            %>

            <tr>
                <% if (editId != null && editId.equals(currentId)) { %>

                <form action="${pageContext.request.contextPath}/admin/orders" method="post">
                    <input type="hidden" name="action" value="update">
                    <input type="hidden" name="id" value="<%= order.getId() %>">

                    <td><input type="text" name="customerName" value="<%= order.getCustomerName() %>" required></td>
                    <td><input type="text" name="itemName" value="<%= order.getItemName() %>" required></td>
                    <td><input type="number" name="quantity" value="<%= order.getQuantity() %>" required></td>
                    <td><input type="number" step="0.01" name="totalPrice" value="<%= order.getTotalPrice() %>" required></td>

                    <td class="action-box">
                        <button type="submit" class="update-btn">Update</button>
                        <a href="${pageContext.request.contextPath}/admin/orders" class="cancel-btn">Cancel</a>
                    </td>
                </form>

                <% } else { %>

                <td><%= order.getCustomerName() %></td>
                <td><%= order.getItemName() %></td>
                <td><%= order.getQuantity() %></td>
                <td>$<%= order.getTotalPrice() %></td>

                <td class="action-box">
                    <a href="${pageContext.request.contextPath}/admin/orders?editId=<%= order.getId() %>" class="edit-btn">Edit</a>

                    <form action="${pageContext.request.contextPath}/admin/orders" method="post" class="delete-form">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="id" value="<%= order.getId() %>">
                        <button type="submit" class="delete-btn">Delete</button>
                    </form>
                </td>

                <% } %>
            </tr>

            <%
                    }
                } else {
            %>

            <tr>
                <td colspan="5" class="empty-text">No orders found.</td>
            </tr>

            <% } %>
            </tbody>
        </table>
    </div>

</div>

</body>
</html>