package com.ua.command.update;

import com.ua.Utils.Constant;
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
        int caseRecordId = (int) session.getAttribute("caseRecordId");
        String  URL = Constant.URL_ADD_APPOINTMENT + caseRecordId;
        String[] checkbox = req.getParameterValues("appointment");
        try {
            con.setAutoCommit(false);
            for (int i = 0; i < checkbox.length; i++) {
                ps = con.prepareStatement(Constant.SQL_DOCTOR_APPOINTMENT_DELETE);
                int k=1;
                ps.setInt(k++,Integer.parseInt(checkbox[i]));
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
        return URL;
    }

    @Override
    public String execute(HttpServletRequest req, HttpServletResponse resp) throws SQLException {
        return null;
    }
}
