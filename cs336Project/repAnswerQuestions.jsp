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

            String username = (String) session.getAttribute("username");
            %>
            <form method="post" action="rep.jsp">
                <input type="submit" value="Back to representative page"/>
            </form>
            <hr>
            <h3>Answer Questions</h3>
            <form method="post" action="repAnswerQuestions.jsp">
                <input type="submit" value="Refresh"/>
            </form>
            <%
            Statement stmt = con.createStatement();
            String query = "SELECT QID, customer, questionText, reply, customerRep FROM question ORDER BY QID ASC";
            ResultSet result = stmt.executeQuery(query);
            %>
            <table border="1">
                <tr>
                    <th>QID</th>
                    <th>Asked By</th>
                    <th>Question Text</th>
                    <th>Answer</th>
                    <th>Answered By</th>
                </tr>
                <%
                while (result.next()) {
                    out.print("<tr>");
                    out.print("<td>"+result.getString(1)+"</td>");
                    out.print("<td>"+result.getString(2)+"</td>");
                    out.print("<td><textarea readonly='true' >" + result.getString(3) + "</textarea></td>");
                    String reply = result.getString(4);
                    if (reply == null) {
                        reply = "";
                    }
                    out.print("<td>"+
                        "<form method=\"post\" action=\"repAnswerQuestionsLogic.jsp?QID="+result.getString(1)+"\">"+
                            "<textarea name=\"replyText\">"+reply+"</textarea>"+
                            "<input type=\"submit\" value=\"Update\"></input>"+
                        "</form>"+
                        "</td>");
                    String answeredBy = result.getString(5);
                    if (answeredBy == null) {
                        answeredBy = "";
                    }
                    out.print("<td>"+answeredBy+"</td>");
                    out.print("</tr>");
                }
                %>
            </table>
            <%
            db.closeConnection(con);
        } catch (Exception e) {
            e.printStackTrace();
        }
        %>

    </body>
</head>
</html>