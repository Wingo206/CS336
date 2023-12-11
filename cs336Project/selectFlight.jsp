<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Select a Flight</title>
</head>
<body>
    <h1>Select a Flight</h1>

    <form method="post" action="processReservation.jsp">
        <label for="flight">Select a Flight:</label>
        <select name="flight" id="flight">
            <%
            try {
                // Import necessary classes and establish a database connection
                Class.forName("com.mysql.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/cs336db", "your_username", "your_password");

                // Create a statement to fetch flight data from the database
                Statement stmt = con.createStatement();
                ResultSet rs = stmt.executeQuery("SELECT flightNumber, airline, flownBy, departureAirport, arrivalAirport, departureTime, arrivalTime, price FROM flight");

                while (rs.next()) {
                    int flightNumber = rs.getInt("flightNumber");
                    String airline = rs.getString("airline");
                    String flownBy = rs.getString("flownBy");
                    String departureAirport = rs.getString("departureAirport");
                    String arrivalAirport = rs.getString("arrivalAirport");
                    Timestamp departureTime = rs.getTimestamp("departureTime");
                    Timestamp arrivalTime = rs.getTimestamp("arrivalTime");
                    float price = rs.getFloat("price");

                    // Populate the dropdown list with flight options
                    out.println("<option value='" + flightNumber + "'>" + airline + " Flight " + flightNumber + ": " + departureAirport + " to " + arrivalAirport + " - Price: $" + price + "</option>");
                }

                // Close the database connection
                rs.close();
                stmt.close();
                con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
            %>
        </select>

        <input type="submit" value="Reserve Tickets">
    </form>
</body>
</html>
