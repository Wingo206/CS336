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
       <%
        try {
            ApplicationDB db = new ApplicationDB();
            Connection con = db.getConnection();
            Statement stmt = con.createStatement();

            String flightsQuery = "SELECT flightNumber, airline FROM flight";
            ResultSet result = stmt.executeQuery(flightsQuery);

            String options = "";
            while (result.next()) {
                String curFlight = result.getString(2) + " " + result.getString(1);
                String flightValue = result.getString(1)+","+result.getString(2);
                options += "<option value='"+flightValue+"'>"+curFlight+"</option>";
            }

            %>
            <form method="post" action="rep.jsp">
                <input type="submit" value="Back to representative page"/>
            </form>
            <hr>
            <h3>View Wait List For Flight</h3> 
            <form method="post" action="repViewWaitList.jsp">
                <select name="chosenFlight">
                    <%out.println(options);%>
                </select>
                <input type="submit" value="View Wait List">
            </form>
            <hr>
            <%

            String chosenFlight = request.getParameter("chosenFlight");
            if (chosenFlight != null && !chosenFlight.equals("null")) {
                int index = chosenFlight.indexOf(',');
                String flightNumber = chosenFlight.substring(0, index);
                String airline = chosenFlight.substring(index+1);

                String waitlistQuery = "SELECT customer FROM inWaitingList WHERE flightNumber = '"+flightNumber+"' AND airlineId = '"+airline+"'";
                Statement stmt2 = con.createStatement();
                result = stmt2.executeQuery(waitlistQuery);
                ResultSetMetaData metaData = result.getMetaData();
                int columnCount = metaData.getColumnCount();
                %>
                <fieldSet>
                    <%out.println("<legend>Waiting List for "+airline+" Flight "+flightNumber+"</legend>");%>
                    <table border="1">
                        <tr>
                            <% for (int i = 1; i <= columnCount; i++) {
                                out.println("<th>" + metaData.getColumnName(i) + "</th>");
                            }%>
                        </tr>
                        <% while (result.next()) {
                            out.print("<tr>");
                            for (int i = 1; i <= columnCount; i++) {
                                out.println("<td>" + result.getString(i) + "</td>");
                            }
                            out.print("</tr>");
                        }%>
                    </table>
                </fieldSet>
                <%
            }

            db.closeConnection(con);
        } catch (Exception e) {
            e.printStackTrace();
        }
        %>
    </body>
</head>
</html>
