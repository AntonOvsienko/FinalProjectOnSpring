package com.ua.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;

public class AddNewStaffFirstStepCreateLoginCommand implements Command {
    private static final Logger log = Logger.getLogger(AddNewStaffFirstStepCreateLoginCommand.class.getName());

    @Override
    public String execute(HttpServletRequest req, HttpServletResponse resp) {
        HttpSession session = req.getSession();
        System.out.println("session==>" + session);
        session.setMaxInactiveInterval(30);
        String login = req.getParameter("login");
        String password = req.getParameter("password");
        String passwordRepeat = req.getParameter("password_repeat");
        String role = req.getParameter("role");
        if (!password.equals(passwordRepeat)) {
            return "errorMessage/errorRepeatPassword.jsp";
        }
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager
                    .getConnection("jdbc:mysql://localhost:3306/mydb", "root", "Rusleo1984");
            System.out.println("con ==> " + con);
            PreparedStatement ps = con.prepareStatement(
                    "SELECT * FROM login_password WHERE login=?");
            ps.setString(1, login);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return "errorMessage/errorLoginTaken.jsp";
            }
            PreparedStatement newLogin = con.prepareStatement(
                    "INSERT INTO login_password (login,password,role) VALUES (?,?,?)");
            newLogin.setString(1, login);
            newLogin.setString(2, password);
            newLogin.setString(3, role);
            newLogin.executeUpdate();
            String newStaff = "INSERT INTO " + role + " (login_password_id) VALUES (?)";
            System.out.println(newStaff);
            PreparedStatement newStaff2 = con.prepareStatement(newStaff);
            PreparedStatement returnId = con.prepareStatement(
                    "SELECT * FROM login_password WHERE login=?");
            returnId.setString(1, login);
            ResultSet rs2 = returnId.executeQuery();
            int id=0;
            while (rs2.next()) {
                id = rs2.getInt("id");
            }
            System.out.println(id);
            newStaff2.setInt(1, id);
            newStaff2.executeUpdate();
        } catch (SQLException | ClassNotFoundException throwables) {
            log.log(Level.WARNING, "", throwables.getMessage());
        }

        return "controller?command=updateStaff";
    }
}
