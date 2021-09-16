package com.ua.command.get;

import com.ua.ConnectionPool;
import com.ua.Utils.Constant;
import com.ua.command.Command;
import com.ua.entity.Department;
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
                    .executeQuery(Constant.SQL_SELECT_DOCTOR);
            List<Doctor> doctors = new ArrayList<>();
            while (rs.next()) {
                Doctor doctor = (Doctor) newElement(rs, "doctor");
                doctors.add(doctor);
                System.out.println(doctor);
            }
            List<Doctor> doctorsSortByName = new ArrayList<>(doctors);
            List<Doctor> doctorsSortByCategory = new ArrayList<>(doctorsSortByName);
            List<Doctor> doctorsSortByNumberPatient = new ArrayList<>(doctors);

            doctorsSortByName.sort(Comparator.comparing(Staff::getName));
            doctorsSortByCategory.sort(Comparator.comparing(Staff::getDepartment));
            doctorsSortByNumberPatient.sort(Comparator.comparingInt(o -> o.getCaseRecords().size()));

            List<Department> departments=new ArrayList<>();

            rs = con.createStatement().executeQuery(Constant.SQL_SELECT_DEPARTMENT);
            while (rs.next()) {
                Department department = new Department();
                department.setId(rs.getInt("id"));
                department.setDescription(rs.getString("department"));
                departments.add(department);
            }
            departments.sort(Comparator.comparing(Department::getDescription));
            System.out.println(doctors);
            session.setAttribute("departments",departments);
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
                return Constant.URL_ERROR_PAGE;
            }
        }
        return Constant.URL_CONTROLLER_VIEW_NURSE;
    }

    @Override
    public String execute(HttpServletRequest req, HttpServletResponse resp) {
        Connection con = null;
        try {
            con = ConnectionPool.getConnection();
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
        return execute(req, resp, con);
    }
}