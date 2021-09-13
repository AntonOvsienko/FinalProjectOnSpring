package com.ua;

import com.ua.command.Command;
import com.ua.command.CommandContainer;
import org.junit.Before;
import org.mockito.*;
import org.junit.Assert;
import org.junit.BeforeClass;
import org.junit.Test;
import org.mockito.Mockito;

import static org.mockito.Mockito.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.*;


public class TestAddController {

    private HttpServletRequest req;
    private HttpServletResponse resp;
    private HttpSession httpSession;
    private PreparedStatement ps;
    private ResultSet rs;
    private Connection con;
    private Statement st;
    private ResultSet rs2;

    @Before
    public void init() {
        st = Mockito.mock(Statement.class);
        rs = Mockito.mock(ResultSet.class);
        rs2 = Mockito.mock(ResultSet.class);
        ps = Mockito.mock(PreparedStatement.class);
        resp = Mockito.mock(HttpServletResponse.class);
        req = Mockito.mock(HttpServletRequest.class);
        httpSession = Mockito.mock(HttpSession.class);
        con = mock(Connection.class);
        Mockito.when((req.getSession())).thenReturn(httpSession);
    }


    @Test
    public void еnterLoginAdminAndPasswordIsTrueShouldTrue() throws SQLException {
        Mockito.when(req.getParameter("login"))
                .thenReturn("admin");
        Mockito.when(req.getParameter("password"))
                .thenReturn("12345");
        Mockito.when(ps.executeQuery())
                .thenReturn(rs);
        Mockito.when(con.prepareStatement("SELECT * FROM login_password WHERE login=? AND password=?"))
                .thenReturn(ps);
        Mockito.when(rs.next()).thenReturn(true).thenReturn(false);
        Mockito.when(rs.getString("role")).thenReturn("administrator");
        Mockito.when(rs.getInt("id")).thenReturn(1);
        Mockito.when(con.createStatement()).thenReturn(st);
        Mockito.when(st.executeQuery("SELECT * FROM administrator WHERE login_password_id=1")).thenReturn(rs2);
        Mockito.when(rs2.next()).thenReturn(true).thenReturn(false);
        Mockito.when(rs2.getString("name")).thenReturn("admin");
        Mockito.when(rs2.getString("surname")).thenReturn("admin");
        Mockito.when(rs2.getString("passport")).thenReturn("admin");
        Mockito.when(rs2.getString("telephone")).thenReturn("admin");
        Mockito.when(rs2.getString("id")).thenReturn("3");
        try (MockedStatic<ConnectionPool> utilMock = Mockito.mockStatic(ConnectionPool.class)) {
            utilMock.when(ConnectionPool::getConnection)
                    .thenReturn(con);

            Command command = CommandContainer.getCommand("login");
            String address = command.execute(req, resp, con);
            Assert.assertEquals(address, "controller?command=viewStaff");
        }
    }

    @Test
    public void еnterLoginAdminAndPasswordIsFalseShouldTrue() throws SQLException {
        Mockito.when(req.getParameter("login"))
                .thenReturn("admin");
        Mockito.when(req.getParameter("password"))
                .thenReturn("10");
        Mockito.when(ps.executeQuery())
                .thenReturn(rs);
        Mockito.when(con.prepareStatement("SELECT * FROM login_password WHERE login=? AND password=?"))
                .thenReturn(ps);
        Mockito.when(rs.next()).thenReturn(false);
        try (MockedStatic<ConnectionPool> utilMock = Mockito.mockStatic(ConnectionPool.class)) {
            utilMock.when(ConnectionPool::getConnection)
                    .thenReturn(con);

            Command command = CommandContainer.getCommand("login");
            String address = command.execute(req, resp, con);
            Assert.assertEquals(address, "errorMessage/error.jsp");
        }
    }

    @Test
    public void еnterLoginDoctorAndPasswordIsTrueShouldTrue() throws SQLException {
        Mockito.when(req.getParameter("login"))
                .thenReturn("doctor1");
        Mockito.when(req.getParameter("password"))
                .thenReturn("12345");
        Mockito.when(ps.executeQuery())
                .thenReturn(rs);
        Mockito.when(con.prepareStatement("SELECT * FROM login_password WHERE login=? AND password=?"))
                .thenReturn(ps);
        Mockito.when(rs.next()).thenReturn(true).thenReturn(false);
        Mockito.when(rs.getString("role")).thenReturn("doctor");
        Mockito.when(rs.getInt("id")).thenReturn(26);
        Mockito.when(con.createStatement()).thenReturn(st);
        Mockito.when(st.executeQuery("SELECT * FROM doctor WHERE login_password_id=26")).thenReturn(rs2);
        try (MockedStatic<ConnectionPool> utilMock = Mockito.mockStatic(ConnectionPool.class)) {
            utilMock.when(ConnectionPool::getConnection)
                    .thenReturn(con);

            Command command = CommandContainer.getCommand("login");
            String address = command.execute(req, resp, con);
            Assert.assertEquals(address, "controller?command=viewNurse");
        }
    }

    @Test
    public void еnterLoginNurseAndPasswordIsTrueShouldTrue() throws SQLException {
        Mockito.when(req.getParameter("login"))
                .thenReturn("nurse1");
        Mockito.when(req.getParameter("password"))
                .thenReturn("12345");
        Mockito.when(ps.executeQuery())
                .thenReturn(rs);
        Mockito.when(con.prepareStatement("SELECT * FROM login_password WHERE login=? AND password=?"))
                .thenReturn(ps);
        Mockito.when(rs.next()).thenReturn(true).thenReturn(false);
        Mockito.when(rs.getString("role")).thenReturn("nurse");
        Mockito.when(rs.getInt("id")).thenReturn(42);
        Mockito.when(con.createStatement()).thenReturn(st);
        Mockito.when(st.executeQuery("SELECT * FROM nurse WHERE login_password_id=42")).thenReturn(rs2);
        try (MockedStatic<ConnectionPool> utilMock = Mockito.mockStatic(ConnectionPool.class)) {
            utilMock.when(ConnectionPool::getConnection)
                    .thenReturn(con);

            Command command = CommandContainer.getCommand("login");
            String address = command.execute(req, resp, con);
            Assert.assertEquals(address, "controller?command=viewNurse");
        }
    }

    @Test
    public void checkNewLoginAndPasswordShouldLoginTaken() throws SQLException {
        Mockito.when(req.getParameter("login"))
                .thenReturn("doctor10");
        Mockito.when(req.getParameter("password"))
                .thenReturn("12345");
        Mockito.when(req.getParameter("password_repeat"))
                .thenReturn("12345");
        Mockito.when(req.getParameter("role"))
                .thenReturn("doctor");
        Mockito.when(ps.executeQuery())
                .thenReturn(rs);
        Mockito.when(con.prepareStatement("SELECT * FROM login_password WHERE login=?"))
                .thenReturn(ps);
        Mockito.when(rs.next()).thenReturn(true).thenReturn(false);
        try (MockedStatic<ConnectionPool> utilMock = Mockito.mockStatic(ConnectionPool.class)) {
            utilMock.when(ConnectionPool::getConnection)
                    .thenReturn(con);

            Command command = CommandContainer.getCommand("checkNewLogin");
            String address = command.execute(req, resp, con);
            Assert.assertEquals(address, "users/newLogin.jsp");
        }
    }

    @Test
    public void checkNewLoginAndPasswordWrongRepeatPassword() throws SQLException {
        Mockito.when(req.getParameter("login"))
                .thenReturn("doctor10");
        Mockito.when(req.getParameter("password"))
                .thenReturn("12345");
        Mockito.when(req.getParameter("password_repeat"))
                .thenReturn("123456");
        Mockito.when(req.getParameter("role"))
                .thenReturn("doctor");
        Mockito.when(ps.executeQuery())
                .thenReturn(rs);
        Mockito.when(con.prepareStatement("SELECT * FROM login_password WHERE login=?"))
                .thenReturn(ps);
        Mockito.when(rs.next()).thenReturn(true).thenReturn(false);
        try (MockedStatic<ConnectionPool> utilMock = Mockito.mockStatic(ConnectionPool.class)) {
            utilMock.when(ConnectionPool::getConnection)
                    .thenReturn(con);

            Command command = CommandContainer.getCommand("checkNewLogin");
            String address = command.execute(req, resp, con);
            Assert.assertEquals(address, "errorMessage/errorRepeatPassword.jsp");
        }
    }
    @Test
    public void checkNewLoginAndPasswordShouldTrue() throws SQLException {
        Mockito.when(req.getParameter("login"))
                .thenReturn("doctor10");
        Mockito.when(req.getParameter("password"))
                .thenReturn("12345");
        Mockito.when(req.getParameter("password_repeat"))
                .thenReturn("12345");
        Mockito.when(req.getParameter("role"))
                .thenReturn("doctor");
        Mockito.when(ps.executeQuery())
                .thenReturn(rs);
        Mockito.when(con.prepareStatement("SELECT * FROM login_password WHERE login=?"))
                .thenReturn(ps);
        Mockito.when(rs.next()).thenReturn(false);
        try (MockedStatic<ConnectionPool> utilMock = Mockito.mockStatic(ConnectionPool.class)) {
            utilMock.when(ConnectionPool::getConnection)
                    .thenReturn(con);

            Command command = CommandContainer.getCommand("checkNewLogin");
            String address = command.execute(req, resp, con);
            Assert.assertEquals(address, "users/newLogin.jsp");
        }
    }
}
