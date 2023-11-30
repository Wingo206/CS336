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

			// Get the selected radio button
			String entity = request.getParameter("flight_type");

			// Check if entity is null or empty
			if (entity == null || entity.isEmpty()) {
				// Handle the error or set a default entity
				entity = "flightTicket";
			}

			// Make a SELECT query from the table specified by the 'flight_type' parameter
			String str = "SELECT * FROM " + entity;

			// Print or log the generated SQL query for debugging purposes
			out.println("Generated SQL Query: " + str);

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

		} catch (Exception e) {
			// Log the exception instead of printing it to the page
			e.printStackTrace();
		}
		%>
		</table>
	</body>
</html>