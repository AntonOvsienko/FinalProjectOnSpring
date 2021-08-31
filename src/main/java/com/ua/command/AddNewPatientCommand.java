package com.ua.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class AddNewPatientCommand implements Command {
    @Override
    public String execute(HttpServletRequest req, HttpServletResponse resp, Connection con) throws SQLException {
        con.setAutoCommit(false);
        PreparedStatement ps = null;
        try {
            String nameSet = req.getParameter("name");
            String surnameSet = req.getParameter("surname");
            String passportSet = req.getParameter("passport");
            String telephoneSet = req.getParameter("telephone");
            System.out.println("name-" + nameSet
                    + "\nsurname-" + surnameSet
                    + "\npassport-" + passportSet
                    + "\ntelephone-" + telephoneSet);
            String patient = "INSERT INTO patient (name,surname,passport,telephone)" +
                    " VALUES (?,?,?,?) ";
            ps.setString(1,nameSet);
            ps.setString(2,surnameSet);
            ps.setString(3,passportSet);
            ps.setString(4,telephoneSet);
            ps.executeQuery(patient);
            String patientCase = "INSERT INTO patient_has_case-records " +
                    "(patient_id) VALUES (?,?,?,?)";
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        } finally {
            try {
                con.close();
            } catch (SQLException throwables) {
                throwables.printStackTrace();
            }
        }
        return "users/admin.jsp";
    }

    @Override
    public String execute(HttpServletRequest req, HttpServletResponse resp) {
        return "users/newPatient.jsp";
    }
}
