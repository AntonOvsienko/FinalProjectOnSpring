package com.ua.command;

import com.ua.ConnectionPool;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;

public class LoginCommand implements Command {
    private static final Logger log = Logger.getLogger(LoginCommand.class.getName());

    @Override
    public String execute(HttpServletRequest req, HttpServletResponse resp,Connection con) {
        // get login, password
        // obtain from DB user by login
        // check password
        HttpSession session = req.getSession();
        System.out.println("session ==> " + session);

        String address = "error.jsp";

        if (req.getParameter("login") != null) {
            session.setAttribute("globalLogin", req.getParameter("login"));
        }
        if (req.getParameter("password") != null) {
            session.setAttribute("globalPassword", req.getParameter("password"));
        }
        String login = (String) session.getAttribute("globalLogin");
        String password = (String) session.getAttribute("globalPassword");
        String role;
        int keyLogin = 0;
        PreparedStatement ps;
        try {
            System.out.println("con ==> " + con);
            ps = con.prepareStatement("SELECT * FROM login_password WHERE login=? " +
                    "AND password=?");
            ps.setString(1, login);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                role = rs.getString("role");
                session.setAttribute("globalRole", role);
                keyLogin = rs.getInt("id");
                session.setAttribute("keyLogin", keyLogin);
                String url = "SELECT * FROM " + role + " WHERE login_password_id=" + keyLogin;
                System.out.println(url);
                Statement st = con.createStatement();
                ResultSet rs2 = st.executeQuery(url);
                if (role.equals("administrator")) {
                    session.setAttribute("finalAddress","users/doctorList.jsp");
                    address = "controller?command=viewStaff";
                } else if (role.equals("doctor")) {
                    session.setAttribute("finalAddress","users/doctor.jsp");
                    address = "controller?command=viewStaff";
                } else if (role.equals("nurse")) {
                    address = "users/nurse.jsp";
                }
                while (rs2.next()) {
                    if (rs2.getString("name") != null) {
                        session.setAttribute("name", rs2.getString("name"));
                    }
                    if (rs2.getString("surname") != null) {
                        session.setAttribute("surname", rs2.getString("surname"));
                    }
                    if (rs2.getString("passport") != null) {
                        session.setAttribute("passport", rs2.getString("passport"));
                    }
                    if (rs2.getString("telephone") != null) {
                        session.setAttribute("telephone", rs2.getString("telephone"));
                    }
                }
            }
        }  catch (SQLException throwables) {
            log.log(Level.SEVERE, "", throwables.getMessage());
        } finally {
            try {
                con.close();
            } catch (SQLException throwables) {
                log.log(Level.SEVERE, "", throwables.getMessage());
            }
        }
        return address;
    }

    @Override
    public String execute(HttpServletRequest req, HttpServletResponse resp) {
        return null;
    }
}
