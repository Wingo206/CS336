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
		

<!-- Produce a list of reservations by flight number or by customer name -->
<!-- Flight number from flight, customer name from account, reservation from uses, all connected with flight ticket -->

		<br>

		Filter by:
		<form method="post" action="adminViewReservations.jsp">
		
		<table>
			<tr>    
				<td>Customer Name: </td>
				<td>
					<select name="customerFilter">
						<option value = "">[Customer Reset]</option>
						<%
						// Get the database connection
						ApplicationDB db = new ApplicationDB();
						Connection con = db.getConnection();
						Statement stmt = con.createStatement();

						ResultSet accountResult = stmt.executeQuery("select username, firstName, lastName, accountType from account where accountType = \"customer\"");
						while(accountResult.next()) {
							out.println("<option value=" + accountResult.getString("username") + ">" + accountResult.getString("firstName") + " " + accountResult.getString("lastName") + "</option>");
						}
						%>
					</select>
				</td>
			</tr>
			<tr>    
				<td>Flight Number: </td>
				<td>
					<select name="flightNumberFilter">
						<option value = "">[Flight Number Reset]</option>
						<%
						ResultSet flightNumResult = stmt.executeQuery("select flightNumber from flight");
						while(flightNumResult.next()) {
							out.println("<option value=" + flightNumResult.getString("flightNumber") + ">" + flightNumResult.getString("flightNumber") + "</option>");
						}
						%>
					</select>

				</td>
			</tr>
		</table>

		<br>

		<input type="submit" value="Apply Filter">
		
		</form>
		<br>
	
		<%
			String str = "select username, firstName, lastName, flight.flightNumber, seatNumber, uses.airline, flownBy, departureAirport, arrivalAirport, departureTime, arrivalTime from flightTicket join account on flightTicket.passenger = account.username join uses on flightTicket.ticketId = uses.ticketId join flight on uses.flightNumber = flight.flightNumber";
			
			String usernameFilter = request.getParameter("customerFilter");
			String flightNumberFilter = request.getParameter("flightNumberFilter");
			
			if(usernameFilter != null && usernameFilter != "") {
				str += " where username = \"" + usernameFilter + "\"";

				if(flightNumberFilter != null && flightNumberFilter != "") {
					str += " and flight.flightNumber = " + flightNumberFilter;

				}

			} else if(flightNumberFilter != null && flightNumberFilter != "") {
				str += " where flight.flightNumber = " + flightNumberFilter;

			}

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
