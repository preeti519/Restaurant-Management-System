package com.dineease.controllers;

import com.dineease.model.Order;
import com.dineease.service.OrderService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/admin/orders")
public class AdminOrderController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private OrderService orderService;

    @Override
    public void init() {
        orderService = new OrderService();
    }

    // Load order page
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("orderList", orderService.getAllOrders());
        request.getRequestDispatcher("/WEB-INF/pages/admin/order.jsp").forward(request, response);
    }

    // Handle add, update, delete
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        String action = request.getParameter("action");

        if ("add".equals(action)) {
            Order order = new Order();

            order.setCustomerName(request.getParameter("customerName"));
            order.setItemName(request.getParameter("itemName"));
            order.setQuantity(Integer.parseInt(request.getParameter("quantity")));
            order.setTotalPrice(Double.parseDouble(request.getParameter("totalPrice")));
            order.setOrderStatus(request.getParameter("orderStatus"));

            orderService.addOrder(order);
        }

        else if ("update".equals(action)) {
            Order order = new Order();

            order.setId(Integer.parseInt(request.getParameter("id")));
            order.setCustomerName(request.getParameter("customerName"));
            order.setItemName(request.getParameter("itemName"));
            order.setQuantity(Integer.parseInt(request.getParameter("quantity")));
            order.setTotalPrice(Double.parseDouble(request.getParameter("totalPrice")));
            order.setOrderStatus(request.getParameter("orderStatus"));

            orderService.updateOrder(order);
        }

        else if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            orderService.deleteOrder(id);
        }

        response.sendRedirect(request.getContextPath() + "/admin/orders");
    }
}