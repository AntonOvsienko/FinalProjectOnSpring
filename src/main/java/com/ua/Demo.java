package com.ua;

import com.ua.entity.Staff;

import java.sql.SQLException;

public class Demo {
    public static void main(String[] args) {
        DBManager dbManager=DBManager.getInstance();
        try {
            Staff admin = dbManager.getStaff("admin", "12345");
            System.out.println(admin);
            dbManager.createLogin("doctor","12345","doctor");
            dbManager.fullLogin("doctor","12345","Kolia","345"); //var={login,password,name_Surname,identification_code}
            dbManager.createLogin("patient","12345","patient");
            dbManager.fullLogin("patient","12345","Igor","1345");
            Staff doctor= dbManager.getStaff("doctor","12345");
            Staff patient= dbManager.getStaff("patient","12345");
            dbManager.setDoctorForPatient(doctor,patient);
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
    }
}
