<%@ page import="com.cs336.pkg.ApplicationDB" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>View Tickets</title>
</head>
<body>
    <h1>Flight Reservation</h1>
    <form method="post" action="processReservation.jsp">
        <label for="flight">Select a Flight:</label>
        <select name="flight" id="flight">
            <!-- Populate this dropdown with flight options from your database -->
            <option value="flight1">Flight 1</option>
            <option value="flight2">Flight 2</option>
            <!-- Add more flight options here -->
        </select>

        <label for="tickets">Number of Tickets:</label>
        <input type="number" name="tickets" id="tickets" min="1" required>

        <!-- Add additional input fields for passenger information and payment details here -->

        <input type="submit" value="Reserve Tickets">
    </form>
    
    <hr>
    <h3>View Tickets</h3> 

    <% 
    // Your existing code for viewing tickets goes here
    try {
        ApplicationDB db = new ApplicationDB();
        Connection con = db.getConnection();
        Statement stmt = con.createStatement();
    %>
        <form method="post" action="loggedIn.jsp">
            <input type="submit" value="Back to loggedIn page"/>
        </form>
    <%
        db.closeConnection(con);
    } catch (Exception e) {
        e.printStackTrace();
    }
    %>
</body>
</html>
