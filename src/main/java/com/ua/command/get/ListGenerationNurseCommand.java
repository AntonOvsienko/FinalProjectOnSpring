package com.ua.command.get;

import com.ua.ConnectionPool;
import com.ua.Utils.Constant;
import com.ua.command.Command;
import com.ua.entity.Department;
import com.ua.entity.Doctor;
import com.ua.entity.Nurse;
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

public class ListGenerationNurseCommand implements Command {

    @Override
    public String execute(HttpServletRequest req, HttpServletResponse resp, Connection con) {
        HttpSession session = req.getSession();
        System.out.println("session ==> " + session);

        try {
            System.out.println("con ==> " + con);
            ResultSet rs = con.createStatement()
                    .executeQuery(Constant.SQL_SELECT_NURSE);
            List<Nurse> nurses = new ArrayList<>();
            while (rs.next()) {
                Nurse nurse = (Nurse) newElement(rs, "nurse");
                nurses.add(nurse);
            }
            nurses.sort(Comparator.comparing(Staff::getName));
            session.setAttribute("nurses",nurses);
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
        return Constant.URL_CONTROLLER_VIEW_PATIENT;
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
