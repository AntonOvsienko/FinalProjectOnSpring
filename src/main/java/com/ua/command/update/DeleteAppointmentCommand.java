package com.ua.command.update;

import com.ua.command.Command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DeleteAppointmentCommand implements Command {
    @Override
    public String execute(HttpServletRequest req, HttpServletResponse resp, Connection con) {
        HttpSession session = req.getSession();
        System.out.println("session ==> " + session);
        PreparedStatement ps = null;
        ResultSet rs = null;
        int caseRecordId = (int) session.getAttribute("caseRecordId");
        String  URL = "controller?command=doctorAppointment&caseRecordId=" + caseRecordId;
        String[] checkbox = req.getParameterValues("appointment");
        try {
            con.setAutoCommit(false);
            for (int i = 0; i < checkbox.length; i++) {
                String path = "DELETE FROM doctor_appointment WHERE id=" + checkbox[i];
                ps = con.prepareStatement(path);
                ps.execute();
            }
            con.commit();
        } catch (SQLException throwables) {
            try {
                con.rollback();
            } catch (SQLException e) {
                e.printStackTrace();
            }
            throwables.printStackTrace();
        } finally {
            try {
                con.close();
            } catch (SQLException throwables) {
                throwables.printStackTrace();
            }
        }
        System.out.println(URL);
        return URL;
    }

    @Override
    public String execute(HttpServletRequest req, HttpServletResponse resp) throws SQLException {
        return null;
    }
}
