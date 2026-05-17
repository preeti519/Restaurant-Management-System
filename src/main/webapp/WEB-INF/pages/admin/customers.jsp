<%@ page import="java.util.List" %>
<%@ page import="com.dineease.model.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    List<User> customers = (List<User>) request.getAttribute("customers");
    String keyword = (String) request.getAttribute("keyword");
%>

<!DOCTYPE html>
<html>
<head>
    <title>DineEase | Customer Management</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/customer.css?v=9999">
</head>

<body>

<div class="customer-page">

    <div class="page-header">
        <div>
            <h1>Customer Management</h1>
            <p>View and search registered restaurant customers</p>
        </div>

        <a href="${pageContext.request.contextPath}/admin/dashboard" class="back-btn">
            Back Dashboard
        </a>
    </div>

    <form action="${pageContext.request.contextPath}/admin/customers" method="get" class="search-box">
        <input type="text"
               name="keyword"
               placeholder="Search customer by name, email or phone..."
               value="<%= keyword != null ? keyword : "" %>">

        <button type="submit">Search</button>
    </form>

    <div class="table-card">
        <table>
            <thead>
            <tr>
                <th>ID</th>
                <th>Customer Name</th>
                <th>Email Address</th>
                <th>Phone Number</th>
                <th>Address</th>
            </tr>
            </thead>

            <tbody>
            <%
                if (customers != null && !customers.isEmpty()) {
                    for (User customer : customers) {
            %>
            <tr>
                <td><%= customer.getId() %></td>
                <td><%= customer.getFullName() %></td>
                <td><%= customer.getEmail() %></td>
                <td><%= customer.getPhone() != null ? customer.getPhone() : "N/A" %></td>
                <td><%= customer.getAddress() != null ? customer.getAddress() : "N/A" %></td>
            </tr>
            <%
                    }
                } else {
            %>
            <tr>
                <td colspan="5" class="no-data">No customers found</td>
            </tr>
            <%
                }
            %>
            </tbody>
        </table>
    </div>

</div>

</body>
</html>