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
    private List<Patient> patients=new ArrayList<>();

    public List<Patient> getPatients() {
        return patients;
    }

    public void setPatients(List<Patient> patients) {
        this.patients = patients;
    }
}
