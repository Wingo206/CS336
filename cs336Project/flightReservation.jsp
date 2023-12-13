<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Flight Reservation</title>
</head>
<body>
    <form type="post" action="flightSearch.jsp">
        <input type="submit" value="Back to flight search"/>
    </form>
    <hr>
    <%
        try {
            ApplicationDB db = new ApplicationDB();
            Connection con = db.getConnection();
            Statement stmt = con.createStatement();

            String flightNumStrings = request.getParameter("flightNumbers");
            ArrayList<Integer> flightNums = new ArrayList<Integer>();
            while (flightNumStrings.indexOf(',') != -1) {
                int i = flightNumStrings.indexOf(',');
                flightNums.add(Integer.parseInt(flightNumStrings.substring(0, i)));
                flightNumStrings = flightNumStrings.substring(i+1);
            }
            boolean canReserve = true;
            for (Integer flightNumber : flightNums) {
                String query = "SELECT * FROM flight WHERE flightNumber = ?";
                PreparedStatement ps = con.prepareStatement(query);
                ps.setInt(1, flightNumber);
                ResultSet rs = ps.executeQuery();

                // Check if the flight is full
                String fullCheck = "SELECT * FROM ( SELECT f.flightNumber, f.airline FROM flight f JOIN ( SELECT flightNumber, airline, COUNT(*) numPassengers FROM uses GROUP BY flightNumber, airline) t ON f.flightNumber = t.flightNumber AND f.airline = t.airline JOIN aircraft a ON f.flownBy = a.aircraftId WHERE a.numSeats < numPassengers) flightFull WHERE flightFull.flightNumber = " + flightNumber;
                Statement fullCheckStmt = con.createStatement();
                ResultSet fullCheckResult = fullCheckStmt.executeQuery(fullCheck);
                if (fullCheckResult.next()) {
                    canReserve = false;
                    rs.next();
                    out.println("<h3>Flight "+flightNumber+" "+rs.getString("airline")+" is full.</h3>");
                    out.println("<p>Would you like to join the waitlist?</p>");
                    out.println("<form method='post' action='waitlistJoin.jsp'>" + 
                        "<input type='hidden' name='flightNumber' value='"+flightNumber+"'>" + 
                        "<input type='hidden' name='airlineId' value='"+rs.getString("airline")+"'>" + 
                        "<input type='submit' value='Join waitlist for "+flightNumber +" " + rs.getString("airline")+"'>" + 
                    "</form>");
                } else {
                    // Displaying flight details
                    if (rs.next()) {
                        out.println("<h3>Details for flight " + rs.getString("flightNumber") + ". Here are your flight details: </h3>");
                        out.println("<p>Flight Number: " + rs.getString("flightNumber") + "</p>");
                        out.println("<p>Airline: " + rs.getString("airline") + "</p>");
                        out.println("<p>Departure Airport: " + rs.getString("departureAirport") + "</p>");
                        out.println("<p>Arrival Airport: " + rs.getString("arrivalAirport") + "</p>");
                        out.println("<p>Departure Time: " + rs.getTimestamp("departureTime") + "</p>");
                        out.println("<p>Arrival Time: " + rs.getTimestamp("arrivalTime") + "</p>");
                        out.println("<p>Price: $" + rs.getFloat("price") + "</p>");
                    }
                }
                rs.close();
                ps.close();
                }
            %>
            <hr>
            <%if (canReserve) {%>
                <form action="flightPurchase.jsp" method="post">
                    <input type='hidden' name='flightNumbers' value='<%out.print(flightNumStrings);%>'>
                    <input type="submit" value="Purchase Flight">
                </form>

            <%
            }


            db.closeConnection(con);
        } catch (Exception e) {
            e.printStackTrace();

            out.print("<p>" + e.getMessage() + "</p>");
            

        }
    %>
    

</body>
</html>
