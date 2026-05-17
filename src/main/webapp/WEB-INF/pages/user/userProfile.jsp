<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
<head>
    <title>DineEase | User Profile</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/userProfile.css">

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
</head>

<body>

<div class="page-container">

    <a href="${pageContext.request.contextPath}/user/dashboard" class="back-btn">
        ← Back to Dashboard
    </a>

    <div class="page-header">
        <h1>User Profile Management</h1>
        <p>View your account details, update personal information and manage your profile.</p>
    </div>

    <div class="profile-card">

        <div class="profile-left">
            <div class="avatar">
                <i class="fa-solid fa-user"></i>
            </div>

            <h2>${user.fullName}</h2>
            <p class="role">${user.role}</p>

            <div class="info-box">
                <i class="fa-solid fa-circle-check"></i>
                <span>Account Active</span>
            </div>

            <div class="info-box">
                <i class="fa-solid fa-calendar-days"></i>
                <span>Member Since: ${user.createdAt}</span>
            </div>
        </div>

        <div class="profile-right">

            <h2>Update Profile</h2>

            <% if (request.getAttribute("success") != null) { %>
                <div class="success-msg">
                    <i class="fa-solid fa-check-circle"></i>
                    <%= request.getAttribute("success") %>
                </div>
            <% } %>

            <% if (request.getAttribute("error") != null) { %>
                <div class="error-msg">
                    <i class="fa-solid fa-circle-exclamation"></i>
                    <%= request.getAttribute("error") %>
                </div>
            <% } %>

            <form action="${pageContext.request.contextPath}/user/profile" method="post">

                <div class="form-row">
                    <div class="form-group">
                        <label>Full Name</label>
                        <input type="text"
                               name="fullName"
                               value="${user.fullName}"
                               placeholder="Enter full name"
                               required>
                    </div>

                    <div class="form-group">
                        <label>Email Address</label>
                        <input type="email"
                               value="${user.email}"
                               readonly>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label>Phone Number</label>
                        <input type="text"
                               name="phone"
                               value="${user.phone}"
                               maxlength="10"
                               placeholder="Enter phone number"
                               required>
                    </div>

                    <div class="form-group">
                        <label>Address</label>
                        <input type="text"
                               name="address"
                               value="${user.address}"
                               placeholder="Enter address"
                               required>
                    </div>
                </div>

                <button type="submit" class="save-btn">
                    <i class="fa-solid fa-floppy-disk"></i>
                    Save Changes
                </button>

            </form>
        </div>

    </div>

</div>

</body>
</html>