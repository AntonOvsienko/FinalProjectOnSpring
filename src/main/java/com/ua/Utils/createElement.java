package com.ua.Utils;

import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.Date;

import com.ua.entity.*;

import java.sql.*;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class createElement {

    public static Staff newElement(ResultSet rs, Connection con, String role) throws SQLException {
        Staff user = null;
        if (role.equals("doctor")) {
            user = new Doctor();
            if (rs.getString("department") != null) {
                user.setDepartment(rs.getString("department"));
            }
            getStandartFields(rs, user);
            getlogin_password(rs, con, user);
        }
        if (role.equals("patient")) {
            user = new Patient();
            getStandartFields(rs, user);
            getAge(rs, (Patient) user);
            getDiagnosesList(rs, (Patient) user, con);
        }
        if (role.equals("nurse")) {
            user = new Nurse();
            getlogin_password(rs, con, user);
            getStandartFields(rs, user);
        }

        return user;
    }

    private static void getDiagnosesList(ResultSet rs, Patient user, Connection con) {
        Statement st = null;
        ResultSet rs2;
        try {
            int patient_id = rs.getInt("id");
            List<Integer> id = new ArrayList<>();
            String caseId = "SELECT * FROM patient_has_case_records WHERE patient_id=" + patient_id;
            st = con.createStatement();
            rs2 = st.executeQuery(caseId);
            while (rs2.next()) {
                id.add(rs2.getInt("case_record_id"));
            }
            System.out.println(id);
            for (int i = 0; i < id.size(); i++) {
                String diagnosesId = "SELECT * FROM case_record WHERE id=" + id.get(i);
                st = con.createStatement();
                rs2 = st.executeQuery(diagnosesId);
                while (rs2.next()) {
                    CaseRecord caseString = new CaseRecord(rs2.getString("initial_diagnosis"));
                    user.getCaseRecords().add(caseString);
                }
            }
            System.out.println(user.getCaseRecords());
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        } finally {
            try {
                con.close();
            } catch (SQLException throwables) {
                throwables.printStackTrace();
            }
        }
    }

    private static void getAge(ResultSet rs, Patient user) {
        try {
            String date = rs.getDate("birthdate").toString();
            String dateParser = "([0-9]+)-([0-9]+)-([0-9]+)";
            Pattern pattern = Pattern.compile(dateParser);
            Matcher matcher = pattern.matcher(date);
            while (matcher.find()) {
                user.setYearBorn(Integer.parseInt(matcher.group(1)));
                user.setMonthBorn(Integer.parseInt(matcher.group(2)));
                user.setDayBorn(Integer.parseInt(matcher.group(3)));
            }
            LocalDate start = LocalDate.of(user.getYearBorn(), user.getMonthBorn(), user.getDayBorn());
            LocalDate end = LocalDate.now();
            long years = ChronoUnit.YEARS.between(start, end);
            user.setYears(years);
            System.out.println("age = " + years);
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
    }

    private static void getStandartFields(ResultSet rs, Staff user) throws SQLException {
        user.setId(rs.getInt("id"));
        if (rs.getString("name") != null) {
            System.out.println(rs.getString("name"));
            user.setName(rs.getString("name"));
            System.out.println(user.getName());
        }
        if (rs.getString("surname") != null) {
            System.out.println(rs.getString("surname"));
            user.setSurname(rs.getString("surname"));
            System.out.println(user.getSurname());
        }
        if (rs.getString("telephone") != null) {
            System.out.println(rs.getString("telephone"));
            user.setTelephone(rs.getString("telephone"));
            System.out.println(user.getTelephone());
        }
        if (rs.getString("passport") != null) {
            System.out.println(rs.getString("passport"));
            user.setPassport(rs.getString("passport"));
            System.out.println(user.getPassport());
        }
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
