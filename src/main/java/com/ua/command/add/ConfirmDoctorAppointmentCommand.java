package com.ua.command.add;

import com.ua.Utils.Constant;
import com.ua.command.Command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.*;

public class ConfirmDoctorAppointmentCommand implements Command {
    @Override
    public String execute(HttpServletRequest req, HttpServletResponse resp, Connection con) throws SQLException {
        HttpSession session = req.getSession();
        System.out.println("session ==> " + session);
        Statement st = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        int caseRecordId = Integer.parseInt(req.getParameter("caseRecordId"));
        String URL = Constant.URL_ADD_APPOINTMENT + caseRecordId;
        String[] checkbox = req.getParameterValues("appointment");
        try {
            con.setAutoCommit(false);
            StringBuilder nameSurname = new StringBuilder();
            int id = (int) session.getAttribute("keyLogin");
            ps = con.prepareStatement(Constant.SQL_SELECT_DOCTOR_WHERE_LOGIN);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            while (rs.next()) {
                String name = rs.getString("name");
                String surname = rs.getString("surname");
                nameSurname.append(name).append(" ").append(surname);
            }
            ps = con.prepareStatement(Constant.SQL_SELECT_LOGIN_PASSWORD_WHERE_ID);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            while (rs.next()) {
                String role = rs.getString("role");
                if (role.equals("doctor")) {
                    nameSurname.append("(").append("доктор").append(")");
                }
                if (role.equals("nurse")) {
                    nameSurname.append("(").append("медсестра").append(")");
                }
            }
            for (int i = 0; i < checkbox.length; i++) {
                ps = con.prepareStatement(Constant.SQL_UPDATE_DOCTOR_APPOINTMENT);
                ps.setString(1,nameSurname.toString());
                ps.setInt(2,Integer.parseInt(checkbox[i]));
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
