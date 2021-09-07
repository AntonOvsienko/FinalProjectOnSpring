package com.ua.entity;

public class DoctorAppointment {
    int id;
    boolean complete;
    String type;
    String description;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public boolean isComplete() {
        return complete;
    }

    public void setComplete(boolean complete) {
        this.complete = complete;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    @Override
    public String toString() {
        return "DoctorAppointment{" +
                "id=" + id +
                ", complete=" + complete +
                ", type='" + type + '\'' +
                ", description='" + description + '\'' +
                '}';
    }
}
