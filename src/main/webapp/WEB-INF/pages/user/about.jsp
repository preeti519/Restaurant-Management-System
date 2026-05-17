<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>About | DineEase</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/about.css">
</head>

<body>

<div class="about-page">

    <div class="about-card">

        <a href="${pageContext.request.contextPath}/user/dashboard" class="back-btn">
            ← Back to Dashboard
        </a>

        <h1>About DineEase</h1>

        <p>
            DineEase is a restaurant management system designed to make food ordering,
            table reservation, and customer service easier for users.
        </p>

        <div class="about-section">
            <h2>Our Purpose</h2>
            <p>
                The main purpose of DineEase is to provide customers with a simple and
                comfortable way to view menu items, place food orders, and book tables online.
            </p>
        </div>

        <div class="about-section">
            <h2>What Users Can Do</h2>
            <ul>
                <li>View available food menu</li>
                <li>Place food orders</li>
                <li>Book table reservations</li>
                <li>View order and reservation details</li>
                <li>Manage user profile</li>
            </ul>
        </div>

        <div class="about-section">
            <h2>Why DineEase?</h2>
            <p>
                DineEase saves time, improves restaurant service, and gives users a better
                dining experience through a clean and easy-to-use system.
            </p>
        </div>

    </div>

</div>

</body>
</html>