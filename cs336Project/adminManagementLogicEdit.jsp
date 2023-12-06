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
String user = request.getParameter("user");
//out.print("user is " + request.getParameter("user"));

String[] attributesList = {"username", "password", "firstName", "lastName", "accountType"};
String nonNullAttribute = "";

for(String attributeChecker : attributesList) {
	if(request.getParameter(attributeChecker) != null) {
		nonNullAttribute = attributeChecker;
	}
}

//out.println("nonNullAttribute is " + nonNullAttribute);

String newValue = request.getParameter(nonNullAttribute);
if("" == newValue) {
%>
			<html>
			<head>
				<title>Empty Field</title>
			</head>
			<body>
				<h1>Empty Field</h1>
				<p>Field submission was empty</p>
			</body>
			</html>
<%
		response.setHeader("Refresh", "2; URL=adminManagement.jsp"); // like a redirect, but with a delay
} else if(nonNullAttribute.equals("accountType") && !(newValue.equals("customer") || newValue.equals("representative")) ) {
%>
			<html>
			<head>
				<title>Invalid Account Type</title>
			</head>
			<body>
				<h1>Invalid Account Type</h1>
				<p>Account Type must be customer or representative</p>
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
	String str = "UPDATE account SET " + nonNullAttribute + " = \"" + newValue + "\" WHERE username = \"" + user + "\"";
	
	//out.println(str);
	
	//Run the update against the database.
	stmt.executeUpdate(str);
	
	con.close();
	
	response.sendRedirect("adminManagement.jsp");
}

%>