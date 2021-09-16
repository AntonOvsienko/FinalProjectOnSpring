package com.ua.command.get;

import com.ua.ConnectionPool;
import com.ua.Utils.Constant;
import com.ua.command.Command;
import com.ua.entity.Patient;
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

public class ListGenerationPatientCommand implements Command {

    @Override
    public String execute(HttpServletRequest req, HttpServletResponse resp, Connection con){
        HttpSession session = req.getSession();
        System.out.println("session ==> " + session);

        try {
            System.out.println("con ==> " + con);
            ResultSet rs = con.createStatement()
                    .executeQuery(Constant.SQL_SELECT_PATIENT);
            List<Patient> patients = new ArrayList<>();
            while (rs.next()) {
                Patient patient = (Patient) newElement(rs, "patient");
                patients.add(patient);
            }
            List<Patient> patientsSortByName = new ArrayList<>(patients);
            List<Patient> patientsSortByBirthday = new ArrayList<>(patients);

            patientsSortByName.sort(Comparator.comparing(Staff::getName));
            patientsSortByBirthday.sort((o1, o2) -> {
                if (o1.getYearBorn() < o2.getYearBorn()) {
                    return 1;
                }
                if (o1.getYearBorn() > o2.getYearBorn()) {
                    return -1;
                }
                if (o1.getMonthBorn() < o2.getMonthBorn()) {
                    return 1;
                }
                if (o1.getMonthBorn() > o2.getMonthBorn()) {
                    return -1;
                }
                if (o1.getDayBorn() < o2.getDayBorn()) {
                    return 1;
                }
                if (o1.getDayBorn() > o2.getDayBorn()) {
                    return -1;
                }
                return 0;
            });

            session.setAttribute("patients", patients);
            session.setAttribute("patientsByName", patientsSortByName);
            session.setAttribute("patientsByBirthday", patientsSortByBirthday);
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
        return Constant.URL_CONTROLLER_VIEW_CASERECORD;
    }

    @Override
    public String execute(HttpServletRequest req, HttpServletResponse resp) {
        Connection con= null;
        try {
            con = ConnectionPool.getConnection();
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
        return execute(req,resp,con);
    }
}