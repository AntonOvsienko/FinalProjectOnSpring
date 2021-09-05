package com.ua.entity;

import java.io.Serializable;

public class Nurse extends Staff implements Serializable {
    private int id;
    private String passport;
    private String login;
    private String password;
    private String role;
    private String name;
    private String surname;
    private String telephone;
}
