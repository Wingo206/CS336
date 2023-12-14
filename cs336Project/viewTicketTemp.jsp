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
        <input type="submit" value="Back to logged-in page"/>
    </form>
    <hr>
    <h3>View Tickets</h3>
    <%
        String username = (String) session.getAttribute("username");
        if(username == null) {
            //redirect
        } else {
            Connection con = null;
        }
        try {
            ApplicationDB db = new ApplicationDB();
            con = db.getConnection();

            String pastFlightsQuery = "SELECT ft.ticketID, f.departureTime, f.arrivalTime FROM flightTicket ft JOIN uses u ON ft.ticketID = u.ticketID JOIN flight f ON u.flightNumber = f.flightNumber WHERE ft.passenger = ? AND f.departureTime < NOW() ORDER BY f.departureTime;";
            PreparedStatement pstPast = con.prepareStatement(pastFlightsQuery);
            pstPast.setString(1, username);
            ResultSet pastFlights = pstPast.executeQuery();
            printFlightTable(pastFlights, true);
            pastFlights.close();
            pstPast.close();

            String futureFlightsQuery = "SELECT ft.ticketID, f.departureTime, f.arrivalTime FROM flightTicket ft JOIN uses u ON ft.ticketID = u.ticketID JOIN flight f ON u.flightNumber = f.flightNumber WHERE ft.passenger = ? AND f.departureTime >= NOW() ORDER BY f.departureTime;";
            PreparedStatement pstFuture = con.prepareStatement(futureFlightsQuery);
            pstFuture.setString(1, username);
            ResultSet futureFlights = pstFuture.executeQuery();
            printFlightTable(futureFlights, false);
            futureFlights.close();
            pstFuture.close();


        } catch (SQLException e) {
                    e.printStackTrace();
                    // Handle exceptions
                } finally {
                    if (con != null) {
                        try {
                            con.close();
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                    }
                }
            %>
            <!-- Your HTML and JSP continue -->
        </body>
        </html>

    <%!
// Fetch username from session or redirect if not logged in

// Define a method to print flight table
void printFlightTable(ResultSet flights) throws SQLException {
    ResultSetMetaData metaData = flights.getMetaData();
    int columnCount = metaData.getColumnCount();
    out.println("<table border='1'>");
    out.println("<tr>");
    for (int i = 1; i <= columnCount; i++) {
        out.println("<th>" + metaData.getColumnName(i) + "</th>");
    }
    // Include action column header
    out.println("<th>Actions</th>");
    out.println("</tr>");
    
    while (flights.next()) {
        out.println("<tr>");
        for (int i = 1; i <= columnCount; i++) {
            out.println("<td>" + flights.getString(i) + "</td>");
        }
        // Check if it's a past or future flight and display actions accordingly
        Timestamp flightTime = flights.getTimestamp("departureTime"); // assuming you have a departureTime column
        if(flightTime.before(new java.util.Date())) {
            // Past flight: No actions
            out.println("<td>N/A</td>");
        } else {
            // Future flight: Allow cancel/change
            out.println("<td><a href='cancelFlight?id=" + flights.getString("ticketID") + "'>Cancel</a> | <a href='changeClass?id=" + flights.getString("ticketID") + "'>Change Class</a></td>");
        }
        out.println("</tr>");
    }
    out.println("</table>");
}

// Fetch past flights
ResultSet pastFlights = // SQL query to fetch past flights based on current date and user
printFlightTable(pastFlights);

// Fetch future flights
ResultSet futureFlights = // SQL query to fetch future flights based on current date and user
printFlightTable(futureFlights);

// Ensure you close your ResultSets and Statements to avoid resource leaks
%>
