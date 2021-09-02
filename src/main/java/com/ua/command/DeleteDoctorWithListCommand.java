package com.ua.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class DeleteDoctorWithListCommand implements Command {
    @Override
    public String execute(HttpServletRequest req, HttpServletResponse resp, Connection con) {
        Statement st = null;
        ResultSet rs = null;
        int idLogin = 0;
        int idDoctor = Integer.parseInt(req.getParameter("select"));
        String searchDoctorById = "SELECT * FROM doctor WHERE id=" + idDoctor;
        try {
            st = con.createStatement();

            rs = st.executeQuery(searchDoctorById);

            while (rs.next()) {
                idLogin = rs.getInt("login_password_id");
            }
            System.out.println("idLogin => " + idLogin);
            String deleteDoctorById = "DELETE FROM login_password " +
                    "WHERE id=" + idLogin;
            st=con.createStatement();
            st.execute(deleteDoctorById);
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        } finally {
            try {
                con.close();
            } catch (SQLException throwables) {
                throwables.printStackTrace();
            }
        }
        return "controller?command=viewStaff";
    }

    @Override
    public String execute(HttpServletRequest req, HttpServletResponse resp) {
        return null;
    }
}
