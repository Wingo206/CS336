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
    <body>
        <form type="post" action="loggedIn.jsp">
            <input type="submit" value="Back to logged in"/>
        </form>
        <hr>
       <%
        try {
            String username = (String)session.getAttribute("username");

            ApplicationDB db = new ApplicationDB();
            Connection con = db.getConnection();
            Statement stmt = con.createStatement();

            String query = "SELECT flightNumber, airlineId FROM inWaitingList WHERE customer='"+username+"'";
            ResultSet result = stmt.executeQuery(query);
            ResultSetMetaData metaData = result.getMetaData();
            int columnCount = metaData.getColumnCount();

            %>
            <hr>
            <h3>View your waitlist</h3> 
            <%

            %>
            <fieldSet>
                <%out.println("<legend>Waiting List for "+username+"</legend>");%>
                <table border="1">
                    <tr>
                        <% for (int i = 1; i <= columnCount; i++) {
                            out.println("<th>" + metaData.getColumnName(i) + "</th>");
                        }%>
                        <th></th>
                    </tr>
                    <% while (result.next()) {
                        out.print("<tr>");
                        for (int i = 1; i <= columnCount; i++) {
                            out.println("<td>" + result.getString(i) + "</td>");
                        }
                        out.print("<td>" +
                            "<form method='post' action=waitlistRemove.jsp>" + 
                                "<input type='hidden' name='flightNumber' value='"+result.getString(1)+"'>" +
                                "<input type='hidden' name='airlineId' value='"+result.getString(2)+"'>" +
                                "<input type='submit' value='Remove'></input>" +
                            "</form>" + 
                        "</td>");
                        out.print("</tr>");
                    }%>
                </table>
            </fieldSet>  
            <%

            db.closeConnection(con);
        } catch (Exception e) {
            e.printStackTrace();
        }
        %>
    </body>
</head>
</html>


