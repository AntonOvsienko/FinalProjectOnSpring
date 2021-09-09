package com.ua.command;

import com.ua.ConnectionPool;
import com.ua.entity.CaseRecord;
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

public class ListGenerationNurseCommand implements Command {
    @Override
    public String execute(HttpServletRequest req, HttpServletResponse resp, Connection con) throws SQLException {
        HttpSession session = req.getSession();
        System.out.println("session ==> " + session);

        PreparedStatement ps = null;
        ResultSet rs = null;
        ResultSet rs2 = null;
        List<CaseRecord> nurseCaseRecord = new ArrayList<>();
        try {
            String path = "SELECT * FROM patient_has_case_records";
            ps = con.prepareStatement(path);
            rs = ps.executeQuery();
            while (rs.next()) {
                List<DoctorAppointment> doctorAppointmentList = new ArrayList<>();
                Doctor doctor = new Doctor();
                Patient patient = new Patient();
                CaseRecord caseRecord = new CaseRecord();
                int patientId = rs.getInt("patient_id");
                int caseRecordId = rs.getInt("case_record_id");
                int doctorId = rs.getInt("doctor_id");
                path = "SELECT * FROM doctor WHERE id=" + doctorId;
                System.out.println(path);
                ps = con.prepareStatement(path);
                rs2 = ps.executeQuery();
                while (rs2.next()) {
                    doctor.setName(rs2.getString("name"));
                    doctor.setSurname(rs2.getString("surname"));
                }
                path = "SELECT * FROM patient WHERE id=" + patientId;
                ps = con.prepareStatement(path);
                rs2 = ps.executeQuery();
                while (rs2.next()) {
                    patient.setName(rs2.getString("name"));
                    patient.setSurname(rs2.getString("surname"));
                }
                path = "SELECT * FROM doctor_appointment WHERE case_record_id=" + caseRecordId;
                ps = con.prepareStatement(path);
                rs2 = ps.executeQuery();
                while (rs2.next()) {
                    DoctorAppointment da = new DoctorAppointment();
                    da.setId(rs2.getInt("id"));
                    da.setType(rs2.getString("type"));
                    da.setDescription(rs2.getString("description"));
                    da.setNameStaffComplete(rs2.getString("name_staff_complete"));
                    da.setComplete(rs2.getString("complete"));
                    if (da.getType().equals("Приём лекарств") | da.getType().equals("Подготовка к операции")) {
                        doctorAppointmentList.add(da);
                    }
                }
                path = "SELECT * FROM case_record WHERE id=" + rs.getInt("id");
                ps = con.prepareStatement(path);
                rs2 = ps.executeQuery();
                while (rs2.next()) {
                    caseRecord.setInitialDiagnosis(rs2.getString("initial_diagnosis"));
                    }
                caseRecord.setId(rs.getInt("id"));
                caseRecord.setDoctor(doctor);
                caseRecord.setPatient(patient);
                caseRecord.setDoctorAppointmentList(doctorAppointmentList);
                nurseCaseRecord.add(caseRecord);
            }
            session.setAttribute("appointmentList", nurseCaseRecord);
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
//        try {
//            String path = "SELECT * FROM doctor_appointment";
//            ps = con.prepareStatement(path);
//            rs = ps.executeQuery();
//            while (rs.next()) {
//                DoctorAppointment da = new DoctorAppointment();
//                da.setId(rs.getInt("id"));
//                da.setType(rs.getString("type"));
//                da.setDescription(rs.getString("description"));
//                da.setComplete(rs.getString("complete"));
//                da.setNameStaffComplete(rs.getString("name_staff_complete"));
//                if (da.getType().equals("Приём лекарств") | da.getType().equals("Подготовка к операции")) {
//                    nurseAppointmentList.add(da);
//                }
//            }
//            session.setAttribute("appointmentList", nurseAppointmentList);
//        } catch (SQLException throwables) {
//            throwables.printStackTrace();
//            return "errorMessage/error.jsp";
//        } finally {
//            try {
//                con.close();
//            } catch (SQLException throwables) {
//                throwables.printStackTrace();
//            }
//        }
        return (String) session.getAttribute("finalAddress");
    }

    @Override
    public String execute(HttpServletRequest req, HttpServletResponse resp) throws SQLException {
        Connection con = null;
        try {
            con = ConnectionPool.getInstance().getConnection();
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
        return execute(req, resp, con);
    }
}
