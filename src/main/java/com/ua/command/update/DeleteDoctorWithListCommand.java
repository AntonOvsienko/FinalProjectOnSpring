package com.ua.command.update;

import com.ua.Utils.Constant;
import com.ua.command.Command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*;

public class DeleteDoctorWithListCommand implements Command {
    @Override
    public String execute(HttpServletRequest req, HttpServletResponse resp, Connection con) {
        PreparedStatement ps = null;
        ResultSet rs = null;
        int idLogin = 0;
        int idDoctor = Integer.parseInt(req.getParameter("select"));
        try {
            ps = con.prepareStatement(Constant.SQL_SELECT_DOCTOR_WHERE_ID);
            ps.setInt(1,idDoctor);
            rs = ps.executeQuery();
            while (rs.next()) {
                idLogin = rs.getInt("login_password_id");
            }
            ps=con.prepareStatement(Constant.SQL_LOGIN_PASSWORD_DELETE);
            int k=1;
            ps.setInt(k++,idLogin);
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
