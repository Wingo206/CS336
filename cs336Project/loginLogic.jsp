<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%
	try {
		//Get parameters from the HTML form at the index.jsp
		String usernameInput = request.getParameter("usernameInput");
		String passwordInput = request.getParameter("passwordInput");
		
		// check if any of the strings were empty
		if(usernameInput == "" || passwordInput == "") {
%>
			<html>
			<head>
				<title>Empty Field(s)</title>
			</head>
			<body>
				<h1>Empty Field(s)</h1>
				<p>Please fill out all of the fields provided.</p>
			</body>
			</html>
<%
			response.setHeader("Refresh", "2; URL=login.jsp"); // like a redirect, but with a delay

		} else {
			// check username account
			
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();	
			
			//Create a SQL statement
			Statement stmt = con.createStatement();
			//Make a SELECT query from the account table with the username = usernameInput
			String str = "SELECT password, accountType FROM account WHERE username = \"" + usernameInput + "\"";

			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);


			// No account found
			if(result.next() == false) {
	
%>
				<html>
				<head>
					<title>Account Not Found</title>
				</head>
				<body>
					<h1>Account Not Found</h1>
					<p>Enter correct username or register new username</p>
				</body>
				</html>
<%				
				con.close();

				response.setHeader("Refresh", "2; URL=login.jsp"); // like a redirect, but with a delay
			} else {
				// check credentials
				String checkPassword = result.getString("password");

				if(passwordInput.equals(checkPassword)) {
					// password matches
					
					// set username for session and accountType for user access
					session.setAttribute("username", usernameInput);

					String accountType = result.getString("accountType");
					session.setAttribute("accountType", accountType);

					con.close();
										
					if ("admin".equals((String) session.getAttribute("accountType"))) {
						response.sendRedirect("admin.jsp");
					}
					
					if ("customer".equals((String) session.getAttribute("accountType"))) {
						response.sendRedirect("loggedIn.jsp");
					}

					if ("representative".equals((String) session.getAttribute("accountType"))) {
						response.sendRedirect("rep.jsp");
					}
					
				} else {
					// password doesn't match
%>
					<html>
					<head>
						<title>Invalid Credentials</title>
					</head>
					<body>
						<h1>Invalid Credentials</h1>
						<p>Username and password don't match</p>
					</body>
					</html>
<%
					con.close();

					response.setHeader("Refresh", "2; URL=login.jsp"); // like a redirect, but with a delay
				}
			}
		}
	} catch (Exception ex) {
		out.print(ex);
		out.print("something went wrong");
	}
%>