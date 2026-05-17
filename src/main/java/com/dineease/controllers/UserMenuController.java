package com.dineease.controllers;

import com.dineease.model.Menu;
import com.dineease.service.MenuService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/user/menu")
public class UserMenuController extends HttpServlet {

    private MenuService menuService;

    @Override
    public void init() {
        menuService = new MenuService();
    }

    @Override
   protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Menu> menuList = menuService.getAvailableMenuItems();

        request.setAttribute("menuList", menuList);

        request.getRequestDispatcher("/WEB-INF/pages/user/userMenu.jsp")
                .forward(request, response);
    }
}