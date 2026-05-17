package com.dineease.controllers;

import com.dineease.model.Menu;
import com.dineease.service.MenuService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/menu")
public class AdminMenuController extends HttpServlet {

    private MenuService menuService;

    @Override
    public void init() {
        menuService = new MenuService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Menu> menuList = menuService.getAllMenuItems();

        request.setAttribute("menuList", menuList);
        request.getRequestDispatcher("/WEB-INF/pages/admin/menu.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        String action = request.getParameter("action");

        if ("add".equals(action)) {
            addMenu(request);
        } else if ("update".equals(action)) {
            updateMenu(request);
        } else if ("delete".equals(action)) {
            deleteMenu(request);
        }

        response.sendRedirect(request.getContextPath() + "/admin/menu");
    }

    private void addMenu(HttpServletRequest request) {
        Menu menu = new Menu();

        menu.setName(request.getParameter("name"));
        menu.setCategory(request.getParameter("category"));
        menu.setPrice(Double.parseDouble(request.getParameter("price")));
        menu.setDescription(request.getParameter("description"));
        menu.setStatus(request.getParameter("status"));
        menu.setImage(request.getParameter("image"));

        menuService.addMenuItem(menu);
    }

    private void updateMenu(HttpServletRequest request) {
        Menu menu = new Menu();

        menu.setId(Integer.parseInt(request.getParameter("id")));
        menu.setName(request.getParameter("name"));
        menu.setCategory(request.getParameter("category"));
        menu.setPrice(Double.parseDouble(request.getParameter("price")));
        menu.setDescription(request.getParameter("description"));
        menu.setStatus(request.getParameter("status"));
        menu.setImage(request.getParameter("image"));

        menuService.updateMenuItem(menu);
    }

    private void deleteMenu(HttpServletRequest request) {
        int id = Integer.parseInt(request.getParameter("id"));
        menuService.deleteMenuItem(id);
    }
}