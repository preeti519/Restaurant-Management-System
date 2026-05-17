<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.dineease.model.UserDashboard" %>

<%
    UserDashboard dashboard = (UserDashboard) request.getAttribute("dashboard");
%>

<!DOCTYPE html>
<html>
<head>
    <title>DineEase | User Dashboard</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/userDashboard.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
</head>
<body>

<div class="dashboard-container">

    <div class="topbar">
        <div class="brand">
            <i class="fa-solid fa-utensils"></i>
            <h2>DineEase</h2>
        </div>

        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/user/dashboard" class="active">Dashboard</a>
            <a href="${pageContext.request.contextPath}/user/menu">Menu</a>
            <a href="${pageContext.request.contextPath}/user/orders">Orders</a>
            <a href="${pageContext.request.contextPath}/user/reservation">Reservations</a>
            <a href="${pageContext.request.contextPath}/user/profile">Profile</a>
            <a href="${pageContext.request.contextPath}/logout" class="logout">Logout</a>
        </div>
    </div>

    <section class="hero">
        <div class="hero-content">
            <p class="small-title">Welcome to DineEase</p>
            <h1>Order food, book tables, and manage everything easily.</h1>
            <p>
                DineEase gives users a simple way to view menu items, place food orders,
                reserve tables, and track their restaurant activities in real time.
            </p>

            <div class="hero-buttons">
                <a href="${pageContext.request.contextPath}/user/menu" class="btn btn-light">
                    <i class="fa-solid fa-burger"></i> View Menu
                </a>

                <a href="${pageContext.request.contextPath}/user/orders" class="btn btn-outline">
                    <i class="fa-solid fa-cart-shopping"></i> Order Food
                </a>
            </div>
        </div>

        <div class="hero-box">
            <i class="fa-solid fa-bowl-food"></i>
            <h3>Fresh Food</h3>
            <p>Fast ordering, simple booking, and smooth service.</p>
        </div>
    </section>

    <section class="stats-section">

        <div class="stat-card">
            <i class="fa-solid fa-receipt"></i>
            <h3><%= dashboard != null ? dashboard.getTotalOrders() : 0 %></h3>
            <p>Total Orders</p>
        </div>

        <div class="stat-card">
            <i class="fa-solid fa-calendar-check"></i>
            <h3><%= dashboard != null ? dashboard.getTotalReservations() : 0 %></h3>
            <p>Total Reservations</p>
        </div>

        <div class="stat-card">
            <i class="fa-solid fa-burger"></i>
            <h3><%= dashboard != null ? dashboard.getAvailableMenuItems() : 0 %></h3>
            <p>Menu Items</p>
        </div>

        <div class="stat-card">
            <i class="fa-solid fa-clock"></i>
            <h3><%= dashboard != null ? dashboard.getPendingOrders() : 0 %></h3>
            <p>Pending Orders</p>
        </div>

    </section>

    <section class="features-section">
        <h2>User Features</h2>

        <div class="feature-grid">

            <a href="${pageContext.request.contextPath}/user/menu" class="feature-card">
                <i class="fa-solid fa-magnifying-glass"></i>
                <h3>Search Menu</h3>
                <p>View available food items and search menu details.</p>
            </a>

            <a href="${pageContext.request.contextPath}/user/orders" class="feature-card">
                <i class="fa-solid fa-cart-shopping"></i>
                <h3>Order Food</h3>
                <p>Place food orders and view your order status.</p>
            </a>

            <a href="${pageContext.request.contextPath}/user/reservation" class="feature-card">
                <i class="fa-solid fa-calendar-days"></i>
                <h3>Book Table</h3>
                <p>Reserve a table and check reservation status.</p>
            </a>

            <a href="${pageContext.request.contextPath}/user/profile" class="feature-card">
                <i class="fa-solid fa-user-gear"></i>
                <h3>Manage Profile</h3>
                <p>Update your personal and account details.</p>
            </a>
            <a href="${pageContext.request.contextPath}/user/menu"
   class="dashboard-card">

    
</a>
<a href="${pageContext.request.contextPath}/user/about" class="feature-card">
    <h3>About DineEase</h3>
    <p>Learn more about the restaurant system.</p>
</a>
<a href="${pageContext.request.contextPath}/user/contact"
   class="feature-card">

    <h3>Contact Us</h3>

    <p>Get in touch with DineEase support team.</p>

</a>
        </div>
    </section>

</div>

</body>
</html>