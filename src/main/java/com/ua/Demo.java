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
            dbManager.fullLogin("doctor","12345","Vasia","345"); //var={login,password,name_Surname,role,identification_code}
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
    }
}
