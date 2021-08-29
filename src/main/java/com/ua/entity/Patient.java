package com.ua.entity;

import java.util.List;

public class Patient extends Staff{
    private int id;
    private int age;
    private String gender;
    private String passport;
    private String login;
    private String password;
    private String role;
    private String name;
    private String surname;
    private List<CaseRecord> caseRecords;

    public List<CaseRecord> getCaseRecords() {
        return caseRecords;
    }

    public void setCaseRecords(List<CaseRecord> caseRecords) {
        this.caseRecords = caseRecords;
    }
}
