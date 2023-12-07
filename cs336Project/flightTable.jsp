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
		<%
			try {
				// Get the database connection
				ApplicationDB db = new ApplicationDB();
				Connection con = db.getConnection();

				// Create a SQL statement
				Statement stmt = con.createStatement();

				String flightDep = request.getParameter("flightsFrom");
				String flightArrival = request.getParameter("flightsTo");

				// Make a SELECT query from the table flight
				String str = "SELECT * FROM flight WHERE departureAirport = '" + flightDep + "' AND arrivalAirport = '" + flightArrival + "'";

				// Print or log the generated SQL query for debugging purposes
				out.println("Generated SQL Query: " + str);

				// Run the query against the database
				ResultSet result = stmt.executeQuery(str);

				// Get metadata to retrieve column names
				ResultSetMetaData metaData = result.getMetaData();
				int columnCount = metaData.getColumnCount();

		%>

			<table border="1">
			<tr>
				<!-- headers -->
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
					<!-- data rows -->
					<%
					//if(result.getString(4).equals(flightDep) && result.getString(6).equals(flightArrival) ) {
						for (int i = 1; i <= columnCount; i++) {
							out.println("<td>" + result.getString(i) + "</td>");
						}
					//}
					%>
				</tr>
			
		<%	}

	
		
			// Close the connection and resources
			db.closeConnection(con);
			} catch (Exception e) {
			// Log the exception instead of printing it to the page
				e.printStackTrace();
			}
		%>

	</body>
</html>