<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Login | DineEase</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/userLogin.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
</head>

<body>
<div class="auth-page">

    <!-- ── LEFT PANEL ───────────────────────────────── -->
    <div class="auth-left">

        <div class="brand">
            <i class="fa-solid fa-utensils"></i>
            <span>DineEase</span>
        </div>

        <h1>Welcome Back</h1>
        <p>
            Login to explore menu items, manage reservations, track orders,
            and enjoy a seamless restaurant experience with DineEase.
        </p>

        <div class="info-box">
            <i class="fa-solid fa-bowl-food"></i>
            <div>
                <h3>Simple User Access</h3>
                <p>Book tables, view food options, and manage your restaurant activity easily.</p>
            </div>
        </div>

        <div class="info-box">
            <i class="fa-solid fa-shield-halved"></i>
            <div>
                <h3>Secure Login</h3>
                <p>
                    Your account is protected with session security and
                    a temporary lock after repeated wrong password attempts.
                </p>
            </div>
        </div>

    </div>

    <!-- ── RIGHT PANEL (CARD) ────────────────────────── -->
    <div class="auth-card">

        <div class="card-icon">
            <i class="fa-solid fa-user"></i>
        </div>

        <h2>User Login</h2>
        <p class="small-text">Enter your credentials to continue.</p>

        <%-- Error message --%>
        <% if (request.getAttribute("error") != null) { %>
            <div class="error-message" role="alert">
                <i class="fa-solid fa-circle-exclamation"></i>
                <%= request.getAttribute("error") %>
            </div>
        <% } %>

        <%-- Success message (e.g. after registration or password reset) --%>
        <% if (request.getAttribute("success") != null) { %>
            <div class="success-message" role="status">
                <i class="fa-solid fa-circle-check"></i>
                <%= request.getAttribute("success") %>
            </div>
        <% } %>

        <form action="${pageContext.request.contextPath}/user/login"
              method="post"
              novalidate
              id="loginForm">

            <div class="input-group">
                <label for="email">Email Address</label>
                <div class="input-box">
                    <i class="fa-solid fa-envelope"></i>
                    <input type="email"
                           id="email"
                           name="email"
                           placeholder="user@dineease.com"
                           value="<%= request.getAttribute("error") != null
                                       ? (request.getParameter("email") != null
                                           ? request.getParameter("email") : "")
                                       : "" %>"
                           autocomplete="email"
                           required>
                </div>
            </div>

            <div class="input-group">
                <label for="password">Password</label>
                <div class="input-box">
                    <i class="fa-solid fa-lock"></i>
                    <input type="password"
                           id="password"
                           name="password"
                           placeholder="Enter your password"
                           autocomplete="current-password"
                           required>
                    <button type="button"
                            class="toggle-password"
                            aria-label="Show/hide password"
                            onclick="togglePassword()">
                        <i class="fa-solid fa-eye" id="eyeIcon"></i>
                    </button>
                </div>
            </div>

            <div class="forgot-row">
                <a href="${pageContext.request.contextPath}/user/forgot-password">
                    Forgot Password?
                </a>
            </div>

            <button type="submit" class="login-btn" id="loginBtn">
                Login as User
                <i class="fa-solid fa-arrow-right"></i>
            </button>
            

        </form>

        <p class="switch-text">
            New to DineEase?
            <a href="${pageContext.request.contextPath}/user/register">Create Account</a>
        </p>

        <a href="${pageContext.request.contextPath}/index.jsp" class="back-link">
            <i class="fa-solid fa-arrow-left"></i>
            Back to Home
        </a>

    </div>
</div>

<script>
    /** Toggle the password field between visible text and masked input. */
    function togglePassword() {
        const passwordInput = document.getElementById('password');
        const eyeIcon       = document.getElementById('eyeIcon');

        if (passwordInput.type === 'password') {
            passwordInput.type = 'text';
            eyeIcon.classList.replace('fa-eye', 'fa-eye-slash');
        } else {
            passwordInput.type = 'password';
            eyeIcon.classList.replace('fa-eye-slash', 'fa-eye');
        }
    }

    /** Disable the submit button after first click to prevent double-submit. */
    document.getElementById('loginForm').addEventListener('submit', function () {
        const btn = document.getElementById('loginBtn');
        btn.disabled = true;
        btn.innerHTML = '<i class="fa-solid fa-spinner fa-spin"></i> Logging in...';
    });
</script>

</body>
</html>