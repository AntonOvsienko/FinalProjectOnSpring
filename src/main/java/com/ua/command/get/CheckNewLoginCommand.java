package com.ua.command.get;

import com.ua.Utils.Constant;
import com.ua.command.Command;

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
        System.out.println((String)session.getAttribute("globalLogin"));
        String login = req.getParameter("newLogin");
        String password = req.getParameter("password");
        String passwordRepeat = req.getParameter("password_repeat");
        String role = req.getParameter("role");

        if (!password.equals(passwordRepeat)) {
            session.setAttribute("messageFalse","1");
            session.setAttribute("newLogin", login);
            return Constant.URL_NEW_LOGIN;
        }
        try {
            System.out.println("con ==> " + con);
            PreparedStatement ps = con.prepareStatement(Constant.SQL_SELECT_LOGIN_PASSWORD_WHERE_LOGIN);
            ps.setString(1, login);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                session.setAttribute("checkLogin", "false");
                session.setAttribute("messageFalse","2");
                return Constant.URL_NEW_LOGIN;
            }
            System.out.println("session2 ==> " + session);
            session.setAttribute("newLogin", login);
            session.setAttribute("password", password);
            session.setAttribute("password_repeat", password);
            session.setAttribute("role", role);
            session.setAttribute("checkLogin", "true");
            session.setAttribute("messageFalse","");
        } catch (SQLException throwables) {
            log.log(Level.WARNING, "", throwables.getMessage());
        }
        return Constant.URL_NEW_LOGIN;
    }

    @Override
    public String execute(HttpServletRequest req, HttpServletResponse resp) {
        return Constant.URL_NEW_LOGIN;
    }
}

