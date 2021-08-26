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
	public String execute(HttpServletRequest req, HttpServletResponse resp) {

		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb", "root", "Rusleo1984");
			System.out.println("con ==> " + con);

			ResultSet rs = con.createStatement().executeQuery("select * from doctor");

			List<Staff> users = new ArrayList<>();
			while (rs.next()) {
				Staff user = new Doctor();
				user.setId(rs.getInt("id"));
				user.setLogin(rs.getString("login"));
				user.setPassword(rs.getString("password"));

				users.add(user);
			}
			req.setAttribute("users", users);
		} catch (Exception ex) {
			ex.printStackTrace();
		}

		return "listUsers.jsp";
	}

}
