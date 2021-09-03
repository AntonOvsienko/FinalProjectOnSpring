package com.ua.command;

import com.ua.entity.Patient;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

public class SortDoctorListCommand implements Command {
    @Override
    public String execute(HttpServletRequest req, HttpServletResponse resp, Connection con) throws SQLException {
        return null;
    }

    @Override
    public String execute(HttpServletRequest req, HttpServletResponse resp) {
        HttpSession session = req.getSession();
        String sort = req.getParameter("sort");
        String check = req.getParameter("check");
        if (check != null) {
            session.setAttribute("check", "on");
        } else {
            session.setAttribute("check", null);
        }
        System.out.println("check =>" + check);
        session.setAttribute("sort", sort);
        System.out.println("sort =>" + sort);
        if (sort.equals("sortByName")) {
            session.setAttribute("doctors", session.getAttribute("doctorsByName"));
        }
        if (sort.equals("sortByCount")) {
            session.setAttribute("doctors", session.getAttribute("doctorsByNumberPatient"));
        }

        return "users/doctorList.jsp";
    }
}
