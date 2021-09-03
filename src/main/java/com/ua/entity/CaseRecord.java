package com.ua.entity;

import java.io.Serializable;
import java.util.List;

public class CaseRecord implements Serializable {
    private int id;
    private int id_doctor;
    private String initialDiagnosis;
    private String finalDiagnosis;
    private List<DoctorAppointment> doctorAppointmentList;

    public CaseRecord (String initialDiagnosis){
        this.initialDiagnosis=initialDiagnosis;
    }

    private class DoctorAppointment {
        int id;
        boolean complete;
        String type;
        String description;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
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

    @Override
    public String toString() {
        return "CaseRecord{" +
                "initialDiagnosis='" + initialDiagnosis + '\'' +
                '}';
    }
}
