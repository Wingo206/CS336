<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Travel Reservation</title>
	</head>
	
	<body>

		Register

		<br>
			<form method="post" action="registerLogic.jsp">
			
			<table>
				<tr>    
					<td>Email: </td> <td><input type="text" name="emailInput"></td>
				</tr>
				<tr>
					<td>Password: </td><td><input type="text" name="passwordInput"></td>
				</tr>
                <tr>
					<td>Re-enter your password: </td><td><input type="text" name="passwordInput2"></td>
				</tr>
                <tr>
					<td>First Name: </td><td><input type="text" name="firstNameInput"></td>
				</tr>
                <tr>
					<td>Last Name: </td><td><input type="text" name="lastNameInput"></td>
				</tr>
			</table>
			<input type="submit" value="Create New Account">
			
			</form>
		<br>
		

	</body>
</html>