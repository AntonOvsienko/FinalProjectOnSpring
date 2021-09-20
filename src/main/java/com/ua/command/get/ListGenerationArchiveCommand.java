package com.ua.command.get;

import com.ua.ConnectionPool;
import com.ua.Utils.Constant;
import com.ua.Utils.CreateElement;
import com.ua.command.Command;
import com.ua.entity.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;

import static com.ua.Utils.CreateElement.newElement;

public class ListGenerationArchiveCommand implements Command {

    @Override
    public String execute(HttpServletRequest req, HttpServletResponse resp, Connection con) throws SQLException {
        return null;
    }

    @Override
    public String execute(HttpServletRequest req, HttpServletResponse resp) throws SQLException {
        return null;
    }
}
