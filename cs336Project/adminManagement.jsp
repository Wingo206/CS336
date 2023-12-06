<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>


<!-- redirect client to access denied page -->
<%
	if (!"admin".equals((String) session.getAttribute("accountType"))) {
		response.sendRedirect("adminDeny.jsp");
	}
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Customer and Representative Management</title>
	</head>
	
	<body>
		<br>
			<form method="get" action="admin.jsp">
				<input type="submit" value="Return to admin page">
			</form>
		<br>
		
		<br>
		<form method="post" action="registerLogic.jsp">
		
		<table>
			<tr>    
				<td>Username: </td> <td><input type="text" name="usernameInput"></td>
			</tr>
			<tr>
				<td>Password: </td><td><input type="text" name="passwordInput"></td>
			</tr>
			<tr>    
				<td>First Name: </td> <td><input type="text" name="firstNameInput"></td>
			</tr>
			<tr>
				<td>Last Name: </td><td><input type="text" name="lastNameInput"></td>
			</tr>
			<tr>    
				<td>Account Type: </td> <td><input type="text" name="accountTypeInput"></td>
			</tr>
				<input type="hidden" name="registerFrom" value = "admin">

		</table>
		<input type="submit" value="Create new account">
		
		</form>
		<br>

		<!-- List of customers -->
		<%
		try {
			// Get the database connection
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();

			// Create a SQL statement
			Statement stmt = con.createStatement();

			// Make a SELECT query from the table specified
			String str = "SELECT * FROM account WHERE accountType = 'customer'";

			// Run the query against the database
			ResultSet result = stmt.executeQuery(str);

			// Get metadata to retrieve column names
			ResultSetMetaData metaData = result.getMetaData();
			int columnCount = metaData.getColumnCount();
		%>
		<!-- Make an HTML table to show the results -->
		<table border="1">
			<tr>
				<!-- Generate table headers dynamically -->
				<%
				for (int i = 1; i <= columnCount; i++) {
					out.println("<th>" + metaData.getColumnName(i) + "</th>");
				}
				%>
			</tr>

			<!-- Parse out the results -->
			<%
			while (result.next()) {
			%>
				<tr>
					<!-- Generate table rows dynamically -->
					<!-- each input field has a hidden field with the old username -->
					<%
					for (int i = 1; i <= columnCount; i++) {
						out.println("<td><form method='POST' action='adminManagementLogicEdit.jsp'>"+"<input type='text' name= " + metaData.getColumnName(i) +  " placeholder = " + result.getString(i) +">"+"<input type='hidden' name='user' value=" + result.getString("username") + " />"+"<input type='submit'  name = 'button' value = 'Update'></form></td>");
					}
					%>
				</tr>
			<%
			}
			// Close the connection and resources
			db.closeConnection(con);

		} catch (Exception e) {
			// Log the exception instead of printing it to the page
			e.printStackTrace();
		}
		%>
		</table>



		
		
	</body>
</html>
