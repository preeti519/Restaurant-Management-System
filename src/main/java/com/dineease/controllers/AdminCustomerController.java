package com.dineease.controllers;

import com.dineease.model.User;
import com.dineease.service.CustomerService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/customers")
public class AdminCustomerController extends HttpServlet {

    private CustomerService customerService;

    @Override
    public void init() {
        customerService = new CustomerService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String keyword = request.getParameter("keyword");

        List<User> customers;

        if (keyword != null && !keyword.trim().isEmpty()) {
            customers = customerService.searchCustomers(keyword.trim());
        } else {
            customers = customerService.getAllCustomers();
        }

        request.setAttribute("customers", customers);
        request.setAttribute("keyword", keyword);

        request.getRequestDispatcher("/WEB-INF/pages/admin/customers.jsp")
                .forward(request, response);
    }
}