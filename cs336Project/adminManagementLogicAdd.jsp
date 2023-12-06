<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<!-- redirect client to access denied page -->
<%
	if (!"admin".equals((String) session.getAttribute("accountType"))) {
		response.sendRedirect("adminDeny.jsp");
	}
%>

<%
String username = request.getParameter("usernameInput");
String password = request.getParameter("passwordInput");
String firstName = request.getParameter("firstNameInput");
String lastName = request.getParameter("lastNameInput");
String accountType = request.getParameter("accountTypeInput");

String newValue = request.getParameter(nonNullAttribute);
if("" == username || "" == password || "" == firstName || "" == lastName || "" == accountType) {
%>
			<html>
			<head>
				<title>Empty Field(s)</title>
			</head>
			<body>
				<h1>Empty Field(s)</h1>
				<p>Please fill out all of the fields provided</p>
			</body>
			</html>
<%
		response.setHeader("Refresh", "2; URL=adminManagement.jsp"); // like a redirect, but with a delay
} else
if("accountType" == nonNullAttribute && ("customer" != newValue || "representative" != newValue || "admin" != newValue )) {
%>
			<html>
			<head>
				<title>Invalid Account Type</title>
			</head>
			<body>
				<h1>Invalid Account Type</h1>
				<p>Account Type must be customer, representative, or admin</p>
			</body>
			</html>
<%
		response.setHeader("Refresh", "2; URL=adminManagement.jsp"); // like a redirect, but with a delay
} else {
	//Get the database connection
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();	
	
	//Create a SQL statement
	Statement stmt = con.createStatement();
	//Make an UPDATE query from the account table with the username = user
	String str = "INSERT INTO account (username, password, firstName, lastName, accountType) " + nonNullAttribute + " = \"" + newValue + "\" WHERE username = \"" + user + "\"";
	
	//out.println(str);
	
	//Run the update against the database.
	stmt.executeUpdate(str);
	
	con.close();
	
	response.sendRedirect("adminManagement.jsp");
}

%>