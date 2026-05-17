<%@ page import="java.util.List" %>
<%@ page import="com.dineease.model.Menu" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    List<Menu> menuList = (List<Menu>) request.getAttribute("menuList");
    String editId = request.getParameter("editId");
%>

<!DOCTYPE html>
<html>
<head>
    <title>DineEase | Admin Menu</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/AdminMenu.css?v=1000">
</head>

<body>

<div class="page-wrapper">

    <div class="top-bar">
        <a href="${pageContext.request.contextPath}/admin/dashboard" class="back-btn">← Back to Dashboard</a>
        <h1>Menu Management</h1>
        <p>Add, update, and manage restaurant menu items</p>
    </div>

    <div class="form-card">
        <h2>Add New Menu Item</h2>

        <form action="${pageContext.request.contextPath}/admin/menu" method="post" class="menu-form">
            <input type="hidden" name="action" value="add">

            <input type="text" name="name" placeholder="Food Name" required>

            <select name="category" required>
                <option value="">Select Category</option>
                <option value="Starter">Starter</option>
                <option value="Main Course">Main Course</option>
                <option value="Dessert">Dessert</option>
                <option value="Drink">Drink</option>
            </select>

            <input type="number" step="0.01" name="price" placeholder="Price" required>

            <input type="text" name="description" placeholder="Description" required>

            <input type="text" name="image" placeholder="Image name e.g. burger.jpeg" required>

            <select name="status" required>
                <option value="Available">Available</option>
                <option value="Unavailable">Unavailable</option>
            </select>

            <button type="submit">Add Item</button>
        </form>
    </div>

    <div class="table-card">
        <h2>Menu Items</h2>

        <table>
            <thead>
            <tr>
                <th>ID</th>
                <th>Image</th>
                <th>Food Name</th>
                <th>Category</th>
                <th>Price</th>
                <th>Description</th>
                <th>Status</th>
                <th>Action</th>
            </tr>
            </thead>

            <tbody>
            <%
                if (menuList != null && !menuList.isEmpty()) {
                    for (Menu menu : menuList) {
                        boolean isEditing = editId != null && editId.equals(String.valueOf(menu.getId()));
            %>

            <% if (isEditing) { %>

            <tr>
                <form action="${pageContext.request.contextPath}/admin/menu" method="post">
                    <input type="hidden" name="action" value="update">
                    <input type="hidden" name="id" value="<%= menu.getId() %>">

                    <td><%= menu.getId() %></td>

                    <td>
                        <input class="table-input" type="text" name="image"
                               value="<%= menu.getImage() %>" required>
                    </td>

                    <td>
                        <input class="table-input" type="text" name="name"
                               value="<%= menu.getName() %>" required>
                    </td>

                    <td>
                        <select class="table-input" name="category" required>
                            <option value="Starter" <%= "Starter".equals(menu.getCategory()) ? "selected" : "" %>>Starter</option>
                            <option value="Main Course" <%= "Main Course".equals(menu.getCategory()) ? "selected" : "" %>>Main Course</option>
                            <option value="Dessert" <%= "Dessert".equals(menu.getCategory()) ? "selected" : "" %>>Dessert</option>
                            <option value="Drink" <%= "Drink".equals(menu.getCategory()) ? "selected" : "" %>>Drink</option>
                        </select>
                    </td>

                    <td>
                        <input class="table-input" type="number" step="0.01" name="price"
                               value="<%= menu.getPrice() %>" required>
                    </td>

                    <td>
                        <input class="table-input" type="text" name="description"
                               value="<%= menu.getDescription() %>" required>
                    </td>

                    <td>
                        <select class="table-input" name="status" required>
                            <option value="Available" <%= "Available".equals(menu.getStatus()) ? "selected" : "" %>>Available</option>
                            <option value="Unavailable" <%= "Unavailable".equals(menu.getStatus()) ? "selected" : "" %>>Unavailable</option>
                        </select>
                    </td>

                    <td class="action-cell">
                        <button type="submit" class="update-btn">Update</button>
                        <a href="${pageContext.request.contextPath}/admin/menu" class="cancel-btn">Cancel</a>
                    </td>
                </form>
            </tr>

            <% } else { %>

            <tr>
                <td><%= menu.getId() %></td>

                <td>
                    <img src="${pageContext.request.contextPath}/images/menu/<%= menu.getImage() %>"
                         alt="Food Image"
                         class="food-img">
                </td>

                <td><%= menu.getName() %></td>
                <td><%= menu.getCategory() %></td>
                <td>$<%= menu.getPrice() %></td>
                <td><%= menu.getDescription() %></td>

                <td>
                    <span class="status <%= "Available".equals(menu.getStatus()) ? "available" : "unavailable" %>">
                        <%= menu.getStatus() %>
                    </span>
                </td>

                <td class="action-cell">
                    <a href="${pageContext.request.contextPath}/admin/menu?editId=<%= menu.getId() %>" class="edit-btn">Edit</a>

                    <form action="${pageContext.request.contextPath}/admin/menu" method="post" class="delete-form">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="id" value="<%= menu.getId() %>">
                        <button type="submit" class="delete-btn">Delete</button>
                    </form>
                </td>
            </tr>

            <% } %>

            <%
                    }
                } else {
            %>

            <tr>
                <td colspan="8" class="empty-message">No menu items found.</td>
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