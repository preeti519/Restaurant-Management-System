<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Login | DineEase</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/adminLogin.css">

    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
</head>

<body>

<div class="auth-page">

    <div class="auth-left">
        <div class="brand">
            <i class="fa-solid fa-utensils"></i>
            <span>DineEase</span>
        </div>

        <h1>Welcome Back, Admin</h1>

        <p>
            Manage restaurant orders, reservations, menu items, reports,
            and customer activities from one secure dashboard.
        </p>

        <div class="info-box">
            <i class="fa-solid fa-shield-halved"></i>
            <div>
                <h3>Secure Admin Access</h3>
                <p>Only authorized admin users can access management features.</p>
            </div>
        </div>
    </div>

    <div class="auth-card">
        <div class="card-icon">
            <i class="fa-solid fa-user-shield"></i>
        </div>

        <h2>Admin Login</h2>
        <p class="small-text">Enter your admin details to continue.</p>

        <% if (request.getAttribute("error") != null) { %>
            <div class="error-message">
                <%= request.getAttribute("error") %>
            </div>
        <% } %>

        <form action="${pageContext.request.contextPath}/admin-login" method="post">

            <div class="input-group">
                <label>Email Address</label>
                <div class="input-box">
                    <i class="fa-solid fa-envelope"></i>
                    <input type="email" name="email" placeholder="admin@dineease.com" required>
                </div>
            </div>

            <div class="input-group">
                <label>Password</label>
                <div class="input-box">
                    <i class="fa-solid fa-lock"></i>
                    <input type="password" name="password" placeholder="Enter admin password" required>
                </div>
            </div>

            <button type="submit" class="login-btn">
                Login as Admin
                <i class="fa-solid fa-arrow-right"></i>
            </button>

        </form>

        <a href="${pageContext.request.contextPath}/index.jsp" class="back-link">
            <i class="fa-solid fa-arrow-left"></i> Back to Home
        </a>
    </div>

</div>

</body>
</html>