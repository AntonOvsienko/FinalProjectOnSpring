package com.ua.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*;

public class AddNewPatientCommand implements Command {
    @Override
    public String execute(HttpServletRequest req, HttpServletResponse resp, Connection con) throws SQLException {
        con.setAutoCommit(false);
        PreparedStatement ps = null;
        Statement st = null;
        try {
            con.setAutoCommit(false);
            String nameSet = req.getParameter("name");
            String surnameSet = req.getParameter("surname");
            String passportSet = req.getParameter("passport");
            String telephoneSet = req.getParameter("telephone");
            String dataBirthdaySet = req.getParameter("date");
            System.out.println("name-" + nameSet
                    + "\nsurname-" + surnameSet
                    + "\npassport-" + passportSet
                    + "\ndataBirthday-" + dataBirthdaySet
                    + "\ntelephone-" + telephoneSet);
            String patient = "INSERT INTO patient (name,surname,passport,telephone,birthdate)" +
                    " VALUES (?,?,?,?,?)";
            ps = con.prepareStatement(patient);
            ps.setString(1, nameSet);
            ps.setString(2, surnameSet);
            ps.setString(3, passportSet);
            ps.setString(4, telephoneSet);
            ps.setString(5, dataBirthdaySet);
            ps.executeUpdate();
            String case_record = "INSERT INTO case_record (text) VALUES (null)";
            ps = con.prepareStatement(case_record);
            ps.executeUpdate();
            String lastPatientId = "SELECT MAX(id) FROM patient";
            st = con.createStatement();
            ResultSet rs = st.executeQuery(lastPatientId);
            int patientId = 0;
            while (rs.next()) {
                patientId = rs.getInt(1);
            }
            System.out.println("patientId => " + patientId);
            String lastCaseId = "SELECT MAX(id) FROM case_record";
            rs = st.executeQuery(lastCaseId);
            int caseId = 0;
            while (rs.next()) {
                caseId = rs.getInt(1);
            }
            System.out.println("caseId => " + caseId);
            String patientCase = "INSERT INTO patient_has_case_records " +
                    "(patient_id,case_record_id) VALUES (?,?)";
            ps = con.prepareStatement(patientCase);
            ps.setInt(1, patientId);
            ps.setInt(2, caseId);
            ps.executeUpdate();
            con.commit();
        } catch (SQLException throwables) {
            con.rollback();
            throwables.printStackTrace();
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
        return "users/newPatient.jsp";
    }
}
