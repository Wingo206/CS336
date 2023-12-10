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
        <form method="post", action="loggedIn.jsp">
            <input type="submit" value="Back to logged in"/>
        </form>
        <%
        try {
            ApplicationDB db = new ApplicationDB();
            Connection con = db.getConnection();

            String username = (String) session.getAttribute("username");
            String accountType = (String) session.getAttribute("accountType");
            out.print("<p>Logged in as: " + username + " (" + accountType + ")</p>");
            %>

            <hr>
            <form method="post" action="newQuestionLogic.jsp">
                    <h3>Enter your question:</h3>
                    <textarea name="questionText" rows="4" cols="50"></textarea>
                    <br>
                <input type="submit" value="Post question"/>
            </form>

            <hr>

            <%
            String qKeyword = request.getParameter("qKeyword");
            String aKeyword = request.getParameter("aKeyword");
            %>

            <h3>Search</h3>
            <form method="post" action="questions.jsp">
                <label>Question keyword:</label>
                <input type="text" name="qKeyword" value="<%= (qKeyword == null)?"":qKeyword%>"/>
                <label>Answer keyword:</label>
                <input type="text" name="aKeyword" value="<%= (aKeyword == null)?"":aKeyword%>"/>
                <input type="submit" value="Update Search"/>
            </form>

            <hr>

            <h3>My Questions (Customer)</h3>
            <%
            // make query for my questions
            Statement stmt = con.createStatement();
            String query = "SELECT QID, questionText, reply, customerRep FROM question WHERE customer = '" + username + "'";

            // add in keywords
            if (qKeyword != null && qKeyword.length() > 0) {
                query += " AND questionText LIKE '%"+qKeyword+"%'";
            }
            if (aKeyword != null && aKeyword.length() > 0) {
                query += " AND reply LIKE '%"+aKeyword+"%'";
            }

            ResultSet result = stmt.executeQuery(query);
            if (result.next() == false) {
                out.print("No Results");
            } else {
                %>
                <table border="1">
                    <tr>
                        <th>QID</th>
                        <th>Question</th>
                        <th>Reply</th>
                        <th>Answered By</th>
                    </tr>
                    <%
                    result.beforeFirst();
                    while (result.next()) {
                        out.print("<tr>");
                        // QID
                        out.print("<td>" + result.getString(1) + "</td>");

                        // Question text
                        out.print("<td><textarea readonly='true' >" + result.getString(2) + "</textarea></td>");
                        String reply = result.getString(3);
                        out.print("<td>");
                        if (reply == null || reply.length() == 0) {
                            out.print("[No Reply]");
                        } else {
                            out.print("<textarea readonly='true' >" + reply + "</textarea>");
                        }
                        out.print("</td>");

                        String answeredBy = result.getString(4);
                        out.print("<td>");
                        if (answeredBy == null || answeredBy.length() == 0) {
                            out.print("[No Reply]");
                        } else {
                            out.print(answeredBy);
                        }
                        out.print("</td>");
                        out.print("</tr>");
                    }
                    %>
                </table>
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
	