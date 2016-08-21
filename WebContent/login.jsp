<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Login</title>
</head>
<body>
<h1 align="center">Welcome to CS480 BookStore</h1>
<br>
<br>
<%@ page import="java.sql.*" %> 
<%@ page import="java.io.*" %>
<%
String connectionURL = "jdbc:mysql://server_name/database_name";
Connection connection = null; 
Class.forName("com.mysql.jdbc.Driver").newInstance(); 
connection = DriverManager.getConnection(connectionURL, "username", "password");

%>
<div align="center">Please Login</div>

<div align="center">
	 <form action="login2.jsp" method="post"> 
			<br/>
				<table>
						<tr>
							<td>Username:</td>
							<td><input type="text" name="username"></td>
				 	 	</tr>
 						<tr>
 							<td>Password:</td>
 							<td><input type="password" name="password"></td>
						</tr>
						<tr> 
						<td></td>	
 						<td><Button Type="submit" formaction="login2.jsp">Submit</Button></td> 
  						</tr>
 				</table>
 	</form>
 	<form action="login2.jsp" method="post">
 			<Button Type="submit" formaction="register.jsp">New User Register Here!</Button>
 	</form>
</div> 
</body>
</html>