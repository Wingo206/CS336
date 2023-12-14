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
		<%
		try {
			// Get the database connection
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();

			// Create a SQL statement
			Statement stmt = con.createStatement();

            String username = (String) session.getAttribute("username");
			String ticketId = request.getParameter("ticketId");
            String choiceSelected = request.getParameter("classChoice");
            String isFine = request.getParameter("fine");
			String str;

            if(choiceSelected != null && choiceSelected != "null") {
               str = "UPDATE flightTicket SET class = '" + choiceSelected + "' WHERE ticketId = '"+ticketId+"'";
               if(isFine.equals("true")) {
					out.println("You have been fined $50.");
               }
            }
            else {
			    str = "DELETE FROM flightTicket WHERE ticketID = '" + ticketId + "'";
				out.print("Successfully deleted ticket");
				if(isFine.equals("true")) {
					out.println("You have been fined $50.");
                }
            }

			// Run the query against the database
			stmt.executeUpdate(str);
		%>

        <%
			// Close the connection and resources
			db.closeConnection(con);
			response.setHeader("Refresh", "1; URL=viewTickets.jsp"); // like a redirect, but with a delay

		} catch (Exception e) {
			// Log the exception instead of printing it to the page
			e.printStackTrace();
			out.print(e.getMessage());
		}
		%>
	</body>
</html>