package com.ua.command;

import com.ua.ConnectionPool;
import com.ua.Utils.Constant;
import com.ua.entity.DoctorAppointment;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ListArchiveAppointmentCommand implements Command {
    @Override
    public String execute(HttpServletRequest req, HttpServletResponse resp, Connection con){
        PreparedStatement ps = null;
        ResultSet rs = null;
        HttpSession session = req.getSession();
        System.out.println("session ==> " + session);
        List<DoctorAppointment> doctorAppointments=new ArrayList<>();
        int id=Integer.parseInt(req.getParameter("appointmentId"));
        try {
            ps=con.prepareStatement("SELECT * FROM doctor_appointment_archive WHERE case_record_archive_id=?");
            ps.setInt(1,id);
            rs=ps.executeQuery();
            while (rs.next()){
                DoctorAppointment da=new DoctorAppointment();
                da.setNameStaffComplete(rs.getString("name_staff_complete"));
                da.setDescription(rs.getString("description"));
                da.setType(rs.getString("type"));
                doctorAppointments.add(da);
            }
            session.setAttribute("doctorAppointments",doctorAppointments);
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        } finally{
            try {
                con.close();
            } catch (SQLException throwables) {
                throwables.printStackTrace();
            }
        }
        return "users/doctorAppointmentArchive.jsp";
    }

    @Override
    public String execute(HttpServletRequest req, HttpServletResponse resp){
        try {
            return execute(req,resp, ConnectionPool.getConnection());
        } catch (SQLException throwables) {
            throwables.printStackTrace();
            return Constant.URL_ERROR_PAGE;
        }
    }
}
