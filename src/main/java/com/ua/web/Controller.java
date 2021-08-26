package com.ua.web;

import com.ua.command.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/controller")
public class Controller extends HttpServlet {
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// (1) get command name
		String commandName = req.getParameter("command");
		System.out.println("commandName ==> " + commandName);
		
		// (2) get command
		Command command = CommandContainer.getCommand(commandName);
		System.out.println("command ==> " + command);
		
		String address = "errorMessage/error.jsp";
		
		// (3) do command
		try {
			address = command.execute(req, resp);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		
		// (4) go to address
		req.getRequestDispatcher(address).forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}

}
