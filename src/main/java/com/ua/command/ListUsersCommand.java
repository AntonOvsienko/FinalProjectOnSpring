package com.ua.command;

import com.ua.entity.Doctor;
import com.ua.entity.Staff;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ListUsersCommand implements Command {

	@Override
	public String execute(HttpServletRequest req, HttpServletResponse resp, Connection con) {
		return null;
	}

	@Override
	public String execute(HttpServletRequest req, HttpServletResponse resp) {
		return null;
	}


}
