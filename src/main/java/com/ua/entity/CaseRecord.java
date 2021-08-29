package com.ua.entity;

import java.util.List;

public class CaseRecord {
    private int id_doctor;
    private String initialDiagnosis;
    private String finalDiagnosis;
    private List<DoctorAppointment> doctorAppointmentList;

    private class DoctorAppointment {
        int id;
        boolean complete;
        String type;
        String text;
    }

    public int getId_doctor() {
        return id_doctor;
    }

    public void setId_doctor(int id_doctor) {
        this.id_doctor = id_doctor;
    }

    public String getInitialDiagnosis() {
        return initialDiagnosis;
    }

    public void setInitialDiagnosis(String initialDiagnosis) {
        this.initialDiagnosis = initialDiagnosis;
    }

    public String getFinalDiagnosis() {
        return finalDiagnosis;
    }

    public void setFinalDiagnosis(String finalDiagnosis) {
        this.finalDiagnosis = finalDiagnosis;
    }

    public List<DoctorAppointment> getDoctorAppointmentList() {
        return doctorAppointmentList;
    }

    public void setDoctorAppointmentList(List<DoctorAppointment> doctorAppointmentList) {
        this.doctorAppointmentList = doctorAppointmentList;
    }
}
