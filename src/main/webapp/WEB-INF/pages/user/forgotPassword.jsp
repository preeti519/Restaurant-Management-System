<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Forgot Password | DineEase</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/forgetPassword.css">

    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"
          rel="stylesheet">
</head>

<body>

<div class="auth-page">

    <!-- LEFT SIDE -->
    <div class="auth-left">

        <div class="brand">
            <i class="fa-solid fa-utensils"></i>
            <span>DineEase</span>
        </div>

        <h1>Reset Password</h1>

        <p>
            Enter your registered email address and create
            a new password to recover your DineEase account securely.
        </p>

        <div class="info-box">
            <i class="fa-solid fa-shield-halved"></i>

            <div>
                <h3>Secure Recovery</h3>

                <p>
                    Your password update process is protected
                    for better account security.
                </p>
            </div>
        </div>

        <div class="info-box">
            <i class="fa-solid fa-lock"></i>

            <div>
                <h3>Account Protection</h3>

                <p>
                    Use a strong password to keep your account
                    and restaurant activities safe.
                </p>
            </div>
        </div>

    </div>

    <!-- RIGHT SIDE -->
    <div class="auth-card">

        <div class="card-icon">
            <i class="fa-solid fa-key"></i>
        </div>

        <h2>Forgot Password</h2>

        <p class="small-text">
            Reset your account password below.
        </p>

        <% if(request.getAttribute("error") != null){ %>

            <div class="error-message">
                <i class="fa-solid fa-circle-exclamation"></i>
                <%= request.getAttribute("error") %>
            </div>

        <% } %>

        <% if(request.getAttribute("success") != null){ %>

            <div class="success-message">
                <i class="fa-solid fa-circle-check"></i>
                <%= request.getAttribute("success") %>
            </div>

        <% } %>

        <form method="post"
              action="${pageContext.request.contextPath}/user/forgot-password">

            <!-- EMAIL -->
            <div class="input-group">

                <label>Email Address</label>

                <div class="input-box">

                    <i class="fa-solid fa-envelope"></i>

                    <input type="email"
                           name="email"
                           placeholder="Enter your email"
                           required>

                </div>
            </div>

            <!-- PASSWORD -->
            <div class="input-group">

                <label>New Password</label>

                <div class="input-box">

                    <i class="fa-solid fa-lock"></i>

                    <input type="password"
                           name="newPassword"
                           id="newPassword"
                           placeholder="Enter new password"
                           required>

                    <button type="button"
                            class="toggle-password"
                            onclick="togglePassword()">

                        <i class="fa-solid fa-eye"
                           id="eyeIcon"></i>

                    </button>

                </div>
            </div>

            <button type="submit"
                    class="login-btn">

                Reset Password

                <i class="fa-solid fa-arrow-right"></i>

            </button>

        </form>

        <p class="switch-text">

            Remember your password?

            <a href="${pageContext.request.contextPath}/user/login">
                Login Here
            </a>

        </p>

        <a href="${pageContext.request.contextPath}/index.jsp"
           class="back-link">

            <i class="fa-solid fa-arrow-left"></i>

            Back to Home

        </a>

    </div>

</div>

<script>

    function togglePassword() {

        const passwordInput =
            document.getElementById("newPassword");

        const eyeIcon =
            document.getElementById("eyeIcon");

        if(passwordInput.type === "password") {

            passwordInput.type = "text";

            eyeIcon.classList.replace(
                "fa-eye",
                "fa-eye-slash"
            );

        } else {

            passwordInput.type = "password";

            eyeIcon.classList.replace(
                "fa-eye-slash",
                "fa-eye"
            );
        }
    }

</script>

</body>
</html>