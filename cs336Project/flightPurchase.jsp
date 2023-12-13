<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Purchase Confirmation</title>
</head>
<body>
    <%
        try {
            ApplicationDB db = new ApplicationDB();
            Connection con = db.getConnection();

            // Extracting parameters
            String flightNumStrings = request.getParameter("flightNumbers");
            ArrayList<Integer> flightNums = new ArrayList<Integer>();
            while (flightNumStrings.indexOf(',') != -1) {
                int i = flightNumStrings.indexOf(',');
                flightNums.add(Integer.parseInt(flightNumStrings.substring(0, i)));
                flightNumStrings = flightNumStrings.substring(i+1);
            }

            String username = (String) session.getAttribute("username");
            // Add other details as needed

            // Insert into flightTicket table
            String ticketQuery = "INSERT INTO flightTicket (totalFare, class, changeFee, bookingFee, passenger, purchaseDateTime) VALUES (?, ?, ?, ?, ?, NOW())";

            PreparedStatement psTicket = con.prepareStatement(ticketQuery, Statement.RETURN_GENERATED_KEYS);

            psTicket.setFloat(1, totalFare);
            psTicket.setString(2, classType);
            psTicket.setFloat(3, changeFee);
            psTicket.setFloat(4, bookingFee);
            psTicket.setString(5, username);

            psTicket.executeUpdate();
            ResultSet rsTicket = psTicket.getGeneratedKeys();
            ResultSet rs = psTicket.executeQuery();


            int ticketId = 0;
            if (rsTicket.next()) {
                ticketId = rsTicket.getInt(1);
            }

            // Insert into uses table
            for (Integer flightNumber : flightNums) {
                String seatNumber = "A" + (new Random().nextInt(30) + 1); 
                String usesQuery = "INSERT INTO uses (flightNumber, ticketId, seatNumber) VALUES ("+ flightNumber + ", "+ ticketId + ", "+ seatNumber + ")";
                Statement stmt = con.createStatement();

                out.print(usesQuery);


                stmt.executeUpdate(usesQuery);


            }

            // Display confirmation
            out.println("<h2>Flight Purchase Confirmation</h2>");
            out.println("<p>Your ticket has been successfully purchased!</p>");
            out.println("<p>Ticket ID: " + ticketId + "</p>");
            out.println("<p>Airline: " + rs.getString("airline") + "</p>");
            out.println("<p>Departure Airport: " + rs.getString("departureAirport") + "</p>");
            out.println("<p>Arrival Airport: " + rs.getString("arrivalAirport") + "</p>");
            out.println("<p>Departure Time: " + rs.getTimestamp("departureTime") + "</p>");
            out.println("<p>Arrival Time: " + rs.getTimestamp("arrivalTime") + "</p>");            

            rsTicket.close();
            rs.close();
            db.closeConnection(con);
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<p>Error processing your purchase.</p>");

            out.print("<p>" + e.getMessage() + "</p>");

        }



    %>
    <form action="loggedIn.jsp" method="post">
        <input type="submit" value="Return to Home Page">
    </form>
</body>
</html>
