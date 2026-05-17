<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
<head>
    <title>DineEase | Admin Dashboard</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/admin-dashboard.css">

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
</head>

<body>

<div class="admin-layout">

    <!-- SIDEBAR -->
    <aside class="sidebar">

        <div class="admin-profile">
            <div class="admin-avatar">A</div>
            <div>
                <h3>Admin</h3>
                <p>ADMINISTRATOR</p>
            </div>
        </div>

        <hr>

        <p class="menu-title">MAIN</p>

        <a href="${pageContext.request.contextPath}/admin/dashboard" class="nav-link active">
            <i class="fa-solid fa-house"></i>
            Dashboard
        </a>

        <a href="${pageContext.request.contextPath}/admin/menu" class="nav-link">
            <i class="fa-solid fa-utensils"></i>
            Menu Management
        </a>

        <a href="${pageContext.request.contextPath}/admin/reservations" class="nav-link">
            <i class="fa-solid fa-calendar-check"></i>
            Reservations
        </a>

        <a href="${pageContext.request.contextPath}/admin/orders" class="nav-link">
            <i class="fa-solid fa-cart-shopping"></i>
            Orders
        </a>

        <a href="${pageContext.request.contextPath}/admin/customers" class="nav-link">
            <i class="fa-solid fa-users"></i>
            Customers
        </a>

        

        

        <p class="menu-title">ACCOUNT</p>

        <a href="${pageContext.request.contextPath}/logout" class="nav-link">
    <i class="fa-solid fa-right-from-bracket"></i>
    Logout
</a>

    </aside>

    <!-- MAIN DASHBOARD -->
    <main class="dashboard-main">

        <div class="dashboard-header">
            <div>
                <h1>Admin Dashboard</h1>
                <p>Simple real-time overview of your restaurant system.</p>
            </div>
        </div>

        <section class="stats-grid">

            <div class="stat-card">
                <div class="icon-box">
                    <i class="fa-solid fa-utensils"></i>
                </div>
                <h3>Menu Items</h3>
                <h2>${totalMenuItems}</h2>
                <p>Total food items available</p>
            </div>

            <div class="stat-card">
                <div class="icon-box">
                    <i class="fa-solid fa-cart-shopping"></i>
                </div>
                <h3>Total Orders</h3>
                <h2>${totalOrders}</h2>
                <p>Orders placed by customers</p>
            </div>

            <div class="stat-card">
                <div class="icon-box">
                    <i class="fa-solid fa-calendar-check"></i>
                </div>
                <h3>Reservations</h3>
                <h2>${totalReservations}</h2>
                <p>Total table bookings</p>
            </div>

            <div class="stat-card">
                <div class="icon-box">
                    <i class="fa-solid fa-users"></i>
                </div>
                <h3>Customers</h3>
                <h2>${totalCustomers}</h2>
                <p>Registered user accounts</p>
            </div>

        </section>

        <section class="bottom-section">

            <div class="revenue-card">
                <h3>Total Revenue</h3>
                <h1>$${totalRevenue}</h1>
                <p>Revenue from completed orders</p>
            </div>

            <div class="status-card">
                <h3>Order Status</h3>

                <div class="status-row">
                    <span>Pending</span>
                    <strong>${pendingOrders}</strong>
                </div>

                <div class="status-row">
                    <span>Preparing</span>
                    <strong>${preparingOrders}</strong>
                </div>

                <div class="status-row">
                    <span>Completed</span>
                    <strong>${completedOrders}</strong>
                </div>

                <div class="status-row">
                    <span>Cancelled</span>
                    <strong>${cancelledOrders}</strong>
                </div>
            </div>

        </section>

    </main>

</div>

</body>
</html>