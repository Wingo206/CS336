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

            String username = (String) session.getAttribute("username");
            String replyText = request.getParameter("replyText");
            String QID = request.getParameter("QID");
            String update = "UPDATE question SET reply = ?, customerRep = ? WHERE QID = ?";
            PreparedStatement ps = con.prepareStatement(update);
            ps.setString(1, replyText);
            ps.setString(2, username);
            ps.setString(3, QID);
            ps.executeUpdate();

            db.closeConnection(con);
            response.sendRedirect("repAnswerQuestions.jsp");
        } catch (Exception e) {
            e.printStackTrace();
        }
        %>
    </body>
</head>
</html>