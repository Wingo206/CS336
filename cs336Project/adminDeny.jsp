<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<title>Access Denied</title>
	</head>
	<body>
		<h1>Access Denied</h1>
		<p>You must be an admin to view this page</p>
	</body>
</html>
<%
	response.setHeader("Refresh", "2; URL=login.jsp"); // like a redirect, but with a delay
%>