package com.ua.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.*;

public class AddAppointmentCommand implements Command {
    @Override
    public String execute(HttpServletRequest req, HttpServletResponse resp, Connection con) {
        HttpSession session = req.getSession();
        System.out.println("session ==> " + session);
        int caseRecordId = (int) session.getAttribute("caseRecordId");
        PreparedStatement ps;
        ResultSet rs;
        String select;
        String description;
        String  URL = "controller?command=doctorAppointment&caseRecordId=" + caseRecordId;

        try {
            con.setAutoCommit(false);
            if (req.getParameter("select1") == null & req.getParameter("select2") == null &
                    req.getParameter("select3") == null & req.getParameter("select4") == null &
                    req.getParameter("select5") == null & req.getParameter("select6") == null){
                return URL;
            }
                if (req.getParameter("select1") != null) {
                    select = req.getParameter("select1");
                    description = req.getParameter("description1");
                    System.out.println("type => " + select);
                    System.out.println("description => " + description);
                    addInTable(req, con, select, description);
                }
            if (req.getParameter("select2") != null) {
                select = req.getParameter("select2");
                description = req.getParameter("description2");
                System.out.println("type2 => " + select);
                System.out.println("description2 =>" + description);
                addInTable(req, con, select, description);
            }
            if (req.getParameter("select3") != null) {
                select = req.getParameter("select3");
                description = req.getParameter("description3");
                System.out.println("type3 => " + select);
                System.out.println("description3 =>" + description);
                addInTable(req, con, select, description);
            }
            if (req.getParameter("select4") != null) {
                select = req.getParameter("select4");
                description = req.getParameter("description4");
                System.out.println("type4 => " + select);
                System.out.println("description4 =>" + description);
                addInTable(req, con, select, description);
            }
            if (req.getParameter("select5") != null) {
                select = req.getParameter("select5");
                description = req.getParameter("description5");
                System.out.println("type5 => " + select);
                System.out.println("description5 =>" + description);
                addInTable(req, con, select, description);
            }
            if (req.getParameter("select6") != null) {
                select = req.getParameter("select6");
                description = req.getParameter("description6");
                System.out.println("type6 => " + select);
                System.out.println("description6 =>" + description);
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
            return "errorMessage/error.jsp";
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
        int patient_has_case_records_id = Integer.parseInt(req.getParameter("caseRecordId"));
        String path;
        Statement st;
        PreparedStatement ps;
        path = "SELECT * FROM patient_has_case_records WHERE id=" + patient_has_case_records_id;
        st = con.createStatement();
        ResultSet rs = st.executeQuery(path);
        int case_record_id = 0;
        while (rs.next()) {
            case_record_id = rs.getInt("case_record_id");
        }
        path = "INSERT INTO doctor_appointment (case_record_id,type,description,complete)" +
                " VALUES (?,?,?,?)";
        ps = con.prepareStatement(path);
        int k = 1;
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
