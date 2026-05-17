<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Contact | DineEase</title>
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/contact.css">
</head>
<body>

<div class="contact-page">
    <div class="contact-card">

        <a href="${pageContext.request.contextPath}/user/dashboard"
           class="back-btn">← Back to Dashboard</a>

        <h1>Contact Us</h1>
        <p class="subtitle">Have a question or feedback? We'd love to hear from you.</p>

        <% if (request.getAttribute("success") != null) { %>
            <div class="success-msg"><%= request.getAttribute("success") %></div>
        <% } %>

        <% if (request.getAttribute("error") != null) { %>
            <div class="error-msg"><%= request.getAttribute("error") %></div>
        <% } %>

        <form method="post"
              action="${pageContext.request.contextPath}/user/contact">

            <input type="text"
                   name="name"
                   placeholder="Your Full Name"
                   required>

            <input type="email"
                   name="email"
                   placeholder="Your Email Address"
                   required>

            <textarea name="message"
                      placeholder="Write your message here..."
                      rows="5"
                      required></textarea>

            <button type="submit">Send Message</button>

        </form>

        <div class="contact-info">
            <div class="info-box">
                <h3>📍 Address</h3>
                <p>Kathmandu, Nepal</p>
            </div>
            <div class="info-box">
                <h3>📞 Phone</h3>
                <p>+977-9800000000</p>
            </div>
            <div class="info-box">
                <h3>✉️ Email</h3>
                <p>support@dineease.com</p>
            </div>
        </div>

    </div>
</div>

</body>
</html>