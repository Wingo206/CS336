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

		You are logged in! 
		
		<%
			String username = (String) session.getAttribute("username");
			out.print("Hello "+ username);
			
			String accountType =(String) session.getAttribute("accountType");
			out.print("Hello "+ accountType);



		%>

		<br>
			 <input type="date" id="date">
		<br>

		<br>
	
		 <!-- Show html form to i) display something, ii) choose an action via a 
		  | radio button -->
		<form method="post" action="showTable.jsp">
			<br>
				<input type="radio" id="account" name="flight_type" value="account">
				<label for="account">account</label><br>

				<input type="radio" id="flights" name="flight_type" value="flight">
				<label for="round-trip">One-Way</label><br>
				
				<input type="radio" id="onew/roundp" name="flight_type" value="flight">
				<label for="onew/roundp">Round-Trip</label>
			<br>
		  <input type="submit" value="display" />
		</form>
		<br>

		<hr>
		<form method="post" action="flightSearch.jsp">
			<input type="submit" value="flightSearch" />
		</form>
			
		<hr>
		<form method="get" action="questions.jsp">
			<input type="submit" value="View questions page">
		</form>

		<hr>
		<form method="get" action="logout.jsp">
			<input type="submit" value="Logout">
		</form>
		
	</body>
</html>
