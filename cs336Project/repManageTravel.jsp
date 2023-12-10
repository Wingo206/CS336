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

            String[] tables = {"airport", "aircraft", "flight"};
            %>
            <form method="post" action="rep.jsp">
                <input type="submit" value="Back to representative page"/>
            </form>
            <hr>
            <h3>Manage Travel Data</h3>
            <%
            for (String table : tables) {
                out.print("<fieldSet>");
                out.print("<legend>"+table+"</legend>");
                String query = "SELECT * FROM " + table;
                ResultSet result = stmt.executeQuery(query);
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
							out.println("<td>" + 
                                    "<form method=\"post\" action=\"repManageTravelLogic.jsp?column="+metaData.getColumnName(i)+"\">" + 
                                        "<input type=\"text\" name=\"value\" placeholder="+result.getString(i)+"></input>" +
                                        "<input type=\"submit\" value=\"Update\"></input>" +
                                    "</form>" + 
                                "</td>");
						}
                        out.print("</tr>");
                    }%>
                </table>
                <%
                out.print("</fieldSet>");
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