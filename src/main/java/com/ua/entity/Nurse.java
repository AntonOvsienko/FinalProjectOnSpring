package com.ua.entity;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class Nurse extends Staff implements Serializable {
    private int id;
    private String passport;
    private String login;
    private String password;
    private String role;
    private String name;
    private String surname;
    private String telephone;
    private static List<CaseRecord> caseRecords=new ArrayList<>();

    @Override
    public int getId() {
        return id;
    }

    @Override
    public void setId(int id) {
        this.id = id;
    }

    @Override
    public String getPassport() {
        return passport;
    }

    @Override
    public void setPassport(String passport) {
        this.passport = passport;
    }

    @Override
    public String getLogin() {
        return login;
    }

    @Override
    public void setLogin(String login) {
        this.login = login;
    }

    @Override
    public String getPassword() {
        return password;
    }

    @Override
    public void setPassword(String password) {
        this.password = password;
    }

    @Override
    public String getRole() {
        return role;
    }

    @Override
    public void setRole(String role) {
        this.role = role;
    }

    @Override
    public String getName() {
        return name;
    }

    @Override
    public void setName(String name) {
        this.name = name;
    }

    @Override
    public String getSurname() {
        return surname;
    }

    @Override
    public void setSurname(String surname) {
        this.surname = surname;
    }

    @Override
    public String getTelephone() {
        return telephone;
    }

    @Override
    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }

    @Override
    public List<CaseRecord> getCaseRecords() {
        return caseRecords;
    }

    @Override
    public void setCaseRecords(List<CaseRecord> caseRecords) {
        this.caseRecords = caseRecords;
    }
}
