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

				// Make a SELECT query from the table airport
				String str = "SELECT * FROM airport";

				// Print or log the generated SQL query for debugging purposes
				out.println("Generated SQL Query: " + str);

				// Run the query against the database
				ResultSet result = stmt.executeQuery(str);

				// Get metadata to retrieve column names
				ResultSetMetaData metaData = result.getMetaData();
				int columnCount = metaData.getColumnCount();
					
		%>

		<form>
			<label> To: </label>
				<select name = "flightsTo">

					<%
					while (result.next()) {
					%>
						<% for (int i = 1; i <= columnCount; i++) { %>
							<% out.println(result.getString(i)); %>
							<option value ="<%= result.getString(i) %>"><%= result.getString(i) %></option>

						<% } %>
					<% } %>

				</select>

			<label> From: </label>
				<select name = "flightsFrom">

					<%
					result.beforeFirst();
					while (result.next()) {
					%>
						<% for (int i = 1; i <= columnCount; i++) { %>
							<% out.println(result.getString(i)); %>
							<option value ="<%= result.getString(i) %>"><%= result.getString(i) %></option>

						<% } %>
					<% } %>

				</select>
		</form>  

	<%
			} catch (Exception e) {
			// Log the exception instead of printing it to the page
				e.printStackTrace();
			}
	%>

	</body>
</html>