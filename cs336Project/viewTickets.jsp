<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>View Tickets</title>
</head>
<body>
    <form method="post" action="loggedIn.jsp">
        <input type="submit" value="Back to loggedIn page"/>
    </form>
    <hr>
    <h3>View Tickets</h3>
    <%
        try {
            ApplicationDB db = new ApplicationDB();
            Connection con = db.getConnection();

            String username = (String) session.getAttribute("username");

            // Fetching past flights
            PreparedStatement psPast = con.prepareStatement(
                "SELECT * FROM flight JOIN uses ON flight.flightNumber = uses.flightNumber " +
                "JOIN flightTicket ON uses.ticketId = flightTicket.ticketID " +
                "WHERE passenger = ? AND departureTime < NOW()");
            psPast.setString(1, username);
            ResultSet rsPast = psPast.executeQuery();

            // Process and display each past flight
            while (rsPast.next()) {
                // Display details of each past flight
            }

            // Fetching future flights
            PreparedStatement psFuture = con.prepareStatement(
                "SELECT * FROM flight JOIN uses ON flight.flightNumber = uses.flightNumber " +
                "JOIN flightTicket ON uses.ticketId = flightTicket.ticketID " +
                "WHERE passenger = ? AND departureTime > NOW()");
            psFuture.setString(1, username);
            ResultSet rsFuture = psFuture.executeQuery();

            // Process and display each future flight
            while (rsFuture.next()) {
                // Display details of each future flight
            }

            rsPast.close();
            psPast.close();
            rsFuture.close();
            psFuture.close();
            db.closeConnection(con);
        } catch (Exception e) {
            e.printStackTrace();
        }
    %>
</body>
</html>
