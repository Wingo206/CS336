<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>View Tickets</title>
	</head>
	
	<body>
		<form type="post" action="loggedIn.jsp">
            <input type="submit" value="Back to logged in"/>
        </form>
        <hr>
		<h3>View Your Tickets</h3>
		<hr>
		<h3>Upcoming Tickets</h3>
		<%
		try {
			// Get the database connection
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();

			// Create a SQL statement
			Statement stmt = con.createStatement();

            String username = (String) session.getAttribute("username");

			// Make a SELECT query from the table specified by the 'flight_type' parameter            
			String str = "SELECT ft.ticketId, f.flightNumber, f.airline, f.departureAirport, f.departureTime, f.arrivalAirport, f.arrivaltime, u.seatNumber, class FROM flightTicket ft JOIN uses u ON ft.ticketId = u.ticketId JOIN flight f ON u.flightNumber = f.flightNumber AND u.airline = f.airline WHERE passenger = '"+username+"' AND f.departureTime > NOW() ORDER BY ft.ticketId";

			// Run the query against the database
			ResultSet result = stmt.executeQuery(str);

			// Get metadata to retrieve column names
			ResultSetMetaData metaData = result.getMetaData();
			int columnCount = metaData.getColumnCount();
		%>

		<!-- Make an HTML table to show the results -->
		<table border="1">
			<tr>
				<!-- Generate table headers dynamically -->
				<th>Delete</th>
				<th>Change</th>
				<%
				for (int i = 1; i <= columnCount; i++) {
					out.println("<th>" + metaData.getColumnName(i) + "</th>");
				}
				%>
			</tr>

			<!-- Parse out the results -->
			<%
			// figure out grouping
			ArrayList<String> ticketIds = new ArrayList<String>();
			while (result.next()) {
				ticketIds.add(result.getString(1));
			}
			result.beforeFirst();
			int index = 0;
			while (result.next()) {
			%>
			<tr>
				<!-- Generate table rows dynamically -->
				<%
				for (int i = 1; i <= columnCount; i++) {
					if (i == 1) {
						int amt = 0;
						if (index > 0 && ticketIds.get(index-1).equals(ticketIds.get(index))) {
							//skip
						} else {
							for (int j = index; j < ticketIds.size(); j++) {
								if (ticketIds.get(j).equals(ticketIds.get(index))) {
									amt++;
								}
							}
							out.println("<td rowspan='"+amt+"'><form method='post' action='viewTicketsDelete.jsp'>"+
							"<input type='hidden' name='ticketId' value='"+ticketIds.get(index)+"'>"+
							"<input type='hidden' name=fine value='"+((result.getString(9).equals("economy"))?"true":"false")+"'>"+
							"<input type='submit' value='Delete'>"+
							"</form></td>");
							out.println("<td rowspan='"+amt+"'><form method='post' action='viewTicketsDelete.jsp'>"+
							"<input type='hidden' name='ticketId' value='"+ticketIds.get(index)+"'>"+
							"<input type='hidden' name='ticketId' value='"+ticketIds.get(index)+"'>"+
							"<input type='hidden' name=fine value='"+((result.getString(9).equals("economy"))?"true":"false")+"'>"+
							"<select name='classChoice'>"+
							"<option value='economy'>Economy</option>"+
							"<option value='business'>Business</option>"+
							"<option value='firstclass'>First Class</option>"+
							"</select><input type='submit' value='Change class'>"+
							"</form></td>");
							
							out.println("<td rowspan='"+amt+"'>" + result.getString(i) + "</td>");
						}
						
						index ++;
					} else {
						out.println("<td>" + result.getString(i) + "</td>");
					}
				}
				%>
			</tr>
			<%
			}
			%>
		</table>
<%
			str = "SELECT ft.ticketId, f.flightNumber, f.airline, f.departureAirport, f.departureTime, f.arrivalAirport, f.arrivaltime, u.seatNumber, class FROM flightTicket ft JOIN uses u ON ft.ticketId = u.ticketId JOIN flight f ON u.flightNumber = f.flightNumber AND u.airline = f.airline WHERE passenger = '"+username+"' AND f.arrivalTime < NOW() ORDER BY ft.ticketId";
			// Run the query against the database
			result = stmt.executeQuery(str);

			// Get metadata to retrieve column names
			metaData = result.getMetaData();
			columnCount = metaData.getColumnCount();
			%>
			<hr>
			<h3>Past Tickets</h3>
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
			// figure out grouping
			ticketIds = new ArrayList<String>();
			while (result.next()) {
				ticketIds.add(result.getString(1));
			}
			result.beforeFirst();
			index = 0;
			while (result.next()) {
			%>
			<tr>
				<!-- Generate table rows dynamically -->
				<%
				for (int i = 1; i <= columnCount; i++) {
					if (i == 1) {
						int amt = 0;
						if (index > 0 && ticketIds.get(index-1).equals(ticketIds.get(index))) {
							//skip
						} else {
							for (int j = index; j < ticketIds.size(); j++) {
								if (ticketIds.get(j).equals(ticketIds.get(index))) {
									amt++;
								}
							}
							
							out.println("<td rowspan='"+amt+"'>" + result.getString(i) + "</td>");
						}
						
						index ++;
					} else {
						out.println("<td>" + result.getString(i) + "</td>");
					}
				}
				%>
			</tr>
			<%
			}
			%>
		</table>

			<%

                
		
			// Close the connection and resources
			db.closeConnection(con);

		} catch (Exception e) {
			// Log the exception instead of printing it to the page
			e.printStackTrace();
			out.print(e.getMessage());
		}
		%>
	</body>
</html>