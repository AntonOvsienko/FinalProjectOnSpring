package com.ua.command.get;

import com.ua.ConnectionPool;
import com.ua.Utils.Constant;
import com.ua.command.Command;
import com.ua.entity.Doctor;
import com.ua.entity.DoctorAppointment;
import com.ua.entity.Patient;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


import static com.ua.Utils.CreateElement.newElement;

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
            ps = con.prepareStatement(Constant.SQL_APPOINTMENT_SELECT);
            ps.setInt(1, caseRecordId);
            rs = ps.executeQuery();
            while (rs.next()) {
                int idDoctor = rs.getInt("doctor_id");
                int idPatient = rs.getInt("patient_id");
                int idCaseRecord = rs.getInt("case_record_id");
                ps = con.prepareStatement(Constant.SQL_SELECT_DOCTOR_WHERE_ID);
                ps.setInt(1, idDoctor);
                rs2 = ps.executeQuery();
                while (rs2.next()) {
                    doctor = (Doctor) newElement(rs2, "doctor");
                }
                ps = con.prepareStatement(Constant.SQL_SELECT_PATIENT_WHERE_ID);
                ps.setInt(1,idPatient);
                rs2 = ps.executeQuery();
                while (rs2.next()) {
                    patient = (Patient) newElement(rs2, "patient");
                }
                ps = con.prepareStatement(Constant.SQL_SELECT_DOCTOR_APPOINTMENT_WHERE_CASERECORDS_ID);
                ps.setInt(1,idCaseRecord);
                rs2 = ps.executeQuery();
                while (rs2.next()) {
                    DoctorAppointment da = new DoctorAppointment();
                    daCreate(rs2, da);
                    doctorAppointmentList.add(da);
                }
            }
            session.setAttribute("appointmentList", doctorAppointmentList);
            session.setAttribute("doctor", doctor);
            session.setAttribute("patient", patient);
        } catch (SQLException throwables) {
            throwables.printStackTrace();
            return Constant.URL_ERROR_PAGE;
        } finally {
            try {
                con.close();
            } catch (SQLException throwables) {
                throwables.printStackTrace();
            }
        }
        return Constant.URL_CONTROLLER_VIEW_CASERECORD;
    }

    private void daCreate(ResultSet rs2, DoctorAppointment da) throws SQLException {
        da.setId(rs2.getInt("id"));
        da.setType(rs2.getString("type"));
        da.setDescription(rs2.getString("description"));
        da.setComplete(rs2.getString("complete"));
        da.setNameStaffComplete(rs2.getString("name_staff_complete"));
    }

    @Override
    public String execute(HttpServletRequest req, HttpServletResponse resp) throws SQLException {
        return execute(req, resp, ConnectionPool.getConnection());
    }
}