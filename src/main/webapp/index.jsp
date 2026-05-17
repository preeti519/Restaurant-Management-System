<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>DineEase | Restaurant Management</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/index.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
</head>

<body>

<header class="navbar">
    <div class="logo">
        <i class="fa-solid fa-utensils"></i>
        <span>DineEase</span>
    </div>

    <nav>
        <a href="#features">Features</a>
        <a href="#about">About</a>
    </nav>
</header>

<section class="hero">
    <div class="hero-text">
        <p class="tagline">Smart Restaurant Management System</p>

        <h1>Manage your restaurant with comfort, speed, and style.</h1>

        <p class="description">
            DineEase helps restaurants manage orders, reservations, menus,
            customers, and reports from one simple and professional platform.
        </p>

        <div class="hero-buttons">
            <a href="${pageContext.request.contextPath}/admin-login" class="primary-btn">
                <i class="fa-solid fa-user-shield"></i> Admin Login
            </a>

            <a href="${pageContext.request.contextPath}/user/login" class="secondary-btn">
                <i class="fa-solid fa-user"></i> User Login
            </a>
        </div>

        <div class="trust-row">
            <div>⚡ Fast Orders</div>
            <div>🪑 Table Booking</div>
            <div>🔒 Secure Access</div>
        </div>
    </div>

    <div class="hero-visual">
        <div class="visual-box large">
            <p>Orders Today</p>
            <h2>84</h2>
            <span>+7 new orders this hour</span>
        </div>

        <div class="visual-row">
            <div class="visual-box">
                <p>Tables</p>
                <h3>12 / 20</h3>
                <span>Available</span>
            </div>

            <div class="visual-box">
                <p>Rating</p>
                <h3>4.8 ★</h3>
                <span>Excellent</span>
            </div>
        </div>

        <div class="visual-highlight">
            <p><strong>Top Dish:</strong> Chicken Biryani</p>
            <p><strong>Status:</strong> Kitchen running smoothly</p>
        </div>
    </div>
</section>

<section id="features" class="features">
    <h2>System Features</h2>
    <p class="section-subtitle">Everything needed to run a modern restaurant system.</p>

    <div class="feature-grid">
        <div class="feature-box">
            <i class="fa-solid fa-receipt"></i>
            <h3>Order Management</h3>
            <p>Track and manage customer orders easily.</p>
        </div>

        <div class="feature-box">
            <i class="fa-solid fa-calendar-check"></i>
            <h3>Reservations</h3>
            <p>Manage bookings and table availability.</p>
        </div>

        <div class="feature-box">
            <i class="fa-solid fa-bowl-food"></i>
            <h3>Menu Control</h3>
            <p>Admin can manage food items and pricing.</p>
        </div>

        <div class="feature-box">
            <i class="fa-solid fa-chart-line"></i>
            <h3>Reports</h3>
            <p>View revenue, performance, and restaurant insights.</p>
        </div>
    </div>
</section>

<section id="about" class="about">
    <div class="about-card">
        <h2>Why DineEase?</h2>
        <p>
            DineEase is designed to make restaurant work easier, faster, and more organized.
            It gives separate access for admin and users, which improves security and creates
            a smooth workflow for daily restaurant activities.
        </p>
    </div>
</section>

<footer>
    <p>© 2026 DineEase. All rights reserved.</p>
</footer>

</body>
</html>