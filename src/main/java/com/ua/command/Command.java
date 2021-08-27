package com.ua.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.Connection;

public interface Command {
	
	String execute(HttpServletRequest req, HttpServletResponse resp, Connection con);

	String execute(HttpServletRequest req, HttpServletResponse resp);

}
