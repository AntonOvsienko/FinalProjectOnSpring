package com.ua.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;

public class LoginCommand implements Command {
    private static final Logger log = Logger.getLogger(LoginCommand.class.getName());

    @Override
    public String execute(HttpServletRequest req, HttpServletResponse resp) {
        // get login, password
        // obtain from DB user by login
        // check password
        String address="error.jsp";
        String login = req.getParameter("login");
        String password = req.getParameter("password");
        String role;
        String name;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager
                    .getConnection("jdbc:mysql://localhost:3306/mydb", "root", "Rusleo1984");
            System.out.println("con ==> " + con);
            PreparedStatement ps = con.prepareStatement("SELECT * FROM login_password WHERE login=? " +
                    "AND password=?");
            ps.setString(1, login);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                role=rs.getString("role");
                if (role.equals("administrator")){
                address="users/admin.jsp";
                } else if (role.equals("doctor")){
                    address="users/doctor.jsp";
                }else if (role.equals("patient")){
                    address="users/patient.jsp";}
            }
        } catch (SQLException | ClassNotFoundException throwables) {
            log.log(Level.WARNING, "", throwables.getMessage());
        }

        return address;
    }
}
