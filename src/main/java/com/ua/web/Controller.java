package com.ua.web;

import com.ua.command.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/controller")
public class Controller extends HttpServlet {
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// (0) session setup

		HttpSession session = req.getSession();
		System.out.println("session==>" + session);
		session.setMaxInactiveInterval(30);

		// (1) get command name

		if (req.getParameter("command") != null) {
			session.setAttribute("command", req.getParameter("command"));
		}
		String commandName = (String) session.getAttribute("command");
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
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String address = req.getParameter("address");
		System.out.println("address ==> " + address);

		HttpSession session = req.getSession();
		System.out.println("session ==> " + session);
		session.setMaxInactiveInterval(30);

		req.getRequestDispatcher(address).forward(req, resp);
	}

}
