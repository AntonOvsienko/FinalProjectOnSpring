package com.ua.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class CheckNewLoginCommand implements Command {
    private static final Logger log = Logger.getLogger(CheckNewLoginCommand.class.getName());

    @Override
    public String execute(HttpServletRequest req, HttpServletResponse resp, Connection con) {
        HttpSession session = req.getSession();
        System.out.println("session ==> " + session);
        session.setMaxInactiveInterval(30);
        String login = req.getParameter("login");
        String password = req.getParameter("password");
        String passwordRepeat = req.getParameter("password_repeat");
        String role = req.getParameter("role");
        System.out.println("login => " + login);
        System.out.println("password => " + password);
        System.out.println("password_repeat => " + passwordRepeat);
        System.out.println("role => " + role);

        if (!password.equals(passwordRepeat)) {
            return "errorMessage/errorRepeatPassword.jsp";
        }
        try {
            System.out.println("con ==> " + con);
            PreparedStatement ps = con.prepareStatement(
                    "SELECT * FROM login_password WHERE login=?");
            ps.setString(1, login);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                session.setAttribute("checkLogin", "false");
                return "users/newLogin.jsp";
            }
            System.out.println("session2 ==> " + session);
            session.setAttribute("login", login);
            session.setAttribute("password", password);
            session.setAttribute("password_repeat", password);
            session.setAttribute("role", role);
            session.setAttribute("checkLogin", "true");
        } catch (SQLException throwables) {
            log.log(Level.WARNING, "", throwables.getMessage());
        }
        return "users/newLogin.jsp";
    }

    @Override
    public String execute(HttpServletRequest req, HttpServletResponse resp) {
        return "users/newLogin.jsp";
    }
}

