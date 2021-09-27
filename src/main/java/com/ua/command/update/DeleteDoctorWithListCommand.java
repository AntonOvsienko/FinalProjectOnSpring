package com.ua.command.update;

import com.ua.Utils.Constant;
import com.ua.command.Command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DeleteDoctorWithListCommand implements Command {
    @Override
    public String execute(HttpServletRequest req, HttpServletResponse resp, Connection con) {
        PreparedStatement ps = null;
        ResultSet rs = null;
        String loginDoctor = req.getParameter("loginDoctor");
        System.out.println("Delete =>" + loginDoctor);
        try {
            ps=con.prepareStatement(Constant.SQL_LOGIN_PASSWORD_DELETE_WHERE_LOGIN);
            int k=1;
            ps.setString(k++,loginDoctor);
            ps.executeUpdate();
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        } finally {
            try {
                con.close();
            } catch (SQLException throwables) {
                throwables.printStackTrace();
            }
        }
        return Constant.URL_CONTROLLER_VIEW_STAFF;
    }

    @Override
    public String execute(HttpServletRequest req, HttpServletResponse resp) {
        return null;
    }
}
