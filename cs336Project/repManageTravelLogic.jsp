<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Question Reply</title>
    <body>
        <%
        try {
            ApplicationDB db = new ApplicationDB();
            Connection con = db.getConnection();
            Statement stmt = con.createStatement();

            String table = request.getParameter("table");
            String column = request.getParameter("column");
            String value = request.getParameter("value");
            String[] entryColumns = request.getParameterValues("entryColumns");
            String[] entryValues = request.getParameterValues("entryValues");
            String entryConditions = "";
            for (int i = 0; i < entryColumns.length; i++) {
                entryConditions += entryColumns[i] + " = '"+entryValues[i]+"'";
                if (i < entryColumns.length - 1) {
                    entryConditions += " AND ";
                }
            }

            String update = "UPDATE "+table+" SET "+column+" = '"+value+"' WHERE " + entryConditions;
            stmt.executeUpdate(update);

            db.closeConnection(con);
            response.sendRedirect("repManageTravel.jsp");
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
            <form type="post" action="repManageTravel.jsp">
                <input type="submit" value="Return to Travel Management Page">
            </form>
            <%
        }
        %>
    </body>
</head>
</html>
