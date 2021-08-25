package com.ua.web;

import com.ua.entity.Administrator;
import com.ua.entity.Staff;

import java.io.*;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import javax.servlet.annotation.*;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

        // (1) obtain an input info
        String login = request.getParameter("login");
        String password = request.getParameter("password");
        System.out.println("login ==> " + login);

        // (2) process an input info
        // obtain from DB
        Staff staff = new Administrator();
        staff.setLogin(login);
        staff.setPassword(password);
        staff.setRole("admin");

        String forward = "index.html";

        HttpSession session = request.getSession();
        if (staff != null) {
            // (3) save a result as an attibute
            session.setAttribute("currentUser", staff);
            forward = "view.jsp";
        }

        // (4) go to a view layer
        request.getRequestDispatcher(forward).forward(request, response);
    }


}