package com.ua.entity;

import java.util.List;

public class Doctor extends Staff{
    private int id;
    private int age;
    private String gender;
    private String passport;
    private String login;
    private String password;
    private String role;
    private String name;
    private String surname;
    private String department;
    private List<Patient> patients;

    public List<Patient> getPatients() {
        return patients;
    }

    public void setPatients(List<Patient> patients) {
        this.patients = patients;
    }
}
