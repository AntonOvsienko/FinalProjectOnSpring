package com.ua.command.update;

import com.ua.Utils.Constant;
import com.ua.command.Command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*;

public class AppointDoctorToPatientCommand implements Command {
    @Override
    public String execute(HttpServletRequest req, HttpServletResponse resp, Connection con) {
        PreparedStatement ps = null;
        try {
            int idDoctor = Integer.parseInt(req.getParameter("selectDoctor"));
            int idCaseRecord = Integer.parseInt(req.getParameter("selectPatient"));
            ps = con.prepareStatement(Constant.SQL_UPDATE_PATIENT_CASERECORDS);
            int k=1;
            ps.setInt(k++,idDoctor);
            ps.setInt(k++,idCaseRecord);
            ps.executeUpdate();
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
        return Constant.URL_CONTROLLER_VIEW_STAFF;
        }

        @Override
        public String execute (HttpServletRequest req, HttpServletResponse resp) throws SQLException {
            return null;
        }
    }
