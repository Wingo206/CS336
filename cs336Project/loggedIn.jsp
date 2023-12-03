<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>


<%
if (request.getParameter("logout") != null) {
	session.setAttribute("user", null);
}
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Travel Reservation</title>
	</head>
	
	<body>

		You are logged in! 
		
		<%
			String name=(String) session.getAttribute("user");
			out.print("Hello "+name);
		%>

		<br>
			

			 <input type="date" id="date">
		<br>

		<br>
	
		 <!-- Show html form to i) display something, ii) choose an action via a 
		  | radio button -->
		<form method="post" action="showTable.jsp">
			<br>
				<input type="radio" id="customeraccount" name="flight_type" value="customeraccount">
				<label for="customeraccount">customeraccount</label><br>
				<input type="radio" id="round-trip" name="flight_type" value="Round-Trip">
				<label for="round-trip">Round-Trip</label><br>
				<input type="radio" id="onew/roundp" name="flight_type" value="One-Way/Round-Trip">
				<label for="onew/roundp">One-Way/Round-Trip</label>
			<br>
		  <input type="submit" value="display" />
		</form>
		<br>

			
		<br>
			<form method="get" action="logout.jsp">
				<input type="submit" value="Logout">
			</form>
		<br>
		
	</body>
</html>
