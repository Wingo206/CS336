<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Travel Reservation Login</title>
	</head>
	
	<body>

		<!-- Testing that logging out removes the "user" session -->
		<!-- 		
		<%
			String name=(String)session.getAttribute("user");
			out.print("Current user "+ name);
		%>
		 -->


		Login Page

		<br>
			<form method="post" action="loginLogic.jsp">
			
			<table>
				<tr>    
					<td>Username: </td> <td><input type="text" name="usernameInput"></td>
				</tr>
				<tr>
					<td>Password: </td><td><input type="text" name="passwordInput"></td>
				</tr>
			</table>
			<input type="submit" value="Login">
			
			</form>
		<br>
		
		New member?

		<br>
			<form method="post" action="register.jsp">
			<input type="submit" value="Create New Account">
			</form>
		<br>

	</body>
</html>