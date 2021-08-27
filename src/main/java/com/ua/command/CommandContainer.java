package com.ua.command;

import java.util.HashMap;
import java.util.Map;

public class CommandContainer {
	
	private static Map<String, Command> commands;
	
	static {
		commands = new HashMap<>();
		
		commands.put("login", new LoginCommand());
		commands.put("listUsers", new ListUsersCommand());
		commands.put("newStaff", new AddNewStaffFirstStepCreateLoginCommand());
		commands.put("updateStaff", new AddNewStaffSecondStepAccountContent());
		commands.put("exit", new FinishSessionComand());
		// ...
	}

	public static Command getCommand(String commandName) {
		return commands.get(commandName);
	}
	
}
