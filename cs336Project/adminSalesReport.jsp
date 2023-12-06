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

		Filter by month:

		<form method="post" action="adminSalesReport.jsp">
		
		<table>
			<tr>
				<td>Month: </td>
				<td>
					<select name="monthInput">
					<option value="">[Month Reset]</option>
					<option value="01">January</option>
					<option value="02">February</option>
					<option value="03">March</option>
					<option value="04">April</option>
					<option value="05">May</option>
					<option value="06">June</option>
					<option value="07">July</option>
					<option value="08">August</option>
					<option value="09">September</option>
					<option value="10">October</option>
					<option value="11">November</option>
					<option value="12">December</option>
					</select>
				</td>
			</tr>
			<tr>    
				<td>Year: </td>
				<td>
					<select name="yearInput">
					<option value="">[Year Reset]</option>
					<option value="2023">2023</option>
					<option value="2024">2024</option>
					</select>
				</td>
			</tr>
		</table>
		<br>
		<input type="submit" value="View Report for Month">
		
		</form>
		<br>

		<%
		// Get the database connection
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();
		Statement stmt = con.createStatement();

		String str = "select purchaseDateTime, ticketId, totalFare from flightticket";

		String monthInput = request.getParameter("monthInput");
		String yearInput = request.getParameter("yearInput");

		
		if(!(monthInput == null || monthInput == "") && !(yearInput == null || yearInput == "")) {

			String startDate = yearInput + "-" + monthInput + "-01";

			str += " where purchaseDateTime >= '" + startDate + "' and purchaseDateTime <= LAST_DAY('" + startDate + "')";
			
			String monthString = "";
			switch(Integer.parseInt(monthInput)) {
				case 1:
					monthString = "January"; 
					break;
				case 2:
					monthString = "Februrary"; 
					break;
				case 3:
					monthString = "March"; 
					break;
				case 4:
					monthString = "April"; 
					break;
				case 5:
					monthString = "May"; 
					break;
				case 6:
					monthString = "June";
					break;
				case 7:
					monthString = "July"; 
					break;
				case 8:
					monthString = "August";
					break;
				case 9:
					monthString = "September";
					break;
				case 10:
					monthString = "October"; 
					break;
				case 11:
					monthString = "November"; 
					break;
				case 12:
					monthString = "December"; 
					break;


			}
			out.println("Showing Report for " + monthString + " " + yearInput + ":");
			
		} else {
			out.println("Showing Report for all Sales:");

		}
		
		//out.println(str);

		ResultSet result = stmt.executeQuery(str);

		// Get metadata to retrieve column names
		ResultSetMetaData metaData = result.getMetaData();

		int columnCount = metaData.getColumnCount();
		%>

		<!-- Make an HTML table to show the results -->
		<table border="1">
			<tr>
				<!-- Generate table headers dynamically -->
				<%
				for (int i = 1; i <= columnCount; i++) {
					out.println("<th>" + metaData.getColumnName(i) + "</th>");
				}
				%>
			</tr>

			<!-- Parse out the results -->
			<%
			while (result.next()) {
			%>
				<tr>
					<!-- Generate table rows dynamically -->
					<%
					for (int i = 1; i <= columnCount; i++) {
						out.println("<td>" + result.getString(i) + "</td>");
					}
					%>
				</tr>
			<%
			}

			// Close the connection and resources
			db.closeConnection(con);
			%>
		</table>



		
	</body>
</html>
