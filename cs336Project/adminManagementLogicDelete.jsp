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
String user = request.getParameter("usernameInput");
if("" == user) {
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
} else {
	// if account exists
	
	//Get the database connection
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();	
	
	//Create a SQL statement
	Statement stmt = con.createStatement();
	//Make a SELECT query from the account table with the username = user
	String str = "SELECT username FROM account WHERE username = \"" + user + "\"";

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
			<p>There is no user with this username</p>
		</body>
		</html>
<%
		con.close();
		response.setHeader("Refresh", "2; URL=adminManagement.jsp"); // like a redirect, but with a delay
	}  else {
		// new mysql comman
		str = "DELETE FROM account WHERE username = \"" + user + "\"";
				
		//Run the update against the database.
		stmt.executeUpdate(str);
		
		con.close();
		
		response.sendRedirect("adminManagement.jsp");
	}
	
	
	
	
}

%>