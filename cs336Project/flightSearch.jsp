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

				String flightDep = request.getParameter("flightsFrom");
				String flightArrival = request.getParameter("flightsTo");
				String datePicked = request.getParameter("datePicker");
				String toDatePicked = request.getParameter("toDate");
				out.println(datePicked + "hello");

				String str2 = "SELECT * FROM flight WHERE departureAirport = '" + flightDep + "' AND arrivalAirport = '" + flightArrival + "'";

				if(datePicked != "") {
					// Make a SELECT query from the table flight
					str2 = "SELECT * FROM flight WHERE departureAirport = '" + flightDep + "' AND arrivalAirport = '"
					 + flightArrival + "' AND departureTime between '" + datePicked + "' AND '" + toDatePicked + "'";
				}				

				// Print or log the generated SQL query for debugging purposes
				out.println("Generated SQL Query: " + str);

				// Run the query against the database
				ResultSet result = stmt.executeQuery(str);
				// Get metadata to retrieve column names
				ResultSetMetaData metaData = result.getMetaData();
				int columnCount = metaData.getColumnCount();
		%>

		<form method="searchFlight" action="flightSearch.jsp">

			<br>
			 <label> From: </label>
			 <input type="date" id="datePicker" name="datePicker">

			 <label> To: </label>
			 <input type="date" id="toDate" name="toDate">
			<br>

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

				<label> To: </label>
				<select name = "flightsTo">

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
				
				<input type="submit" value="Search!" />
		</form>  

		<hr>

		<% 
				ResultSet result2 = stmt.executeQuery(str2);
				ResultSetMetaData metaData2 = result2.getMetaData();
				int columnCount2 = metaData2.getColumnCount();
		%>

		<table border="1">
			<tr>
				<!-- headers -->
				<%
				for (int i = 1; i <= columnCount2; i++) {
					out.println("<th>" + metaData2.getColumnName(i) + "</th>");
				}
				%>
			</tr>

			<!-- Parse out the results -->
			<%
			while (result2.next()) {
			%>
				<tr>
					<!-- data rows -->
					<%
					//if(result.getString(4).equals(flightDep) && result.getString(6).equals(flightArrival) ) {
						for (int i = 1; i <= columnCount2; i++) {
							out.println("<td>" + result2.getString(i) + "</td>");
						}
					//}
					%>
				</tr>

	<%
			} // Close the connection and resources
			db.closeConnection(con);	
			}
			 catch (Exception e) {
			// Log the exception instead of printing it to the page
				e.printStackTrace();
			}
	%>

	</body>
</html>