package com.ua.entity;

public abstract class Staff {

    private int id;
    private String login;
    private String password;
    private String role;
    private String nameSurname;

    public String getLogin() {
        return login;
    }
    public void setLogin(String login) {
        this.login = login;
    }
    public String getPassword() {
        return password;
    }
    public void setPassword(String password) {
        this.password = password;
    }
    public String getRole() {
        return role;
    }
    public void setRole(String role) {
        this.role = role;
    }
    public String getNameSurname() {
        return nameSurname;
    }
    public void setNameSurname(String nameSurname) {
        this.nameSurname = nameSurname;
    }
    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }

    @Override
    public String toString() {
        return "login - " + login
                + "\nnameSurname - " + nameSurname
                + "\nrole - " + role;
    }

    @Override
    public boolean equals(Object obj) {
        if (obj == null) return false;
        Staff staff = (Staff) obj;
        if (login.equals(staff.getLogin())) {
            return true;
        }
        return false;
    }
}
