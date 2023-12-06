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
		<title>Monthly Sales Report</title>
	</head>
	
	<body>
		<br>
			<form method="get" action="admin.jsp">
				<input type="submit" value="Return to admin page">
			</form>
		<br>
		
		<br>
		<form method="post" action="adminSalesReportLogic.jsp">
		
		<table>
			<tr>    
				<td>Month: </td>
				<td>
					<select name="monthInput">
					<option value="January">January</option>
					<option value="February">February</option>
					<option value="March">March</option>
					<option value="April">April</option>
					<option value="May">May</option>
					<option value="June">June</option>
					<option value="July">July</option>
					<option value="August">August</option>
					<option value="September">September</option>
					<option value="October">October</option>
					<option value="November">November</option>
					<option value="December">December</option>
					</select>
				</td>
			</tr>
			<tr>    
				<td>Year: </td>
				<td>
					<select name="yearInput">
					<option value="2023">2023</option>
					<option value="2024">2024</option>
					</select>

				</td>
			</tr>
		</table>

		<br>

		<input type="submit" value="View Monthly Report">
		
		</form>
		<br>

		


		<!-- WIP -->


		
	</body>
</html>
