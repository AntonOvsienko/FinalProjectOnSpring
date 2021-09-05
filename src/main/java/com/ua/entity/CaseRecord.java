package com.ua.entity;

import java.io.Serializable;
import java.util.List;

public class CaseRecord implements Serializable {
    private int id;
    Doctor doctor;
    Patient patient;
    private String initialDiagnosis;
    private String finalDiagnosis;
    private List<DoctorAppointment> doctorAppointmentList;

    public CaseRecord (int id,String initialDiagnosis){
        this.initialDiagnosis=initialDiagnosis;
        this.id=id;
    }

    public CaseRecord (int id,Doctor doctor,Patient patient,String initialDiagnosis){
        this.initialDiagnosis=initialDiagnosis;
        this.id=id;
        this.doctor=doctor;
        this.patient=patient;
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

    public Doctor getDoctor() {
        return doctor;
    }

    public void setDoctor(Doctor doctor) {
        this.doctor = doctor;
    }

    public Patient getPatient() {
        return patient;
    }

    public void setPatient(Patient patient) {
        this.patient = patient;
    }

    @Override
    public String toString() {
        return "CaseRecord{" +
                "id=" + id +
                ", doctor=" + doctor +
                ", patient=" + patient +
                ", initialDiagnosis='" + initialDiagnosis + '\'' +
                ", finalDiagnosis='" + finalDiagnosis + '\'' +
                '}';
    }
}
