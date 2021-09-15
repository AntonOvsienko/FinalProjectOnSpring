package com.ua.Utils;

public class Constant{

    public static final String URL_ADD_APPOINTMENT="controller?command=doctorAppointment&caseRecordId=";
    public static final String URL_ERROR_PAGE="errorMessage/error.jsp";
    public static final String URL_NEW_LOGIN="users/newLogin.jsp";

    public static final String SQL_APPOINTMENT_SELECT ="SELECT * FROM patient_has_case_records WHERE id=?";
    public static final String SQL_APPOINTMENT_INSERT ="INSERT INTO doctor_appointment " +
            "(case_record_id,type,description,complete) VALUES (?,?,?,?)";
    public static final String SQL_NEW_LOGIN_INSERT_LOGIN ="INSERT INTO login_password (login,password,role)" +
            " VALUES (?,?,?)";
    public static final String SQL_NEW_LOGIN_SELECT_LOGIN ="SELECT * FROM login_password WHERE login=?";
    public static final String SQL_NEW_LOGIN_UPDATE_DOCTOR = "UPDATE doctor SET name=?, surname=?, telephone=?, passport=?" +
            ", department=? WHERE login_password_id=?";
    public static final String SQL_NEW_LOGIN_UPDATE_NURSE = "UPDATE nurse SET name=?, surname=?, telephone=?, passport=?" +
            ", WHERE login_password_id=?";
}


