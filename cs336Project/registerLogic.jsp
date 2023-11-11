<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Register</title>
</head>
<body>

	<%
		try {
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();

			//Create a SQL statement
			Statement stmt = con.createStatement();

			//Get parameters from the HTML form at the index.jsp
			String usernameInput = request.getParameter("usernameInput");
			String passwordInput = request.getParameter("passwordInput");
			String firstNameInput = request.getParameter("firstNameInput");
			String lastNameInput = request.getParameter("lastNameInput");


			//Make an insert statement for the CustomerAccount table:
			String insert = "INSERT INTO CustomerAccount(username, password, firstName, lastName)"
					+ "VALUES (?, ?, ?, ?)";
			//Create a Prepared SQL statement allowing you to introduce the parameters of the query
			PreparedStatement ps = con.prepareStatement(insert);

			//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
			ps.setString(1, usernameInput);
			ps.setString(2, passwordInput);
			ps.setString(3, firstNameInput);
			ps.setString(4, lastNameInput);

			//Run the query against the DB
			ps.executeUpdate();
			//Run the query against the DB
			
			//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
			con.close();
			out.print("insert succeeded");
			
		} catch (Exception ex) {
			out.print(ex);
			out.print("insert failed");
		}
	%>


</body>
</html>