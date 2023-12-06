<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>


<!-- redirect client to access denied page -->
<%
	if (!"admin".equals((String) session.getAttribute("accountType"))) {
		response.sendRedirect("adminDeny.jsp");
	}
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Travel Reservation</title>
	</head>
	
	<body>

		<!-- You are logged in!  -->
		
		<%
			String username = (String) session.getAttribute("username");
			String accountType = (String) session.getAttribute("accountType");

			out.println("Logged in as: "+ username + " (" + accountType + ")");
			

		%>

		<br>


		<br>
			<form method="get" action="adminManagement.jsp">
				<input type="submit" value="Manage Customers and Representatives">
			</form>
		<br>

		<br>
			<form method="get" action="adminSalesReport.jsp">
				<input type="submit" value="View Sales Reports">
			</form>
		<br>

		<br>
			<form method="get" action="adminViewReservations.jsp">
				<input type="submit" value="View List of Reservations">
			</form>
		<br>
		<!-- list of most active flights -->

		<br>
			<form method="get" action="logout.jsp">
				<input type="submit" value="View Revenue Report">
			</form>
		<br>


		<br>
			<form method="get" action="logout.jsp">
				<input type="submit" value="Logout">
			</form>
		<br>
		
	</body>
</html>
