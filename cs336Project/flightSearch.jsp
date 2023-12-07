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
				String minPrices = request.getParameter("minPrice");
				String maxPrices = request.getParameter("maxPrice");
				String airlinePicked = request.getParameter("alines");
				out.println(datePicked + "hello" + minPrices);

				String str2 = "SELECT * FROM flight WHERE flightNumber > '0'";

				//List of search and filter options 
				//need to check if they are null or not
				if(flightDep != "null") {
					str2 += " AND departureAirport = '" + flightDep + "'";
				}

				if(flightArrival != "null") {
					str2 += " AND arrivalAirport = '" + flightArrival + "'";
				}

				if(datePicked != "" && toDatePicked != "") {
					str2 += " AND departureTime between '" + datePicked + "' AND '" + toDatePicked + "'";
				}
				else if(datePicked != "") {
					str2 += " AND departureTime > '" + datePicked + "'";	
				}
				else if(toDatePicked != "") {
					str2 += " AND departureTime < '" + toDatePicked + "'";
				}

				if(minPrices != "") {
					str2 += " AND price > '" + minPrices + "'";
				}

				if(maxPrices != "") {
					str2 += " AND price < '" + maxPrices + "'";
				}

				if(airlinePicked != "null") {
					str2 += " AND airline = '" + airlinePicked + "'";
				}

				String str3 = "SELECT * FROM airline";

				// Print or log the generated SQL query for debugging purposes
				out.println("Generated SQL Query: " + str2);

				// Run the query against the database
				ResultSet result3 = stmt.executeQuery(str3);
				// Get metadata to retrieve column names
				ResultSetMetaData metaData3 = result3.getMetaData();
				int columnCount3 = metaData3.getColumnCount();
		%>

		<form method="searchFlight" action="flightSearch.jsp">

			<br>
			 <label> From: </label>
			 <input type="date" id="datePicker" name="datePicker">

			 <label> To: </label>
			 <input type="date" id="toDate" name="toDate">
			<br>

			<br>
			 <label> Minimum Price: </label>
			 <input type="number" step="0.01" id="minPrice" name="minPrice">

			 <label> Maximum Price: </label>
			 <input type="number" step="0.01" id="maxPrice" name="maxPrice">
			<br>
			
			<br>
			<label> Airline: </label>
				<select name = "alines">
					<option disabled selected value> -- select an option -- </option>
					<%
					result3.beforeFirst();
					while (result3.next()) {
					%>
						<% for (int i = 1; i <= columnCount3; i++) { %>
							<% out.println(result3.getString(i)); %>
							<option value ="<%= result3.getString(i) %>"><%= result3.getString(i) %></option>

						<% } %>
					<% } %>

				</select>
			<br>

			<% 
				// Run the query against the database
				ResultSet result = stmt.executeQuery(str);
				// Get metadata to retrieve column names
				ResultSetMetaData metaData = result.getMetaData();
				int columnCount = metaData.getColumnCount();
			%>

			<br>
			<label> From: </label>
				<select name = "flightsFrom">
					<option disabled selected value> -- select an option -- </option>
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
					<option disabled selected value> -- select an option -- </option>
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
				<br>

				<br>
				<input type="submit" value="Search!" />
				<br>
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