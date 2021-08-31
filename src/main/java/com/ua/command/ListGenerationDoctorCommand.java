package com.ua.command;

import com.ua.entity.Doctor;
import com.ua.entity.Staff;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;

public class ListGenerationDoctorCommand implements Command {

    @Override
    public String execute(HttpServletRequest req, HttpServletResponse resp, Connection con) {
        HttpSession session = req.getSession();
        System.out.println("session ==> " + session);

        session.removeAttribute("doctorsByName");
        session.removeAttribute("doctorsByCategory");
        session.removeAttribute("doctorsByNumberPatient");

        try {
            System.out.println("con ==> " + con);
            ResultSet rs = con.createStatement()
                    .executeQuery("SELECT * FROM doctor");
            List<Doctor> doctors = new ArrayList<>();
            while (rs.next()) {
                Doctor doctor = newDoctor(rs, con);
                doctors.add(doctor);
            }
            List<Doctor> doctorsSortByName = new ArrayList<>(doctors);
            List<Doctor> doctorsSortByCategory = new ArrayList<>(doctors);
            List<Doctor> doctorsSortByNumberPatient = new ArrayList<>(doctors);
            System.out.println(doctorsSortByName);

            doctorsSortByName.sort(Comparator.comparing(Staff::getName));
            doctorsSortByCategory.sort(Comparator.comparing(Staff::getDepartment));
//            doctorsSortByNumberPatient.sort(Comparator.comparingInt(o -> o.getPatients().size()));

            session.setAttribute("doctorsByName", doctorsSortByName);
            session.setAttribute("doctorsByNumberPatient", doctorsSortByNumberPatient);

        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            try {
                con.close();
            } catch (SQLException throwables) {
                throwables.printStackTrace();
                return "errorMessage/error.jsp";
            }
        }
        System.out.println("users/doctorList.jsp");
        return "users/doctorList.jsp";
    }

    public static Doctor newDoctor(ResultSet rs, Connection con) throws SQLException {
        Doctor doctor = new Doctor();
        doctor.setId(rs.getInt("id"));
        if (rs.getString("name") != null) {
            doctor.setName(rs.getString("name"));
        }
        if (rs.getString("surname") != null) {
            doctor.setSurname(rs.getString("surname"));
        }

        if (rs.getString("telephone") != null) {
            doctor.setTelephone(rs.getString("telephone"));
        }
        if (rs.getString("department") != null) {
            doctor.setDepartment(rs.getString("department"));
        }
        if (rs.getString("passport") != null) {
            doctor.setPassport(rs.getString("passport"));
        }

        int login_password_id=rs.getInt("login_password_id");
        System.out.println(login_password_id);
        String search="SELECT * FROM login_password WHERE id=?";
        PreparedStatement ps= con.prepareStatement(search);
        ps.setInt(1,login_password_id);
        ResultSet rs2=ps.executeQuery();
        while (rs2.next()){
            if (rs2.getString("role") != null) {
                doctor.setRole(rs2.getString("role"));
            }
            if (rs2.getString("login") != null) {
                doctor.setLogin(rs2.getString("login"));
            }
            if (rs2.getString("password") != null) {
                doctor.setPassword(rs2.getString("password"));
            }
        }
        return doctor;
    }

    @Override
    public String execute(HttpServletRequest req, HttpServletResponse resp) {
        return null;
    }
}
