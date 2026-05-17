<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>User Register | DineEase</title>

    <link rel="stylesheet"
      href="${pageContext.request.contextPath}/css/userRegister.css">

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
</head>

<body>

<div class="auth-page">

    <!-- LEFT SIDE -->
    <div class="auth-left">

        <div class="brand">
            <i class="fa-solid fa-utensils"></i>
            <span>DineEase</span>
        </div>

        <h1>Create Your Account</h1>

        <p>
            Register with DineEase to book tables,
            manage reservations, view orders,
            and enjoy restaurant services.
        </p>

        <div class="info-box">
            <i class="fa-solid fa-calendar-check"></i>

            <div>
                <h3>Easy Reservation</h3>

                <p>
                    Create an account and access restaurant
                    features in a secure and simple way.
                </p>
            </div>
        </div>

    </div>

    <!-- RIGHT SIDE -->
    <div class="auth-right">

        <div class="auth-card">

            <div class="icon-box">
                <i class="fa-solid fa-user-plus"></i>
            </div>

            <h2>User Register</h2>

            <p>Create your DineEase account.</p>

            <!-- ERROR MESSAGE -->
            <% if (request.getAttribute("error") != null) { %>
                <div class="error-msg">
                    <i class="fa-solid fa-circle-exclamation"></i>
                    <%= request.getAttribute("error") %>
                </div>
            <% } %>

            <!-- SUCCESS MESSAGE -->
            <% if (request.getAttribute("success") != null) { %>
                <div class="success-msg">
                    <i class="fa-solid fa-circle-check"></i>
                    <%= request.getAttribute("success") %>
                </div>
            <% } %>

            <!-- REGISTER FORM -->
            <form action="${pageContext.request.contextPath}/user/register"
                  method="post">

                <!-- FULL NAME -->
                <div class="form-group">

                    <label>Full Name</label>

                    <div class="input-box">
                        <i class="fa-solid fa-user"></i>

                        <input type="text"
                               name="fullName"
                               placeholder="Enter full name"
                               required>
                    </div>

                </div>

                <!-- EMAIL -->
                <div class="form-group">

                    <label>Email Address</label>

                    <div class="input-box">
                        <i class="fa-solid fa-envelope"></i>

                        <input type="email"
                               name="email"
                               placeholder="Enter email address"
                               required>
                    </div>

                </div>

                <!-- PASSWORD -->
                <div class="form-group">

                    <label>Password</label>

                    <div class="input-box">
                        <i class="fa-solid fa-lock"></i>

                        <input type="password"
                               name="password"
                               placeholder="Create password (min 6 characters)"
                               required>
                    </div>

                </div>

                <!-- BUTTON -->
                <button type="submit" class="auth-btn">
                    Register Account
                    <i class="fa-solid fa-arrow-right"></i>
                </button>

            </form>

            <div class="bottom-links">

                <p>
                    Already have an account?
                    <a href="${pageContext.request.contextPath}/user/login">
                        Login Here
                    </a>
                </p>

                <a href="${pageContext.request.contextPath}/">
                    <i class="fa-solid fa-arrow-left"></i>
                    Back to Home
                </a>

            </div>

        </div>

    </div>

</div>

</body>
</html>
