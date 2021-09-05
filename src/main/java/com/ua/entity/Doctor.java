package com.ua.entity;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;


public class Doctor extends Staff implements Serializable {
    private int id;
    private String passport;
    private String login;
    private String password;
    private String role;
    private String name;
    private String surname;
    private String telephone;
    private String department;
    private List<CaseRecord> caseRecords=new ArrayList<>();

    public Doctor(){
    }

    public Doctor(String name,String surname,String department){
        this.name=name;
        this.surname=surname;
        this.department=department;
    }
}
