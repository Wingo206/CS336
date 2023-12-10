<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!-- redirect client to login page-->
<%
	if (session.getAttribute("accountType") == null) {
		response.sendRedirect("signedOut.jsp");
	}
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Travel Reservation</title>
		<style>
		th, td {
			padding-top: 10px;
			padding-bottom: 10px;
			padding-left: 10px;
			padding-right: 10px;
		}
		</style>
	</head>
	
	<body>
		<form type="post" action="loggedIn.jsp">
            <input type="submit" value="Back to logged in"/>
        </form>
        <hr>
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
				String flexibleD = request.getParameter("flexibleDate");
				String minPrices = request.getParameter("minPrice");
				String maxPrices = request.getParameter("maxPrice");
				String airlinePicked = request.getParameter("alines");
				String takeOffTime = request.getParameter("takeOff");
				takeOffTime = takeOffTime + ":00";
				String takeOffE = request.getParameter("takeOffEnd");
				takeOffE = takeOffE + ":00";
				String landingTime = request.getParameter("landing");
				landingTime = landingTime + ":00";
				String landingE = request.getParameter("landingEnd");
				landingE = landingE + ":00";
				String numOfStopsString = request.getParameter("maxStops");
				int numOfStops;
				if(numOfStopsString == null || numOfStopsString.equals("")) {
					numOfStops = 1;
				} 
				else {
					numOfStops = Integer.parseInt(numOfStopsString);
				}
				if(numOfStops <= 0 || numOfStops > 5) {
					numOfStops = 1;
				}
				String sortOption = request.getParameter("sortList");
				String typeTrip = request.getParameter("typeOfTrip");
				out.println(typeTrip);
				//out.println(datePicked + "hello" + takeOffTime);
				if(typeTrip != null && typeTrip == "round") {
						numOfStops = 2;
					}
				
				String str2 = "SELECT * FROM flight WHERE flightNumber > '0'";

				//Generate multistops
				String[] columns = {"flightNumber", "airline", "flownBy", "departureAirport", "departureTime", "arrivalAirport", "arrivalTime", "price"};
				String multiStopQuery = "SELECT * FROM ";
				
				//SELECT f1.flightNumber flight, f2.flightNumber returnFlight 
				//FROM flight f1 
				//JOIN flight f2 on f1.arrivalAirport = f2.departureAirport AND f1.departureAirport = f2.arrivalAirport 
				//WHERE f2.departureTime > f1.arrivalTime;
				if(typeTrip != null && typeTrip.equals("round")) {

					String roundTripQuery = "SELECT ";

					for(int k = 1; k <= 2; k++) {
						for(int j = 0; j < columns.length; j++) {
								roundTripQuery += "f" + k + "." + columns[j] + " " + columns[j] + k + ", ";	
						}
							
					}
					roundTripQuery += "f1.price + f2.price AS totalCost" + ", ";
					roundTripQuery += "f1.departureTime AS firstDep, f2.arrivalTime AS lastArrival, ";
					roundTripQuery += "TIMESTAMPDIFF(HOUR, f1.departureTime, f2.arrivalTime) AS flightDurationInHours ";
					roundTripQuery += "FROM flight f1 JOIN flight f2 on f1.arrivalAirport = f2.departureAirport AND f1.departureAirport = f2.arrivalAirport AND f2.departureTime > f1.arrivalTime";
					if(airlinePicked != null && airlinePicked != "null") {
						roundTripQuery += " WHERE f1.airline = '" + airlinePicked + "' AND f2.airline = '" + airlinePicked + "'";
					}
					if(flightDep != null){
						roundTripQuery += " AND f1" + ".departureAirport = '" + flightDep + "' ";
					}
					else if(flightArrival != null) {
						roundTripQuery += " AND f1" + ".arrivalAirport = '" + flightArrival + "' ";
					}

					multiStopQuery += "( " + roundTripQuery + " ";
				}
				else {
					multiStopQuery += "(";
					for(int i = 1; i <= numOfStops; i++) {
						String query = "SELECT ";
						for(int k = 1; k <= numOfStops; k++) {
							for(int j = 0; j < columns.length; j++) {
								if(k <= i) {
									query += "f" + k + "." + columns[j] + " " + columns[j] + k + ", ";
								}
								else {
									query += "NULL AS " + columns[j] + k + ", ";
								}
							}

							if(k == numOfStops) {
							for(int a = 1; a <= i; a++) {
								//you have to add sum here
								query += "f" + a + ".price + ";
							}
							query = query.substring(0, query.length()-3);
							query += " AS totalCost" + ", ";
							}

						}
						
						query+= "f1.departureTime AS firstDep, f" + i + ".arrivalTime AS lastArrival, ";
						query += "TIMESTAMPDIFF(HOUR, f1.departureTime, f" + i + ".arrivalTime) AS flightDurationInHours, ";
						
						query = query.substring(0,query.length()-2);
						query += " FROM flight f1 ";
						for(int k = 2; k <= i; k++) {
							query += "JOIN flight f" + k + " ON f" + (k-1) + ".arrivalAirport = f" + k + ".departureAirport ";
						}

						for(int k = 2; k <= i; k++) {
							query += " AND f" + k + ".departureTime > f" + (k-1) + ".arrivalTime ";
						}

						query += "WHERE true = true";

						
						if(flightDep != null){
							query += " AND f1" + ".departureAirport = '" + flightDep + "' ";
						}
						else if(flightArrival != null) {
							query += " AND f" + i + ".arrivalAirport = '" + flightArrival + "' ";
						}

						for(int b = 1; b <= i; b++) {
							if(airlinePicked != null && airlinePicked != "null") {
								query += " AND f" + b + ".airline = '" + airlinePicked + "'";
							}
						}
						

						//multiStopQuery += "( " + query + " ) "+((i == 1)?"t1":"")+" UNION ";
						multiStopQuery += "( " + query + " ) UNION ";
					}
					multiStopQuery = multiStopQuery.substring(0, multiStopQuery.length()-6);
				}
				
				

				multiStopQuery += ") t1 WHERE true = true";

				if(minPrices != "") {
					multiStopQuery += " AND totalCost >= '" + minPrices + "' ";
				}

				if(maxPrices != "") {
					multiStopQuery += " AND totalCost <= '" + maxPrices + "' ";
				}

				if(flexibleD != "" && flexibleD == "flexibleDate") {
					if(datePicked != "") {
						//Date flexibleMin = new Date(datePicked);
						multiStopQuery += " AND firstDep between '" + datePicked + "' AND " + datePicked + "'";	
					}
					else if(toDatePicked != "") {
						multiStopQuery += " AND lastArrival between '" + toDatePicked + "' AND " + toDatePicked + "'";	
					}
				}
				else if(datePicked != "") {
					multiStopQuery += " AND firstDep = '" + datePicked + "'";	
				}
				else if(toDatePicked != "") {
					multiStopQuery += " AND lastArrival = '" + toDatePicked + "'";
				}

				if(takeOffE != null && !takeOffE.equals(":00") && takeOffTime != null && !takeOffTime.equals(":00")) {
					multiStopQuery += " AND firstDep between '%" + takeOffTime.substring(0,2) + ":__:__" + "%' AND '%" + takeOffE.substring(0,2) + ":__:__" + "%'";					
				}
				else if(takeOffTime != null && !takeOffTime.equals(":00")) {
					multiStopQuery += " AND firstDep LIKE '%" + takeOffTime.substring(0,2) + ":__:__" + "%'";
					//out.println(takeOffTime);
					//out.println(str2);
				}
				else if(takeOffE != null && !takeOffE.equals(":00") ) {
					multiStopQuery += " AND firstDep LIKE '%" + takeOffE.substring(0,2) + ":__:__" + "%'";					
				}

				if(landingE != null && !landingE.equals(":00") && landingTime != null && !landingTime.equals(":00")) {
					multiStopQuery += " AND lastArrival between '%" + landingTime.substring(0,2) + ":__:__" + "%' AND '%" + landingE.substring(0,2) + ":__:__" + "%'";					
				}
				else if(landingTime != null && !landingTime.equals(":00")) {
					multiStopQuery += " AND lastArrival LIKE '%" + landingTime.substring(0,2) + ":__:__" + "%'";	
				}
				else if(landingE != null && !landingE.equals(":00")) {
					multiStopQuery += " AND lastArrival LIKE '%" + landingE.substring(0,2) + ":__:__" + "%'";					
				}

				

				//out.println(multiStopQuery);

				//List of search and filter options 
				//need to check if they are null or not
				if(flightDep != null && flightDep != "null") {
					str2 += " AND departureAirport = '" + flightDep + "'";
				}
 

				
				//Start the filter conditions here with OrderBy
				if(sortOption != null) {
					out.println(sortOption);
					multiStopQuery += " ORDER BY " + sortOption;
				}

				out.println(multiStopQuery);

				String str3 = "SELECT * FROM airline";

				// Print or log the generated SQL query for debugging purposes
				//out.println("Generated SQL Query: " + str2);

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
			<label> Flexible Dates: </label>
			<input type = "radio" id = "flexibleDate" name = "flexibleDate" value="flexibleDate">
			<label for="flexibleDate"> (+/-3 days) </label>
			<br>

			<br>
			<label> Max Number of Stops: </label>
			<input type = "number" step="1" id="maxStops" name ="maxStops">
			<br>

			<br>
			<label> Type of Trip: </label>
			<input type = "radio" id = "round" name = "typeOfTrip" value="round">
			<label for="round">Round Trip</label>
			<input type = "radio" id = "oneway" name = "typeOfTrip" value="oneway">
			<label for="oneway">One Way</label>
			<br>

			<br>
			 <label> Minimum Price: </label>
			 <input type="number" step="0.01" id="minPrice" name="minPrice">

			 <label> Maximum Price: </label>
			 <input type="number" step="0.01" id="maxPrice" name="maxPrice">
			<br>
			
			<br>
			 <label> Take Off Time: </label>
			 <input type="time" id="takeOff" name="takeOff">
			 <label> - </label>
			 <input type="time" id="takeOffEnd" name="takeOffEnd">

			 <label> Landing Time: </label>
			 <input type="time" id="landing" name="landing">
			 <label> - </label>
			 <input type="time" id="landingEnd" name="landingEnd">
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

				<%
				//<br>
				//<label> Filter: </label>
				//<input type = "radio" id = "yes" name = "filter" value="Yes">
				//<label for="yes">Yes</label>
				//<input type = "radio" id = "no" name = "filter" value="No">
				//<label for="no">No</label>
				//<br>
				%>

				<br>
				<label> Sort: </label>
				<select name = "sortList">
				<option disabled selected value> -- select an option -- </option>
				<option value = "totalCost">price</option> 
				<option value = "firstDep">take-off time</option> 
				<option value = "lastArrival">landing time</option> 
				<option value = "flightDurationInHours">duration of flight</option> 
				</select>
				<br>

				<br>
				<input type="submit" value="Search!" />
				<br>
		</form>  
		
		<hr>
		<form method="get" action="loggedIn.jsp">
			<input type="submit" value="Purchase">
		</form>

		<hr>

		<% 
			//ResultSet result2 = stmt.executeQuery(str2);
			result = stmt.executeQuery(multiStopQuery);
			metaData = result.getMetaData();
			columnCount = metaData.getColumnCount();
		%>
			<%
			boolean showHeaders = true;
			while (result.next()) {
				//out.print("<table border='1' style='border-collapse: collapse'>");
				out.print("<table border='1'>");
				out.print("<tr>");
				if (showHeaders) {
					out.print("<tr>");
					showHeaders = false;
				} else {
					out.print("<tr style='visibility:collapse'>");
				}
				out.print("<th></th>");
				out.print("<th>Total Cost</th>");
				for (int i = 0; i < columns.length; i++) {
					out.println("<th>" + columns[i] + "</th>");	
				}
				out.print("</tr>");

				// find amount of flights by going until null
				int numFlights = 1;
				while ((numFlights+1) * columns.length < columnCount && result.getString((numFlights+1) * columns.length) != null) {
					numFlights++;
				}
				String formString = "<td rowspan = '"+numFlights+"'>";
				formString += "<form type='post' action='flightPurchaseTemp.jsp'>";
				formString += "<input type='hidden' name='flightNumbers' value='";
				for (int i = 0; i < numFlights; i++) {
					formString += result.getString(columns.length*i+1) + ",";
				}
				formString += "'/>";
				formString += "<input type='submit' value='Purchase Flight"+((numFlights==1)?"":"s")+" ["+numFlights+"]'></input>";
				formString += "</form>";
				formString += "</td>";
				out.println(formString);
				out.println("<td rowspan = '"+numFlights+"'>"+result.getString(numOfStops * columns.length + 1)+"</td>");
				for (int i = 0; i < numFlights; i++) {
					for (int j = 0; j < columns.length; j++) {
						out.println("<td>"+result.getString(i * columns.length + j + 1)+"</td>");
					}
					out.println("</tr>");
					out.println("<tr>");
				}
				out.print("</table>");
				out.print("<div style='height: 10px'></div>");
			}
			%>
		<hr>
		<%
			db.closeConnection(con);	
			}
			 catch (Exception e) {
			// Log the exception instead of printing it to the page
				e.printStackTrace();
				out.print(e.getMessage());
			}
	%>
		

	</body>
</html>