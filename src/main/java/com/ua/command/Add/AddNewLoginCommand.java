package com.ua.command.Add;

import com.ua.command.Command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.*;
import java.util.logging.Logger;

public class AddNewLoginCommand implements Command {
    private static final Logger log = Logger.getLogger(AddNewLoginCommand.class.getName());

    @Override
    public String execute(HttpServletRequest req, HttpServletResponse resp, Connection con) {
        HttpSession session = req.getSession();
        System.out.println("session ==> " + session);
        session.setAttribute("successfully",null);
        String login = req.getParameter("login");
        String password = req.getParameter("password");
        String passwordRepeat = req.getParameter("password_repeat");
        String role = req.getParameter("role");
        System.out.println("login => " + login);
        System.out.println("password => " + password);
        System.out.println("password_repeat => " + passwordRepeat);
        System.out.println("role => " + role);
        PreparedStatement newLogin;
        PreparedStatement newStaff2;
        PreparedStatement returnId;
        ResultSet rs2;
        Statement newLogin2;

        try {
            con.setAutoCommit(false);
            newLogin = con.prepareStatement(
                    "INSERT INTO login_password (login,password,role) VALUES (?,?,?)");

            newLogin.setString(1, login);
            newLogin.setString(2, password);
            newLogin.setString(3, role);
            newLogin.executeUpdate();
            String newStaff = "INSERT INTO " + role + " (login_password_id) VALUES (?)";
            System.out.println(newStaff);
            newStaff2 = con.prepareStatement(newStaff);

            returnId = con.prepareStatement(
                    "SELECT * FROM login_password WHERE login=?");
            returnId.setString(1, login);
            rs2 = returnId.executeQuery();
            int id = 0;
            while (rs2.next()) {
                id = rs2.getInt("id");
            }
            newStaff2.setInt(1, id);
            newStaff2.executeUpdate();
            String nameSet = req.getParameter("name");
            String surnameSet = req.getParameter("surname");
            String passportSet = req.getParameter("passport");
            String telephoneSet = req.getParameter("telephone");
            String department = "";
            if (req.getParameter("department") != null) {
                department = req.getParameter("department");
            }
            System.out.println("login-" + login
                    + "\npassword-" + password
                    + "\nname-" + nameSet
                    + "\nsurname-" + surnameSet
                    + "\npassport-" + passportSet
                    + "\nrole-" + role
                    + "\ntelephone-" + telephoneSet);
            String update = "";
            if (role.equals("doctor")) {
                update = "UPDATE " + role + " SET name='" + nameSet + "', surname='" +
                        surnameSet + "', telephone='" + telephoneSet + "', passport='" + passportSet +
                        "', department='" + department + "'" +
                        " WHERE login_password_id=" + id;
            } else {
                update = "UPDATE " + role + " SET name='" + nameSet + "', surname='" +
                        surnameSet + "', telephone='" + telephoneSet + "', passport='" + passportSet +
                        "' WHERE login_password_id=" + id;
            }
            System.out.println(update);
            newLogin2 = con.createStatement();
            newLogin2.executeUpdate(update);
            con.commit();
        } catch (SQLException throwables) {
            try {
                con.rollback();
            } catch (SQLException e) {
                e.printStackTrace();
            }
            throwables.printStackTrace();
            session.setAttribute("error", "Ошибка ввода");
            return "users/newLogin.jsp";
        } finally {
            try {
                con.setAutoCommit(true);
                con.close();
            } catch (SQLException throwables) {
                throwables.printStackTrace();
            }
        }
        session.setAttribute("checkLogin",null);
        session.setAttribute("successfully","Логин создан");
        session.setAttribute("error", null);
        return "users/newLogin.jsp";
    }

    @Override
    public String execute(HttpServletRequest req, HttpServletResponse resp) {
        return "users/newLogin.jsp";
    }
}

