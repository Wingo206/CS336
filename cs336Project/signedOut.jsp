<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<title>Signed Out</title>
	</head>
	<body>
		<h1>You were signed out.</h1>
		<p>Please sign in again.</p>
	</body>
</html>
<%
	response.setHeader("Refresh", "2; URL=login.jsp"); // like a redirect, but with a delay
%>