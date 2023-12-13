<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>View Tickets</title>
    <body>
        <%
        try {
            ApplicationDB db = new ApplicationDB();
            Connection con = db.getConnection();
            String username = (String) session.getAttribute("username");

            // Fetch Past Flights
            String queryPastFlights = "SELECT f.* FROM flight f JOIN ..."; // Complete your SQL query for past flights
            PreparedStatement psPastFlights = con.prepareStatement(queryPastFlights);
            psPastFlights.setString(1, username);
            ResultSet rsPastFlights = psPastFlights.executeQuery();
            while (rsPastFlights.next()) {
                <div>
                    <h4>Flight Number: <%= rsPastFlights.getInt("flightNumber") %></h4>
                    <p>Departure Airport: <%= rsPastFlights.getString("departureAirport") %></p>
                    <p>Arrival Airport: <%= rsPastFlights.getString("arrivalAirport") %></p>
                    <p>Departure Time: <%= rsPastFlights.getTimestamp("departureTime") %></p>
                    <p>Arrival Time: <%= rsPastFlights.getTimestamp("arrivalTime") %></p>
                    <p>Price: <%= rsPastFlights.getFloat("price") %></p>
                    <!-- Add more details as needed -->
                </div>
            }
            rsPastFlights.close();
            psPastFlights.close();

            // Fetch Future Flights
            String queryFutureFlights = "SELECT f.* FROM flight f JOIN ..."; // Complete your SQL query for future flights
            PreparedStatement psFutureFlights = con.prepareStatement(queryFutureFlights);
            psFutureFlights.setString(1, username);
            ResultSet rsFutureFlights = psFutureFlights.executeQuery();
            while (rsFutureFlights.next()) {
                // Process and display each future flight
            }
            rsFutureFlights.close();
            psFutureFlights.close();

            db.closeConnection(con);
        } catch (Exception e) {
            e.printStackTrace();
        }
        %>
    </body>
</head>
</html>
