<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Travel Reservation</title>
    <body>
       <%
        try {
            // Use this to get the flight numbers from the form on flightSearch.jsp
            String flightNumStrings = request.getParameter("flightNumbers");
            ArrayList<Integer> flightNums = new ArrayList<Integer>();
            while (flightNumStrings.indexOf(',') != -1) {
                int i = flightNumStrings.indexOf(',');
                flightNums.add(Integer.parseInt(flightNumStrings.substring(0, i)));
                flightNumStrings = flightNumStrings.substring(i+1);
            }

            ApplicationDB db = new ApplicationDB();
            Connection con = db.getConnection();
            Statement stmt = con.createStatement();
            %>
            <hr>
            <h3>Temp page for flight purchase</h3> 
            <%
            for (int i = 0; i < flightNums.size(); i++) {
                out.println("<p>"+flightNums.get(i)+"</p>");
            }
            db.closeConnection(con);
        } catch (Exception e) {
            e.printStackTrace();
        }
        %>
    </body>
</head>
</html>

