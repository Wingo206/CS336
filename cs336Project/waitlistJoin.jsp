<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Remove from waitlist</title>
    <body>
    <%
        try {
            ApplicationDB db = new ApplicationDB();
            Connection con = db.getConnection();
            Statement stmt = con.createStatement();

            String username = (String) session.getAttribute("username");
            String flightNumber = request.getParameter("flightNumber");
            String airlineId = request.getParameter("airlineId");

            String delete = "INSERT INTO inWaitingList VALUES  ('"+flightNumber+"', '"+airlineId+"', '"+username+"')";
            stmt.executeUpdate(delete);

            db.closeConnection(con);
            response.sendRedirect("waitlist.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            %>
            <h3>An Error Occurred.</h3>
            <fieldset>
                <legend>Error Text</legend>
                <%
                out.print(e.getMessage());
                %>
            </fieldset>
            <form type="post" action="waitlist.jsp">
                <input type="submit" value="Return to waitlist">
            </form>
            <%
        }
        %>
    </body>
</head>
</html> 
