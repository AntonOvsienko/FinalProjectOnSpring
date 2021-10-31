package com.ua.web;

import com.ua.ConnectionPool;
import com.ua.Utils.Constant;
import com.ua.command.*;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.stereotype.Controller;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.sql.SQLException;

@Controller
public class MyController {

    @RequestMapping("/controller")
    public String controllerPage(HttpServletRequest req, HttpServletResponse resp) throws UnsupportedEncodingException {
        String commandString="";
        req.setCharacterEncoding("UTF-8");
        HttpSession session = req.getSession();
        System.out.println("session==>" + session);
        session.setMaxInactiveInterval(30);
        AnnotationConfigApplicationContext context= new AnnotationConfigApplicationContext("SpringConfig.class");

        // (1) get command name

        if (req.getParameter("command") != null) {
            session.setAttribute("command", req.getParameter("command"));
        }
        String commandName = (String) session.getAttribute("command");
        System.out.println("commandName ==> " + commandName);

        // (2) get command
        Command command = (Command) context.getBean(commandName);
        System.out.println("command ==> " + command);

        String address = "errorMessage/error.jsp";
        ConnectionPool.getInstance();
        // (3) do command
        try {
            address = command.execute(req, resp, ConnectionPool.getConnection());
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return address;
    }
}
