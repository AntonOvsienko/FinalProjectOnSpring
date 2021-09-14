package com.ua.command.Get;

import com.ua.ConnectionPool;
import com.ua.command.Command;
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
        ResultSet rs3 = null;
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
                ps = con.prepareStatement(path);
                rs2 = ps.executeQuery();
                while (rs2.next()) {
                    int login_password=rs2.getInt("login_password_id");
                    doctor.setId(doctorId);
                    doctor.setName(rs2.getString("name"));
                    doctor.setSurname(rs2.getString("surname"));
                    doctor.setDepartment(rs2.getString("department"));
                    doctor.setPassport(rs2.getString("passport"));
                    doctor.setTelephone(rs2.getString("telephone"));
                    path = "SELECT * FROM login_password WHERE id=" + login_password;
                    ps = con.prepareStatement(path);
                    rs3 = ps.executeQuery();
                    while (rs3.next()) {
                        doctor.setLogin(rs3.getString("login"));
                    }
                }
                path = "SELECT * FROM patient WHERE id=" + patientId;
                ps = con.prepareStatement(path);
                rs2 = ps.executeQuery();
                while (rs2.next()) {
                    patient.setId(patientId);
                    patient.setName(rs2.getString("name"));
                    patient.setSurname(rs2.getString("surname"));
                    patient.setPassport(rs2.getString("passport"));
                    patient.setTelephone(rs2.getString("telephone"));
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
//                    if (da.getType().equals("Приём лекарств") | da.getType().equals("Подготовка к операции")) {
                        doctorAppointmentList.add(da);
//                    }
                }
                path = "SELECT * FROM case_record WHERE id=" + caseRecordId;
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
            session.setAttribute("caseRecordList", nurseCaseRecord);
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
