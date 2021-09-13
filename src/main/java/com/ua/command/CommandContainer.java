package com.ua.command;

import com.ua.command.Add.*;
import com.ua.command.Get.*;
import com.ua.command.Update.AppointDoctorToPatientCommand;
import com.ua.command.Update.DeleteAppointmentCommand;
import com.ua.command.Update.DeleteDoctorWithListCommand;

import java.util.HashMap;
import java.util.Map;

public class CommandContainer {
	
	private static Map<String, Command> commands;
	
	static {
		commands = new HashMap<>();
		
		commands.put("login", new LoginCommand());
		commands.put("addNewPatient", new AddNewPatientCommand());
		commands.put("checkNewLogin", new CheckNewLoginCommand());
		commands.put("createNewLogin", new AddNewLoginCommand());
		commands.put("exit", new FinishSessionComand());
		commands.put("viewStaff", new ListGenerationDoctorCommand());
		commands.put("viewNurse", new ListGenerationNurseCommand());
		commands.put("viewPatient", new ListGenerationPatientCommand());
		commands.put("redirect", new RedirectCommand());
		commands.put("sortDoctorList", new SortDoctorListCommand());
		commands.put("sortPatientList", new SortPatientListCommand());
		commands.put("deleteDoctor", new DeleteDoctorWithListCommand());
        commands.put("doctorToPatient", new AppointDoctorToPatientCommand());
		commands.put("doctorAppointment", new DoctorAppointmentListCommand());
		commands.put("addAppointment", new AddAppointmentCommand());
		commands.put("deleteAppointment", new DeleteAppointmentCommand());
		commands.put("confirmAppointment", new ConfirmDoctorAppointmentCommand());
		commands.put("confirmNurseAppointment", new ConfirmNurseAppointmentCommand());

	}

	public static Command getCommand(String commandName) {
		return commands.get(commandName);
	}
	
}
