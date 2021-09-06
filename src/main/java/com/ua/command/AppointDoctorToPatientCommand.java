package com.ua.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.*;

public class AppointDoctorToPatientCommand implements Command {
    @Override
    public String execute(HttpServletRequest req, HttpServletResponse resp, Connection con) {
        Statement st = null;
        try {
            int idDoctor = Integer.parseInt(req.getParameter("selectDoctor"));
            int idCaseRecord = Integer.parseInt(req.getParameter("selectPatient"));
            System.out.println("idDoctor => " + idDoctor);
            System.out.println("idCaseRecord => " + idCaseRecord);
            String path = "UPDATE patient_has_case_records SET doctor_id=" + idDoctor + " WHERE id=" + idCaseRecord;
            System.out.println(path);
            st = con.createStatement();
            st.execute(path);
        } catch (
                SQLException throwables) {
            throwables.printStackTrace();
        }finally {
            try {
                con.close();
            } catch (SQLException throwables) {
                throwables.printStackTrace();
            }
        }
        return "controller?command=viewStaff";
        }

        @Override
        public String execute (HttpServletRequest req, HttpServletResponse resp) throws SQLException {
            return null;
        }
    }
