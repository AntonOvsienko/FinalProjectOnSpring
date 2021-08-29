package com.ua.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;

public class AddNewStaffSecondStepAccountContent implements Command {
    private static final Logger log = Logger.getLogger(AddNewStaffSecondStepAccountContent.class.getName());

    @Override
    public String execute(HttpServletRequest req, HttpServletResponse resp, Connection con) {
        HttpSession session = req.getSession();
        System.out.println("session ==> " + session);
        System.out.println(session.getAttribute("keyLogin"));
        String department = "";

        Integer keyLogin = (Integer) session.getAttribute("keyLogin");
        String role = (String) session.getAttribute("role");
        String login = (String) session.getAttribute("login");
        String password = (String) session.getAttribute("password");


        int ageSet = Integer.parseInt(req.getParameter("age"));
        String nameSet = req.getParameter("name");
        String surnameSet = req.getParameter("surname");
        String passportSet = req.getParameter("passport");
        String gender = req.getParameter("gender");
        if (req.getParameter("department") != null) {
            department = req.getParameter("department");
        }

        System.out.println("age-" + ageSet
                + "\nlogin-" + login
                + "\npassword-" + password
                + "\nname-" + nameSet
                + "\nsurname-" + surnameSet
                + "\npassport-" + passportSet
                + "\nrole-" + role
                + "\ngender-" + gender);
        try {
            int idDep = 0;
            String update = "";
            String findDepratmentId = "SELECT * FROM department WHERE " + department;
            Statement dep = con.createStatement();
            ResultSet rsDep = dep.executeQuery(findDepratmentId);
            while (rsDep.next()) {
                idDep = rsDep.getInt("id");
            }
            System.out.println("con ==> " + con);
            if (role.equals("doctor")) {
                update = "UPDATE " + role + " SET name='" + nameSet + "', surname='" +
                        surnameSet + "', age=" + ageSet + ", passport='" + passportSet +
                        "', gender='" + gender + "'" + ", department='" + idDep + "'" +
                        "WHERE login_password_id=" + keyLogin;
            } else {
                update = "UPDATE " + role + " SET name='" + nameSet + "', surname='" +
                        surnameSet + "', age=" + ageSet + ", passport='" + passportSet +
                        "', gender='" + gender + "'" +
                        "WHERE login_password_id=" + keyLogin;
            }
            System.out.println(update);
            Statement newLogin = con.createStatement();
            newLogin.executeUpdate(update);
        } catch (SQLException throwables) {
            log.log(Level.WARNING, "", throwables.getMessage());
        } finally {
            try {
                con.close();
            } catch (SQLException throwables) {
                throwables.printStackTrace();
            }
        }
        return "users/admin.jsp";
    }

    @Override
    public String execute(HttpServletRequest req, HttpServletResponse resp) {
        return null;
    }
}
