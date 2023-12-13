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
	</head>
	
	<body>

		You are logged in! 
		
		<%
		try {
			String username = (String) session.getAttribute("username");
			out.print("Hello "+ username);
			
			String accountType =(String) session.getAttribute("accountType");
			out.print(" Hello "+ accountType);

			ApplicationDB db = new ApplicationDB();
            Connection con = db.getConnection();
            Statement stmt = con.createStatement();


		%>

		<hr>
		<form method="post" action="flightSearch.jsp">
			<input type="submit" value="flightSearch" />
		</form>
			
		<hr>
		<form method="get" action="questions.jsp">
			<input type="submit" value="View questions page">
		</form>

		<hr>
		<form method="get" action="waitlist.jsp">
			<input type="submit" value="View your waitlist">
		</form>

		<%
		// Check if anything I'm on the waitlist for has a seat
		String query = 
			"SELECT w.flightNumber, w.airlineId, hasSpace.numEmptySeats numEmptySeats " + 
			"FROM inWaitingList w " + 
			"JOIN (" +
				"SELECT f.flightNumber, f.airline, numSeats - numPassengers numEmptySeats " + 
				"FROM flight f " + 
				"JOIN (" + 
					"SELECT flightNumber, airline, COUNT(*) numPassengers " + 
					"FROM uses " + 
					"GROUP BY flightNumber, airline " +
				") t ON f.flightNumber = t.flightNumber AND f.airline = t.airline " +
				"JOIN aircraft a ON f.flownBy = a.aircraftId " +
				"WHERE a.numSeats > numPassengers " +
			") hasSpace " +
			"ON hasSpace.flightNumber = w.flightNumber AND hasSpace.airline = w.airlineId " +
			"WHERE w.customer = 'cust'";
		ResultSet result = stmt.executeQuery(query);
		ResultSetMetaData metaData = result.getMetaData();
		int columnCount = metaData.getColumnCount();
		
		if (result.next()) {
			result.beforeFirst();
			/*out.println("<script>Window.onload = () => {"+
					"alert(\"Your waitlisted flights have available seats!\");"+
				"}</script>");*/
			out.println("<script>"+
					"setTimeout(() => {" + 
						"alert(\"Your waitlisted flights have available seats!\");" +
					"}, 100);" + 
				"</script>");
			%>
			
			<%out.println("<legend>Your waitlisted flights have available seats!</legend>");%>
			<table border="1">
				<tr>
					<% for (int i = 1; i <= columnCount; i++) {
						out.println("<th>" + metaData.getColumnName(i) + "</th>");
					}%>
				</tr>
				<% while (result.next()) {
					out.print("<tr>");
					for (int i = 1; i <= columnCount; i++) {
						out.println("<td>" + result.getString(i) + "</td>");
					}
					out.print("</tr>");
				}%>
			</table>
			<%
		}
		%>
		<hr>
		<form method="get" action="logout.jsp">
			<input type="submit" value="Logout">
		</form>

		<hr>
		<form method = "get" action ="viewTickets.jsp">
			<input type ="submit" value="View Tickets">
		</form>
		
		<%
            db.closeConnection(con);
		} catch (Exception e) {
            e.printStackTrace();
            %>
            <h3>An Error Occurred.</h3>
            <fieldset>
                <legend>Error Text</legend>
                <%
                out.print(e.getMessage());
                %>
            </fieldset>
            <form type="post" action="login.jsp">
                <input type="submit" value="Return to login">
            </form>
            <%
        }
		%>
	</body>
</html>
