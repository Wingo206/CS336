<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Questions</title>
    <body>
        <%
        try{
            // get parameters from the text input
            String questionText = request.getParameter("questionText");

            if (questionText == "") {
                %>
                <p>empty string</p>
                <%
            } else {
                // valid question
                String username = (String) session.getAttribute("username");
                ApplicationDB db = new ApplicationDB();
                Connection con = db.getConnection();
                String insert = "INSERT INTO question(questionText, customer) VALUES (?, ?)";
                PreparedStatement ps = con.prepareStatement(insert);

                ps.setString(1, questionText);
                ps.setString(2, username);

                ps.executeUpdate();

                %>
                <h3>Your question has been posted.</h3>
                <fieldSet>
                    <legend>Question text</legend>
                    <%
                    out.println("<p>" + questionText + "</p>");
                    %>
                </fieldSet>
                <p>You will be redirected to the questions page shortly.</p>
                <%
                db.closeConnection(con);

                response.setHeader("Refresh", "5; URL=questions.jsp");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        %>
    </body>
</head>
</html>