package com.ua.command;

import java.util.HashMap;
import java.util.Map;

public class CommandContainer {
	
	private static Map<String, Command> commands;
	
	static {
		commands = new HashMap<>();
		
		commands.put("login", new LoginCommand());
		commands.put("listUsers", new ListUsersCommand());
		commands.put("addNewPatient", new AddNewPatientCommand());
		commands.put("checkNewLogin", new CheckNewLoginCommand());
		commands.put("createNewLogin", new AddNewLoginCommand());
		commands.put("exit", new FinishSessionComand());
		commands.put("viewStaff", new ListGenerationDoctorCommand());
		// ...
	}

	public static Command getCommand(String commandName) {
		return commands.get(commandName);
	}
	
}
