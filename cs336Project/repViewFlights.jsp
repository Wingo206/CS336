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
            String airport = (String) request.getParameter("airport");

            ApplicationDB db = new ApplicationDB();
            Connection con = db.getConnection();
            Statement stmt = con.createStatement();
            String airportQuery = "SELECT * FROM airport";
            ResultSet result = stmt.executeQuery(airportQuery);
            %>
            <form method="post" action="rep.jsp">
                <input type="submit" value="Back to representative page"/>
            </form>
            <hr>
            <h3>View Flights For Airport</h3> 
            <form method="post" action="repViewFlights.jsp">
                <select name="airport">
                    <%
                    out.print("<option "+((airport == null)?"selected":"")+" disabled hidden>Select an Airport</option>");
                    while (result.next()) {
                        String val = result.getString(1);
                        out.print("<option "+((val.equals(airport))?"selected":"")+" value=\""+val+"\">"+val+"</option>");
                    }
                    %>
                </select>
                <input type="submit" value="Search for flights"></input>
            </form>
            <%
            if (airport != null) {
                out.print("<hr>");
                out.print("<h3>Flights from "+airport+"</h3>");
                String fromQuery = "SELECT * FROM flight WHERE departureAirport = \""+airport+"\"";
                result = stmt.executeQuery(fromQuery);
                ResultSetMetaData metaData = result.getMetaData();
                int columnCount = metaData.getColumnCount();
                %>
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
                <%
                out.print("<hr>");
                out.print("<h3>Flights to "+airport+"</h3>");
                String toQuery = "SELECT * FROM flight WHERE arrivalAirport = \""+airport+"\"";
                result = stmt.executeQuery(toQuery);
                metaData = result.getMetaData();
                columnCount = metaData.getColumnCount();
                %>
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
                <%
            }
            %>
            <%
            db.closeConnection(con);
        } catch (Exception e) {
            e.printStackTrace();
        }
        %>
    </body>
</head>
</html>