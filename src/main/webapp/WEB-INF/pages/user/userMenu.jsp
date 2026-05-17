<%@ page import="java.util.List" %>
<%@ page import="com.dineease.model.Menu" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    List<Menu> menuList = (List<Menu>) request.getAttribute("menuList");
%>

<!DOCTYPE html>
<html>
<head>
    <title>DineEase | Menu</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/UserMenu.css?v=3000">
</head>

<body>

<div class="menu-page">

    <div class="menu-header">
        <a href="${pageContext.request.contextPath}/user/dashboard" class="back-btn">
            ← Back to Dashboard
        </a>

        <h1>Our Menu</h1>
        <p>Explore available food items from DineEase</p>

        <input type="text" id="searchInput" placeholder="Search food..." class="search-input">

        <div class="category-buttons">
            <button type="button" onclick="filterMenu('all')">All</button>
            <button type="button" onclick="filterMenu('Starter')">Starter</button>
            <button type="button" onclick="filterMenu('Main Course')">Main Course</button>
            <button type="button" onclick="filterMenu('Dessert')">Dessert</button>
            <button type="button" onclick="filterMenu('Drink')">Drink</button>
        </div>
    </div>

    <div class="menu-grid">

        <%
            if (menuList != null && !menuList.isEmpty()) {
                for (Menu menu : menuList) {
        %>

        <div class="food-card"
             data-name="<%= menu.getName().toLowerCase() %>"
             data-category="<%= menu.getCategory() %>">

            <div class="food-image">
                <img src="${pageContext.request.contextPath}/images/menu/<%= menu.getImage() %>"
                     alt="<%= menu.getName() %>">
            </div>

            <div class="food-content">
                <h2><%= menu.getName() %></h2>

                <span class="category"><%= menu.getCategory() %></span>

                <p><%= menu.getDescription() %></p>

                <div class="food-bottom">
                    <strong>$<%= menu.getPrice() %></strong>

                    <a href="${pageContext.request.contextPath}/user/orders?menuId=<%= menu.getId() %>"
                       class="order-btn">
                        Order Now
                    </a>
                </div>
            </div>

        </div>

        <%
                }
            } else {
        %>

        <p class="empty-text">No menu items available.</p>

        <%
            }
        %>

    </div>

</div>

<script>
    const searchInput = document.getElementById("searchInput");

    searchInput.addEventListener("keyup", function () {
        let value = searchInput.value.toLowerCase();
        let cards = document.querySelectorAll(".food-card");

        cards.forEach(function (card) {
            let name = card.getAttribute("data-name");

            card.style.display = name.includes(value) ? "block" : "none";
        });
    });

    function filterMenu(category) {
        let cards = document.querySelectorAll(".food-card");

        cards.forEach(function (card) {
            let cardCategory = card.getAttribute("data-category");

            card.style.display =
                category === "all" || cardCategory === category ? "block" : "none";
        });
    }
</script>

</body>
</html>