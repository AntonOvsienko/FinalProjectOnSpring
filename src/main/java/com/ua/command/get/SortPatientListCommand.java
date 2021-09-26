package com.ua.command.get;

import com.ua.command.Command;
import com.ua.entity.CaseRecord;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Comparator;
import java.util.List;

public class SortPatientListCommand implements Command {
    @Override
    public String execute(HttpServletRequest req, HttpServletResponse resp, Connection con) throws SQLException {
        return null;
    }

    @Override
    public String execute(HttpServletRequest req, HttpServletResponse resp) {
        HttpSession session = req.getSession();
        String sort = req.getParameter("sort2");
        session.setAttribute("sort2", sort);
        System.out.println("sort =>" + sort);
        List<CaseRecord> caseRecordList=(List<CaseRecord>)session.getAttribute("caseRecordList");
        if (sort.equals("sortByName")) {
            caseRecordList.sort(Comparator.comparing(o -> o.getPatient().getName()));
            session.setAttribute("caseRecordList", caseRecordList);
        }
        if (sort.equals("sortByBirthday")) {
            caseRecordList.sort((o1, o2) -> {
                if (o1.getPatient().getYearBorn() < o2.getPatient().getYearBorn()) {
                    return 1;
                }
                if (o1.getPatient().getYearBorn() > o2.getPatient().getYearBorn()) {
                    return -1;
                }
                if (o1.getPatient().getMonthBorn() < o2.getPatient().getMonthBorn()) {
                    return 1;
                }
                if (o1.getPatient().getMonthBorn() > o2.getPatient().getMonthBorn()) {
                    return -1;
                }
                if (o1.getPatient().getDayBorn() < o2.getPatient().getDayBorn()) {
                    return 1;
                }
                if (o1.getPatient().getDayBorn() > o2.getPatient().getDayBorn()) {
                    return -1;
                }
                return 0;
            });
            session.setAttribute("caseRecordList", caseRecordList);;
        }

        return (String)session.getAttribute("finalAddress");
    }
}
