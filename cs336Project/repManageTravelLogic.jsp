<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Manage Travel Logic</title>
    <body>
        <%
        try {
            ApplicationDB db = new ApplicationDB();
            Connection con = db.getConnection();
            Statement stmt = con.createStatement();

            String action = request.getParameter("action");
            String table = request.getParameter("table");
            if (action.equals("newEntry")) {
                String[] values = request.getParameterValues("value");
                out.println(values.length);
                String valuesTuple = "(";
                for (int i = 0; i < values.length; i++) {
                    valuesTuple += "'" + values[i] + "'";
                    if (i < values.length-1) {
                        valuesTuple += ", ";
                    }
                }
                valuesTuple += ")";
                String insert = "INSERT INTO "+table+" VALUES " + valuesTuple;
                out.print(insert);
                stmt.executeUpdate(insert);
            } else {
                String column = request.getParameter("column");
                String[] entryColumns = request.getParameterValues("entryColumns");
                String[] entryValues = request.getParameterValues("entryValues");

                String entryConditions = "";
                for (int i = 0; i < entryColumns.length; i++) {
                    entryConditions += entryColumns[i] + " = '"+entryValues[i]+"'";
                    if (i < entryColumns.length - 1) {
                        entryConditions += " AND ";
                    }
                }
                if (action.equals("update")) {
                    String value = request.getParameter("value");
                    
                    String update = "UPDATE "+table+" SET "+column+" = '"+value+"' WHERE " + entryConditions;
                    stmt.executeUpdate(update);

                } else if (action.equals("delete")) {
                    String delete = "DELETE FROM "+table+" WHERE "+entryConditions;
                    stmt.executeUpdate(delete);
                }
            }
            

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
