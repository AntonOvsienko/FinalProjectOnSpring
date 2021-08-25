package com.ua;


import com.ua.entity.*;

import java.io.FileInputStream;
import java.io.IOException;
import java.sql.*;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DBManager {
    public static final String URL = "connection.url";
    public static final String FILE = "app.properties";
    private static final Logger log = Logger.getLogger(DBManager.class.getName());
    private static DBManager dbManager;

    private DBManager() {
    }

    public static DBManager getInstance() {
        if (dbManager == null) {
            dbManager = new DBManager();
        }
        return dbManager;
    }

    public static Connection getConnection(String connectionUrl, String pathFile) throws SQLException {
        Properties properties = new Properties();
        try (FileInputStream fileInputStream = new FileInputStream(pathFile)) {
            properties.load(fileInputStream);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return DriverManager.getConnection(properties.getProperty(connectionUrl));
    }

    public boolean createLogin(String login, String password, String role) {
        try (Connection con = getConnection(URL, FILE);
             PreparedStatement pstmt = con.prepareStatement(
                     "INSERT INTO login_password (login,password,role) VALUES (?,?,?)");
             PreparedStatement duplicate = con.prepareStatement("SELECT * FROM login_password WHERE login=?")) {
            if (checkForDuplicateByLogin(duplicate, login)) {
                pstmt.setString(1, login);
                pstmt.setString(2, password);
                pstmt.setString(3, role);
                pstmt.executeUpdate();
                return true;
            }
        } catch (SQLException throwables) {
            System.out.println(throwables.getMessage());
        } finally {
            return false;
        }
    }

    public void fullLogin(String... var) { //var={login,password,name_Surname,identification_code}
        String[] parameters = new String[var.length];
        for (int i = 0; i < var.length; i++) {
            parameters[i] = var[i];
        }
        String role = returnRole(parameters[0], parameters[1]);
        int id = returnID(parameters[0], parameters[1]);
        if (role.equals("0")) {
            return;
        }
        String find = "SELECT * FROM " + role + " WHERE id=" + parameters[3];
        try (Connection con = getConnection(URL, FILE);
             Statement ps = con.prepareStatement(find)) {
            if (!ps.execute(find)) {
                fullLoginNew(parameters, role, id);
            } else {
                fullLoginUpdate(parameters, role);
            }
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }

    }

    public String returnRole(String login, String password) {
        ResultSet result;
        try (Connection con = getConnection(URL, FILE);
             PreparedStatement ps = con.prepareStatement("SELECT * FROM login_password WHERE login=? " +
                     "AND password=?")) {
            ps.setString(1, login);
            ps.setString(2, password);
            result = ps.executeQuery();
            result.next();
            return result.getString("role");
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
        return "0";
    }

    public void fullLoginNew(String[] parameters, String role, int id) {
        String pathNew = "INSERT INTO " + role + " (id ,name_Surname,login_password_id) VALUES (?,?,?)";
        String checkLoginPassword = "SELECT * FROM login_password WHERE login=\'" +
                parameters[0] + "\' AND password=\'" + parameters[1] + "\'";
        try (Connection con = getConnection(URL, FILE);
             PreparedStatement pstmt = con.prepareStatement(pathNew);
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(checkLoginPassword)) {
            if (rs.next()) {
                pstmt.setInt(1, Integer.parseInt(parameters[3]));
                pstmt.setString(2, parameters[2]);
                pstmt.setInt(3, id);
                pstmt.executeUpdate();
            }
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
    }

    public void fullLoginUpdate(String[] parameters, String role) { //var={login,password,name_Surname,identification_code}
        String pathNew = "UPDATE " + role + " SET name_surname=? WHERE id=?";
        String checkLoginPassword = "SELECT * FROM login_password WHERE login=\'" +
                parameters[0] + "\' AND password=\'" + parameters[1] + "\'";
        try (Connection con = getConnection(URL, FILE);
             PreparedStatement pstmt = con.prepareStatement(pathNew);
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(checkLoginPassword)) {
            if (rs.next()) {
                pstmt.setString(1, parameters[2]);
                pstmt.setInt(2, Integer.parseInt(parameters[3]));
                pstmt.executeUpdate();
            }
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
    }

    public int returnID(String login, String password) {
        ResultSet result;
        try (
                Connection con = getConnection(URL, FILE);
                PreparedStatement ps = con.prepareStatement("SELECT * FROM login_password WHERE login=?" +
                        "AND password=?")) {
            ps.setString(1, login);
            ps.setString(2, password);
            result = ps.executeQuery();
            result.next();
            return Integer.parseInt(result.getString("id"));
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
        return 0;
    }

    public boolean checkStaff(Staff persona) {
        ResultSet result;
        String table = persona.getClass().getSimpleName().toLowerCase();
        String find = "SELECT * FROM " + table + " WHERE id=?";
        try (Connection con = getConnection(URL, FILE);
             PreparedStatement ps = con.prepareStatement(find)) {
            ps.setInt(1, persona.getId());
            result = ps.executeQuery();
            return result.next();
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
        return false;
    }
//
//    public List<User> findAllUsers() {
//        List<User> users = new ArrayList<>();
//        try (Statement stmt = con.createStatement();
//        ) {
//            ResultSet rs = stmt.executeQuery("SELECT * FROM users ORDER BY id");
//            while (rs.next()) {
//                users.add(createUser(rs));
//            }
//        } catch (SQLException throwables) {
//            System.out.println(throwables.getMessage());
//        }
//        return users;
//    }

    public Staff getStaff(String login, String password) throws SQLException {
        Staff user = null;
        ResultSet resultSet = null;
        try (Connection con = getConnection(URL, FILE);
             PreparedStatement ps = con.prepareStatement("SELECT * FROM login_password WHERE login=?" +
                     "AND password=?")) {
            ps.setString(1, login);
            ps.setString(2, password);
            resultSet = ps.executeQuery();
            resultSet.next();
            user = createUser(resultSet);
        } catch (SQLException ex) {
            log.log(Level.SEVERE, "", ex);
        } finally {
            assert resultSet != null;
            resultSet.close();
        }
        return user;
    }

    private Staff createUser(ResultSet rs) throws SQLException {
        Staff users = null;
        Connection con = getConnection(URL, FILE);
        if (rs.getString("role").equals("administrator")) {
            users = new Administrator();
        } else if (rs.getString("role").equals("doctor")) {
            users = new Doctor();
        } else if (rs.getString("role").equals("nurse")) {
            users = new Nurse();
        } else if (rs.getString("role").equals("patient")) {
            users = new Patient();
        }
        users.setLogin(rs.getString("login"));
        users.setPassword(rs.getString("password"));
        users.setRole(rs.getString("role"));
        String find = findTable(rs);
        PreparedStatement ps = con.prepareStatement(find);
        ps.setInt(1, rs.getInt("id"));
        ResultSet resultSet = ps.executeQuery();
        resultSet.next();
        users.setNameSurname(resultSet.getString("name_surname"));
        users.setId(resultSet.getInt("id"));
        ps.close();
        resultSet.close();
        con.close();
        return users;
    }

    private String findTable(ResultSet rs) throws SQLException {
        return ("SELECT * FROM " + rs.getString("role") + " WHERE login_password_id=?");
    }

    public void setDoctorForPatient(Staff doctor, Staff patient) {
        if (!checkStaff(doctor) || !checkStaff(patient)) {
            return;
        }
        try (Connection con = getConnection(URL, FILE);
             PreparedStatement findpatient = con.prepareStatement(
                     "UPDATE patient SET doctor_id=? WHERE id=?")) {
            findpatient.setInt(1, doctor.getId());
            findpatient.setInt(2, patient.getId());
            findpatient.executeUpdate();

        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
    }

    //
//    public void setTeamsForUser(User login, Team... name) throws SQLException {
//        con.setTransactionIsolation(4);
//        con.setAutoCommit(false);
//        try (
//                PreparedStatement duplicate = con.prepareStatement("SELECT * FROM users_teams WHERE user_id=? " +
//                        "AND team_id=?");
//                PreparedStatement find = con.prepareStatement("INSERT INTO users_teams (user_id,team_id) VALUES (?, ?)",
//                        Statement.RETURN_GENERATED_KEYS)) {
//            for (Team x : name) {
//                if (checkForDuplicate(duplicate, login, x)) {
//                    find.setInt(1, login.getId());
//                    find.setInt(2, x.getId());
//                    find.executeUpdate();
//                }
//            }
//            con.commit();
//        } catch (SQLException e) {
//            con.rollback();
//            System.out.println(e.getMessage());
//        } finally {
//            con.setAutoCommit(true);
//        }
//    }
//
//    public List<Team> getUserTeams(User user) throws SQLException {
//        List<Team> teams = new ArrayList<>();
//        PreparedStatement find = con.prepareStatement("SELECT team_id FROM users_teams WHERE user_id=?");
//        find.setInt(1, user.getId());
//        ResultSet resultSet = find.executeQuery();
//        while (resultSet.next()) {
//            int i = resultSet.getInt("team_id");
//            teams.add(getTeam(i));
//        }
//        return teams;
//    }
//

    public boolean checkForDuplicateByLogin(PreparedStatement duplicate, String login) throws SQLException {
        duplicate.setString(1, login);
        return resultDublicate(duplicate);
    }

    public boolean resultDublicate(PreparedStatement duplicate) throws SQLException {
        ResultSet resultSet = duplicate.executeQuery();
        try {
            if (!resultSet.next()) {
                return true;
            }
            if (duplicate.execute()) {
                return false;
            }
        } catch (SQLException e) {
            log.log(Level.SEVERE, "", e);
        } finally {
            resultSet.close();
        }
        return true;
    }
//
//    public boolean checkForDuplicateByTeam(PreparedStatement duplicate, Team name) throws SQLException {
//        duplicate.setString(1, name.getName());
//        ResultSet resultSet = duplicate.executeQuery();
//        if (!resultSet.next()) return true;
//        if (duplicate.execute()) {
//            return false;
//        }
//        return true;
//    }
//
//    public void deleteTeam(Team team) {
//        try (PreparedStatement delete = con.prepareStatement("DELETE FROM teams WHERE id=?")) {
//            delete.setInt(1, team.getId());
//            delete.executeUpdate();
//        } catch (SQLException e) {
//            System.out.println(e.getMessage());
//        }
//    }
//
//    public void updateTeam(Team team) {
//        try (PreparedStatement find = con.prepareStatement("UPDATE teams SET name=? WHERE id=?")) {
//            find.setString(1, team.getName());
//            find.setInt(2, team.getId());
//            find.executeUpdate();
//        } catch (SQLException e) {
//            System.out.println(e.getMessage());
//        }
//    }
}
