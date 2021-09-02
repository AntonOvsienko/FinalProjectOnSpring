package com.ua.Utils;

import com.ua.entity.Doctor;
import com.ua.entity.Nurse;
import com.ua.entity.Patient;
import com.ua.entity.Staff;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class createElement {

    public static Staff newElement(ResultSet rs, Connection con, String role) throws SQLException {
        Staff user=null;
        if (role.equals("doctor")){
            user = new Doctor();
            if (rs.getString("department") != null) {
                user.setDepartment(rs.getString("department"));
            }
            getlogin_password(rs, con, user);
        }
        if (role.equals("patient")){
            user = new Patient();
        }
        if (role.equals("nurse")){
            user = new Nurse();
            getlogin_password(rs, con, user);
        }

        user.setId(rs.getInt("id"));
        if (rs.getString("name") != null) {
            user.setName(rs.getString("name"));
        }
        if (rs.getString("surname") != null) {
            user.setSurname(rs.getString("surname"));
        }
        if (rs.getString("telephone") != null) {
            user.setTelephone(rs.getString("telephone"));
        }
        if (rs.getString("passport") != null) {
            user.setPassport(rs.getString("passport"));
        }

        return user;
    }

    public static void getlogin_password(ResultSet rs, Connection con, Staff user) throws SQLException {
        if (rs.getString("login_password_id") != null) {
            int login_password_id = rs.getInt("login_password_id");
            System.out.println(login_password_id);
            String search = "SELECT * FROM login_password WHERE id=?";
            PreparedStatement ps = con.prepareStatement(search);
            ps.setInt(1, login_password_id);
            ResultSet rs2 = ps.executeQuery();
            while (rs2.next()) {
                if (rs2.getString("role") != null) {
                    user.setRole(rs2.getString("role"));
                }
                if (rs2.getString("login") != null) {
                    user.setLogin(rs2.getString("login"));
                }
                if (rs2.getString("password") != null) {
                    user.setPassword(rs2.getString("password"));
                }
            }
        }
    }
}
