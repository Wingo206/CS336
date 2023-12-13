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
            Statement fkStmt = con.createStatement();
            Statement optionsStmt = con.createStatement();

            String[] tables = {"airport", "airline", "aircraft", "flight"};
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
                ResultSet result = fkStmt.executeQuery(query);
                ResultSetMetaData metaData = result.getMetaData();
                int columnCount = metaData.getColumnCount();

                // Find foreign key constraints to add dropdowns
                String fkQuery = "SELECT TABLE_NAME, COLUMN_NAME, CONSTRAINT_NAME, REFERENCED_TABLE_NAME, REFERENCED_COLUMN_NAME " + 
                    "FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE " + 
                    "WHERE REFERENCED_TABLE_SCHEMA = 'cs336db' " + 
                    "AND TABLE_NAME = '" + table + "'";
                ResultSet fkResult = stmt.executeQuery(fkQuery);
                HashMap<String, String> columnToOptionsMap = new HashMap<String, String>();
                while (fkResult.next()) {
                    // Query the options for each column that has a foreign key constraint
                    String column = fkResult.getString(2);
                    String tableToQuery = fkResult.getString(4);
                    String columnToQuery = fkResult.getString(5);
                    String optionsQuery = "SELECT " + columnToQuery + " FROM " + tableToQuery;
                    ResultSet optionsResult = optionsStmt.executeQuery(optionsQuery);
                    String optionsHTML = "";
                    while(optionsResult.next()) {
                        String val = optionsResult.getString(1);
                        optionsHTML += "<option value = '"+val+"'>"+val+"</option>";
                    }
                    columnToOptionsMap.put(column, optionsHTML);
                }
                %>
                <table border="1">
                    <tr>
                        <% for (int i = 1; i <= columnCount; i++) {
                            out.println("<th>" + metaData.getColumnName(i) + "</th>");
                        }%>
                        <th></th>
                    </tr>
                    <% 
                    // Display table data
                    while (result.next()) {
                        out.print("<tr>");
                        // Store info about the current row, add to each form so the logic knows what entry to update
                        String entryInfo = "";
                        for (int j = 1; j <= columnCount; j++) {
                            entryInfo += "<input type='hidden' name='entryColumns' value='"+metaData.getColumnName(j)+"'>";
                            entryInfo += "<input type='hidden' name='entryValues' value='"+result.getString(j)+"'>";
                        }
                        for (int i = 1; i <= columnCount; i++) {
                            String column = metaData.getColumnName(i);
							out.println("<td>"); 
                            out.println("<form method='post' action='repManageTravelLogic.jsp'>");
                            out.println("<input type='hidden' name='action' value='update'>");
                            out.println("<input type='hidden' name='table' value='"+table+"'>");
                            out.println("<input type='hidden' name='column' value="+column+">");
                            out.println(entryInfo);

                            String curVal = result.getString(i);
                            // Text box if no foreign key constraint, dropdown otherwise
                            if (!columnToOptionsMap.containsKey(column)) {
                                out.println("<input type='text' name='value' placeholder="+curVal+"></input>");
                            } else {
                                String optionsHTML = columnToOptionsMap.get(column);
                                // Autoselect current value
                                int index = optionsHTML.indexOf(curVal) + curVal.length() + 1;
                                optionsHTML = optionsHTML.substring(0, index) + " selected" + optionsHTML.substring(index);
                                out.println("<select name='value'>"+optionsHTML+"</select>");
                            }
                            out.println("<input type='submit' value='Update'></input>");

                            out.println("</form>");
                            out.println("</td>");
						}
                        // Extra box for delete option
                        out.println("<td><form method='post' action='repManageTravelLogic.jsp'>" + 
                            entryInfo + 
                            "<input type='hidden' name='table' value='"+table+"'>" + 
                            "<input type='hidden' name='action' value='delete'>" + 
                            "<input type='submit' value='delete'>" + 
                            "</form></td>");
                        out.println("</tr>");
                    }
                    // Add row for new entry
                    out.println("<tr>");
                    out.println("<form method='post' action='repManageTravelLogic.jsp'>");
                    out.println("<input type='hidden' name='action' value='newEntry'>");
                    out.println("<input type='hidden' name='table' value='"+table+"'>");
                    for (int i = 1; i <= columnCount; i++) {
                        String column = metaData.getColumnName(i);
                        out.println("<td>");
                        if (!columnToOptionsMap.containsKey(column)) {
                            out.println("<input type='text' name='value' placeholder="+column+"></input>");
                        } else {
                            String optionsHTML = columnToOptionsMap.get(column);
                            out.println("<select name='value'>"+optionsHTML+"</select>");
                        }
                        out.println("</td>");
                    }
                    out.println("<td><input type='submit' value='New Entry'></input></td>");
                    out.println("</form>");
                    out.println("</tr>");
                    %>
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