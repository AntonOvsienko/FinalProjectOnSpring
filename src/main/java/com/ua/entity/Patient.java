package com.ua.entity;

import java.util.ArrayList;
import java.util.List;

public class Patient extends Staff {
    private int id;
    private String telephone;
    private String passport;
    private String name;
    private String surname;
    private long years;
    private int dayBorn;
    private int monthBorn;
    private int yearBorn;
    private List<CaseRecord> caseRecords = new ArrayList<>();

    public long getYears() {
        return years;
    }

    public void setYears(long years) {
        this.years = years;
    }

    public int getDayBorn() {
        return dayBorn;
    }

    public void setDayBorn(int dayBorn) {
        this.dayBorn = dayBorn;
    }

    public int getMonthBorn() {
        return monthBorn;
    }

    public void setMonthBorn(int monthBorn) {
        this.monthBorn = monthBorn;
    }

    public int getYearBorn() {
        return yearBorn;
    }

    public void setYearBorn(int yearBorn) {
        this.yearBorn = yearBorn;
    }

    public List<CaseRecord> getCaseRecords() {
        return caseRecords;
    }

    public void setCaseRecords(List<CaseRecord> caseRecords) {
        this.caseRecords = caseRecords;
    }

    @Override
    public String toString() {
        return "Patient{" +
                "\nid=" + id +
                "\n, telephone='" + telephone + '\'' +
                "\n, passport='" + passport + '\'' +
                "\n, name='" + name + '\'' +
                "\n, surname='" + surname + '\'' +
                "\n, years=" + years +
                "\n, caseRecords=" + caseRecords +
                '}' + "\n";
    }
}
