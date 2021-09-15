package com.ua.command.add;

import com.ua.Utils.Constant;
import com.ua.command.Command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.*;

public class AddAppointmentCommand implements Command {
    @Override
    public String execute(HttpServletRequest req, HttpServletResponse resp, Connection con) {
        HttpSession session = req.getSession();
        System.out.println("session ==> " + session);
        int caseRecordId = Integer.parseInt(req.getParameter("caseRecordId"));
        String select;
        String description;
        String URL = Constant.URL_ADD_APPOINTMENT + caseRecordId;

        try {
            con.setAutoCommit(false);
            if (req.getParameter("select1") == null & req.getParameter("select2") == null &
                    req.getParameter("select3") == null & req.getParameter("select4") == null) {
                return URL;
            }
            if (req.getParameter("select1") != null) {
                select = req.getParameter("select1");
                description = req.getParameter("description1");
                addInTable(req, con, select, description);
            }
            if (req.getParameter("select2") != null) {
                select = req.getParameter("select2");
                description = req.getParameter("description2");
                addInTable(req, con, select, description);
            }
            if (req.getParameter("select3") != null) {
                select = req.getParameter("select3");
                description = req.getParameter("description3");
                addInTable(req, con, select, description);
            }
            if (req.getParameter("select4") != null) {
                select = req.getParameter("select4");
                description = req.getParameter("description4");
                addInTable(req, con, select, description);
            }
            con.commit();
        } catch (SQLException throwables) {
            try {
                con.rollback();
            } catch (SQLException e) {
                e.printStackTrace();
            }
            throwables.getMessage();
            return Constant.URL_ERROR_PAGE;
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

    private void addInTable(HttpServletRequest req, Connection con, String select, String description) throws SQLException {
        HttpSession session = req.getSession();
        System.out.println("session ==> " + session);
        int case_record_id = 0;
        PreparedStatement ps;
        ps = con.prepareStatement(Constant.SQL_APPOINTMENT_SELECT);
        int k = 1;
        ps.setInt(k++, Integer.parseInt(req.getParameter("caseRecordId")));
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            case_record_id = rs.getInt("case_record_id");
        }
        ps = con.prepareStatement(Constant.SQL_APPOINTMENT_INSERT);
        k = 1;
        ps.setInt(k++, case_record_id);
        ps.setString(k++, select);
        ps.setString(k++, description);
        ps.setString(k++, null);
        System.out.println(ps.executeUpdate());
        ps.close();
    }

    @Override
    public String execute(HttpServletRequest req, HttpServletResponse resp) throws SQLException {
        return null;
    }
}
