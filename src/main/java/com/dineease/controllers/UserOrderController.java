package com.dineease.controllers;

import com.dineease.model.Order;
import com.dineease.service.UserOrderService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/user/orders")
public class UserOrderController extends HttpServlet {

    private UserOrderService orderService;

    @Override
    public void init() {
        orderService = new UserOrderService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setAttribute("orderList", orderService.getAllOrders());

        request.getRequestDispatcher("/WEB-INF/pages/user/userOrder.jsp")
                .forward(request, response);
    }


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
            order.setOrderStatus("Pending");

            orderService.placeOrder(order);
        }

        if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            orderService.deleteOrder(id);
        }

        response.sendRedirect(request.getContextPath() + "/user/orders");
    }
}