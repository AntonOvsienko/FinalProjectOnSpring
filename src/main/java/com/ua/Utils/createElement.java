package com.ua.Utils;

import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;

import com.ua.ConnectionPool;
import com.ua.entity.*;

import java.sql.*;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class createElement {

    public static Staff newElement(ResultSet rs, String role) {
        Staff user = null;
        try {
            if (role.equals("doctor")) {
                user = new Doctor();
                if (rs.getString("department") != null) {
                    user.setDepartment(rs.getString("department"));
                }
                getLoginPassword(rs, ConnectionPool.getInstance().getConnection(), user);
                getStandartFields(rs, user);
                getCaseRecordDoctor(ConnectionPool.getInstance().getConnection(), user, user.getId());
            }
            if (role.equals("patient")) {
                user = new Patient();
                getAge(rs, (Patient) user);
                getStandartFields(rs, user);
//                getDiagnosesList(user.getId(), (Patient) user, ConnectionPool.getInstance().getConnection());
                getCaseRecordPatient(ConnectionPool.getInstance().getConnection(), user, user.getId());
            }
            if (role.equals("nurse")) {
                user = new Nurse();

                getLoginPassword(rs, ConnectionPool.getInstance().getConnection(), user);
                getStandartFields(rs, user);

            }
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
        return user;
    }

    private static void getCaseRecordPatient(Connection connection, Staff user, int patient_id) {
        Statement st = null;
        ResultSet rs1 = null;
        ResultSet rs2 = null;
        List<CaseRecord> caseRecords = new ArrayList<>();
        try {
            String path = "SELECT * FROM patient_has_case_records WHERE patient_id=" + patient_id;
            System.out.println(path);
            st = connection.createStatement();
            rs1 = st.executeQuery(path);
            int id = 0;
            int doctor_id = 0;
            int case_record_id = 0;
            while (rs1.next()) {
                id = rs1.getInt("id");
                doctor_id = rs1.getInt("doctor_id");
                path = "SELECT * FROM doctor WHERE id=" + doctor_id;
                System.out.println(path);
                Doctor doctor = null;
                st = connection.createStatement();
                rs2 = st.executeQuery(path);
                while (rs2.next()) {
                    String name = rs2.getString("name");
                    String surname = rs2.getString("surname");
                    String department = rs2.getString("department");
                    doctor = new Doctor(name, surname, department);
                }
                path = "SELECT * FROM patient WHERE id=" + patient_id;
                System.out.println(path);
                Patient patient = null;
                st = connection.createStatement();
                rs2 = st.executeQuery(path);
                while (rs2.next()) {
                    String name = rs2.getString("name");
                    String surname = rs2.getString("surname");
                    patient = new Patient(name, surname);
                }
                case_record_id = rs1.getInt("case_record_id");
                String initialDiagnosis = "";
                String path2 = "SELECT * FROM case_record WHERE id=" + case_record_id;
                System.out.println(path2);
                st = connection.createStatement();
                rs2 = st.executeQuery(path2);
                while (rs2.next()) {
                    initialDiagnosis = rs2.getString("initial_diagnosis");
                }
                caseRecords.add(new CaseRecord(id, doctor, patient, initialDiagnosis));
            }
            user.setCaseRecords(caseRecords);
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        } finally {
            try {
                connection.close();
            } catch (SQLException throwables) {
                throwables.printStackTrace();
            }
        }
    }

    private static void getCaseRecordDoctor(Connection connection, Staff user, int doctorId) {
        Statement st = null;
        ResultSet rs1 = null;
        ResultSet rs2 = null;
        List<CaseRecord> caseRecords = new ArrayList<>();
        try {
            String path = "SELECT * FROM patient_has_case_records WHERE doctor_id=" + doctorId;
            System.out.println(path);
            st = connection.createStatement();
            rs1 = st.executeQuery(path);
            int id = 0;
            int patient_id = 0;
            int case_record_id = 0;
            while (rs1.next()) {
                id = rs1.getInt("id");
                patient_id = rs1.getInt("patient_id");
                path = "SELECT * FROM patient WHERE id=" + patient_id;
                Patient patient = null;
                st = connection.createStatement();
                rs2 = st.executeQuery(path);
                while (rs2.next()) {
                    String name = rs2.getString("name");
                    String surname = rs2.getString("surname");
                    patient = new Patient(name, surname);
                }
                path = "SELECT * FROM doctor WHERE id=" + doctorId;
                Doctor doctor = null;
                st = connection.createStatement();
                rs2 = st.executeQuery(path);
                while (rs2.next()) {
                    String name = rs2.getString("name");
                    String surname = rs2.getString("surname");
                    String department = rs2.getString("department");
                    doctor = new Doctor(name, surname, department);
                }
                case_record_id = rs1.getInt("case_record_id");
                String initialDiagnosis = "";
                String path2 = "SELECT * FROM case_record WHERE id=" + case_record_id;
                System.out.println(path2);
                st = connection.createStatement();
                rs2 = st.executeQuery(path2);
                while (rs2.next()) {
                    initialDiagnosis = rs2.getString("initial_diagnosis");
                }
                caseRecords.add(new CaseRecord(id, doctor, patient, initialDiagnosis));
            }
            user.setCaseRecords(caseRecords);

        } catch (SQLException throwables) {
            throwables.printStackTrace();
        } finally {
            try {
                connection.close();
            } catch (SQLException throwables) {
                throwables.printStackTrace();
            }
        }
    }

//    private static void getDiagnosesList(int patient_id, Patient user, Connection con) {
//        Statement st = null;
//        ResultSet rs2;
//        try {
//            List<Integer> id = new ArrayList<>();
//            String caseId = "SELECT * FROM patient_has_case_records WHERE patient_id=" + patient_id;
//            st = con.createStatement();
//            rs2 = st.executeQuery(caseId);
//            while (rs2.next()) {
//                id.add(rs2.getInt("case_record_id"));
//            }
//            System.out.println(id);
//            for (int i = 0; i < id.size(); i++) {
//                String diagnosesId = "SELECT * FROM case_record WHERE id=" + id.get(i);
//                st = con.createStatement();
//                rs2 = st.executeQuery(diagnosesId);
//                while (rs2.next()) {
//                    CaseRecord caseString = new CaseRecord(rs2.getInt("id"), rs2.getString("initial_diagnosis"));
//                    user.getCaseRecords().add(caseString);
//                }
//            }
//            System.out.println(user.getCaseRecords());
//        } catch (SQLException throwables) {
//            throwables.printStackTrace();
//        } finally {
//            try {
//                con.close();
//            } catch (SQLException throwables) {
//                throwables.printStackTrace();
//            }
//        }
//    }

    private static void getAge(ResultSet rs, Patient user) {
        try {
            String date = rs.getDate("birthday").toString();
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

    private static void getStandartFields(ResultSet rs, Staff staff) {
        try {
            staff.setId(rs.getInt("id"));

            if (rs.getString("name") != null) {
                staff.setName(rs.getString("name"));
            }
            if (rs.getString("surname") != null) {
                staff.setSurname(rs.getString("surname"));
            }
            if (rs.getString("telephone") != null) {
                staff.setTelephone(rs.getString("telephone"));
            }
            if (rs.getString("passport") != null) {
                staff.setPassport(rs.getString("passport"));
            }
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
    }

    public static void getLoginPassword(ResultSet rs, Connection con, Staff user) {
        try {
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
}
