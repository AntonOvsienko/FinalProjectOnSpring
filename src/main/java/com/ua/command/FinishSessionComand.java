package com.ua.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.Connection;

public class FinishSessionComand implements Command {
    @Override
    public String execute(HttpServletRequest req, HttpServletResponse resp, Connection con) {
        return null;
    }

    @Override
    public String execute(HttpServletRequest req, HttpServletResponse resp) {

        HttpSession session = req.getSession();
        session.invalidate();

        return "/index.html";
    }
}
