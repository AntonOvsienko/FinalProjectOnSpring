package com.ua.command.Get;

import com.ua.ConnectionPool;
import com.ua.command.Command;
import com.ua.entity.Doctor;
import com.ua.entity.Staff;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;

import static com.ua.Utils.CreateElement.newElement;

public class ListGenerationDoctorCommand implements Command {

    @Override
    public String execute(HttpServletRequest req, HttpServletResponse resp, Connection con) {
        HttpSession session = req.getSession();
        System.out.println("session ==> " + session);

        try {
            System.out.println("con ==> " + con);
            ResultSet rs = con.createStatement()
                    .executeQuery("SELECT * FROM doctor");
            List<Doctor> doctors = new ArrayList<>();
            while (rs.next()) {
                Doctor doctor = (Doctor) newElement(rs, "doctor");
                doctors.add(doctor);
            }
            List<Doctor> doctorsSortByName = new ArrayList<>(doctors);
            List<Doctor> doctorsSortByCategory = new ArrayList<>(doctorsSortByName);
            List<Doctor> doctorsSortByNumberPatient = new ArrayList<>(doctors);

            doctorsSortByName.sort(Comparator.comparing(Staff::getName));
            doctorsSortByCategory.sort(Comparator.comparing(Staff::getDepartment));
            doctorsSortByNumberPatient.sort(Comparator.comparingInt(o -> o.getCaseRecords().size()));

            session.setAttribute("doctors", doctors);
            session.setAttribute("doctorsByCategory", doctorsSortByCategory);
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
        return "controller?command=viewPatient";
    }

    @Override
    public String execute(HttpServletRequest req, HttpServletResponse resp) {
        Connection con = null;
        try {
            con = ConnectionPool.getInstance().getConnection();
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
        return execute(req, resp, con);
    }
}
