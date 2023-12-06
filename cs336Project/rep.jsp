<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>


<!-- redirect client to access denied page -->
<%
	if (!"representative".equals((String) session.getAttribute("accountType"))) {
		response.sendRedirect("repDeny.jsp");
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Travel Reservation</title>

    <body>
        <h3>Customer Representative</h3>
        <%
            String username = (String) session.getAttribute("username");
            String accountType = (String) session.getAttribute("accountType");
            out.print("<p>Logged in as: " + username + " (" + accountType + ")</p>");
        %>

        <hr>
        <form method="post" action="repManageFlights.jsp">
            <p>todo</p>
            <input type="submit" value="Manage Customer Flights">
        </form>

        <hr>
        <form method="post" action="repManageTravel.jsp">
            <p>todo</p>
            <input type="submit" value="Manage Travel Data">
        </form>

        <hr>
        <form method="post" action="repViewWaitList.jsp">
            <p>todo</p>
            <input type="submit" value="View Waiting list of a flight">
        </form>

        <hr>
        <form method="post" action="repViewFlights.jsp">
            <p>todo</p>
            <input type="submit" value="View flights for a given airport">
        </form>

        <hr>
        <form method="post" action="repAnswerQuestions.jsp">
            <input type="submit" value="Answer customer questions">
        </form>
        
        <hr>
		<form method="get" action="logout.jsp">
			<input type="submit" value="Logout">
		</form>
    </body>

</head>
</html>
