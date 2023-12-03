<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<%
	try {
		//Get parameters from the HTML form at the index.jsp
		String usernameInput = request.getParameter("usernameInput");
		String passwordInput = request.getParameter("passwordInput");
		String firstNameInput = request.getParameter("firstNameInput");
		String lastNameInput = request.getParameter("lastNameInput");

		// check if any of the strings were empty
		if(usernameInput == "" || passwordInput == "" || firstNameInput == "" || lastNameInput == "") {
%>
<html>
<head>
	<title>Empty Fields</title>
</head>
<body>
	<h1>Empty Fields</h1>
	<p>Please fill out all of the fields provided.</p>
</body>
</html>
<%
		response.setHeader("Refresh", "2; URL=register.jsp"); // like a redirect, but with a delay

		} else {


			// catch duplicate usernames

			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();	

			//Create a SQL statement
			Statement stmt = con.createStatement();
			//Make a SELECT query from the account table with the username = usernameInput
			String str = "SELECT username FROM account WHERE username = '" + usernameInput + "'";

			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);

			// No duplicate username
			if(result.next() == false) {
				//Make an insert statement for the account table:
				String insert = "INSERT INTO account(username, password, firstName, lastName, accountType)"
				+ "VALUES (?, ?, ?, ?, 'customer')";
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

%>
				<html>
				<head>
					<title>Account Created</title>
				</head>
				<body>
					<h1>Account Created</h1>
					<p>An account for "<%= usernameInput %>" has been successfully created.</p>
				</body>
				</html>


<%
				response.setHeader("Refresh", "2; URL=login.jsp"); // like a redirect, but with a delay


			} else {
				String exists = result.getString("username");

				//close the connection.
				con.close();

%>
				<html>
				<head>
					<title>Username Taken</title>
				</head>
				<body>
					<h1>Username Taken</h1>
					<p>The username "<%= exists %>" is already taken. Please choose a different one.</p>
				</body>
				</html>
<%

				response.setHeader("Refresh", "2; URL=register.jsp"); // like a redirect, but with a delay
			}

		}

	} catch (Exception ex) {
		out.print(ex);
		out.print("insert failed");
	}
%>





