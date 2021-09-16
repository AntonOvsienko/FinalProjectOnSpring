package com.ua.command.get;

import com.ua.Utils.Constant;
import com.ua.command.Command;
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
        HttpSession session = req.getSession();
        System.out.println("session ==> " + session);

        String address = "errorMessage/error.jsp";

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
            ps = con.prepareStatement(Constant.SQL_SELECT_LOGIN_PASSWORD_WHERE_LOGIN_AND_PASSWORD);
            int k=1;
            ps.setString(k++, login);
            ps.setString(k++, password);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                role = rs.getString("role");
                session.setAttribute("globalRole", role);
                keyLogin = rs.getInt("id");
                session.setAttribute("keyLogin", keyLogin);
                String url = "SELECT * FROM " + role + " WHERE login_password_id=" + keyLogin;
                Statement st = con.createStatement();
                ResultSet rs2 = st.executeQuery(url);
                if (role.equals("administrator")) {
                    session.setAttribute("finalAddress","users/doctorList.jsp");
                    address = Constant.URL_CONTROLLER_VIEW_STAFF;
                } else if (role.equals("doctor")) {
                    session.setAttribute("finalAddress","users/doctor.jsp");
                    address = Constant.URL_CONTROLLER_VIEW_NURSE;
                } else if (role.equals("nurse")) {
                    session.setAttribute("finalAddress","page?page=1&pageSize=6");
                    address = Constant.URL_CONTROLLER_VIEW_NURSE;

                }
                setAttributeSession(session, rs2);
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

    private void setAttributeSession(HttpSession session, ResultSet rs2) throws SQLException {
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
            if (rs2.getString("id") != null) {
                session.setAttribute("id", rs2.getInt("id"));
            }
        }
    }

    @Override
    public String execute(HttpServletRequest req, HttpServletResponse resp) {
        return null;
    }
}
