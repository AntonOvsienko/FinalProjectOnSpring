package com.ua.command;

import com.ua.ConnectionPool;
import com.ua.entity.Doctor;
import com.ua.entity.DoctorAppointment;
import com.ua.entity.Patient;
import com.ua.entity.Staff;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


import static com.ua.Utils.createElement.newElement;

public class DoctorAppointmentListCommand implements Command {
    @Override
    public String execute(HttpServletRequest req, HttpServletResponse resp, Connection con) {
        HttpSession session = req.getSession();
        System.out.println("session ==> " + session);
        PreparedStatement ps = null;
        ResultSet rs = null;
        ResultSet rs2 = null;
        Doctor doctor = new Doctor();
        Patient patient = new Patient();
        List<DoctorAppointment> doctorAppointmentList = new ArrayList<>();
        try {
            int caseRecordId;
            if (req.getParameter("caseRecordId") != null) {
                caseRecordId = Integer.parseInt(req.getParameter("caseRecordId"));
                session.setAttribute("caseRecordId", caseRecordId);
            } else {
                caseRecordId = (int) session.getAttribute("caseRecordId");
            }
            String path = "SELECT * FROM patient_has_case_records WHERE id=" + caseRecordId;
            System.out.println("caseRecordId => " + caseRecordId);
            ps = con.prepareStatement(path);
            rs = ps.executeQuery();
            while (rs.next()) {
                int idDoctor = rs.getInt("doctor_id");
                int idPatient = rs.getInt("patient_id");
                int idCaseRecord = rs.getInt("case_record_id");
                path = "SELECT * FROM doctor WHERE id=" + idDoctor;
                ps = con.prepareStatement(path);
                rs2 = ps.executeQuery();
                while (rs2.next()) {
                    doctor = (Doctor) newElement(rs2, "doctor");
                    System.out.println(doctor);
                }
                path = "SELECT * FROM patient WHERE id=" + idPatient;
                ps = con.prepareStatement(path);
                rs2 = ps.executeQuery();
                while (rs2.next()) {
                    patient = (Patient) newElement(rs2, "patient");
                    System.out.println(patient);
                }
                path = "SELECT * FROM doctor_appointment WHERE case_record_id=" + idCaseRecord;
                ps = con.prepareStatement(path);
                rs2 = ps.executeQuery();
                while (rs2.next()) {
                    DoctorAppointment da = new DoctorAppointment();
                    da.setId(rs2.getInt("id"));
                    da.setType(rs2.getString("type"));
                    da.setDescription(rs2.getString("description"));
                    da.setComplete(rs2.getString("complete"));
                    da.setNameStaffComplete(rs2.getString("name_staff_complete"));
                    doctorAppointmentList.add(da);
                }
            }
            session.setAttribute("appointmentList", doctorAppointmentList);
            session.setAttribute("doctor", doctor);
            session.setAttribute("patient", patient);
        } catch (SQLException throwables) {
            throwables.printStackTrace();
            return "errorMessage/error.jsp";
        } finally {
            try {
                con.close();
            } catch (SQLException throwables) {
                throwables.printStackTrace();
            }
        }
        return "users/patient.jsp";
    }

    @Override
    public String execute(HttpServletRequest req, HttpServletResponse resp) throws SQLException {
        return execute(req, resp, ConnectionPool.getInstance().getConnection());
    }
}
