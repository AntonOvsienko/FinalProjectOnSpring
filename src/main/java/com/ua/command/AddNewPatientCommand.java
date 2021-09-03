package com.ua.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class AddNewPatientCommand implements Command {
    @Override
    public String execute(HttpServletRequest req, HttpServletResponse resp, Connection con) throws SQLException {
        con.setAutoCommit(false);
        PreparedStatement ps = null;
        Statement st = null;
        try {
            con.setAutoCommit(false);
            addAnketData(req, con);
            String lastPatientId = "SELECT MAX(id) FROM patient";
            st = con.createStatement();
            ResultSet rs = st.executeQuery(lastPatientId);
            int patientId = 0;
            while (rs.next()) {
                patientId = rs.getInt(1);
            }
            System.out.println("patientId => " + patientId);
            List<String>massivDiagnoses = createDiagnisList(req);
            for (int i = 0; i < massivDiagnoses.size(); i++) {
                addDiagnoses(con, st, patientId, massivDiagnoses.get(i));
            }
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
        return "users/newPatient.jsp";
    }

    private List<String> createDiagnisList(HttpServletRequest req) {
        List<String> list =new ArrayList<>();
        String initDiagnosis1 = req.getParameter("diagnosis1");
        list.add(initDiagnosis1);
        String initDiagnosis2 = null;
        if (req.getParameter("diagnosis2") != "") {
            initDiagnosis2 = req.getParameter("diagnosis2");
            list.add(initDiagnosis2);
        }
        String initDiagnosis3 = null;
        if (req.getParameter("diagnosis3") != "") {
            initDiagnosis3 = req.getParameter("diagnosis3");
            list.add(initDiagnosis3);
        }
        String initDiagnosis4 = null;
        if (req.getParameter("diagnosis4") != "") {
            initDiagnosis4 = req.getParameter("diagnosis4");
            list.add(initDiagnosis4);
        }
        String initDiagnosis5 = null;
        if (req.getParameter("diagnosis5") != "") {
            initDiagnosis5 = req.getParameter("diagnosis5");
            list.add(initDiagnosis5);
        }
        String initDiagnosis6 = null;
        if (req.getParameter("diagnosis6") != "") {
            initDiagnosis6 = req.getParameter("diagnosis6");
            list.add(initDiagnosis6);
        }
        return list;
    }

    private void addDiagnoses(Connection con, Statement st, int patientId, String diagnosis) throws SQLException {
        String initDiagnosis = diagnosis;
        PreparedStatement ps;
        ResultSet rs;
        String case_record = "INSERT INTO case_record (initial_diagnosis) VALUES ('" + initDiagnosis + "')";
        ps = con.prepareStatement(case_record);
        ps.executeUpdate();
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
    }

    private void addAnketData(HttpServletRequest req, Connection con) throws SQLException {
        PreparedStatement ps;
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
    }

    @Override
    public String execute(HttpServletRequest req, HttpServletResponse resp) {
        return "users/newPatient.jsp";
    }
}
