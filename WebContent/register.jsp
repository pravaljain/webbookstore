<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Register</title>
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
<div align="center">Please provide the following details:</div>


<div align="center">
	 <form action="register2.jsp" method="post"> 
			<br/>
				<table>
						<tr >
						<td></td>
  							<td style="font-size: small;">
  								* mandatory fields
  							</td>
  							<td></td>
  						</tr>
						<tr>
							<form action="cavail.jsp" method="post">
 								<td>UserID*:</td>
								<td><input type="text" name="userid" maxlength="2" required></td>
 								<td><Button Type="submit" formaction="cavail.jsp">Check Availability</Button></td>
 							</form>
					 	</tr>
				 	 	<tr>
							<td>Username *:</td>
							<td><input type="text" name="username" maxlength="50" required></td>
				 	 	</tr>
						<tr>
							<td>Password *:</td>
							<td><input type="password" name="password" maxlength="50" required></td>
				 	 	</tr>
 						<tr>
 							<td>Full Name *:</td>
 							<td><input type="text" name="fname" maxlength="50" required></td>
						</tr>
						<tr>
							<td>Address *:</td>
							<td><input type="text" name="add" maxlength="80" required></td>
				 	 	</tr>
				 	 	<tr>
							<td>Credit Card Number *:</td>
							<td><input type="number" name="ccno" required maxlength="16"></td>
				 	 	</tr>
						<tr> 	
						<br/>
						<td></td>
 						<td><Button Type="submit" formaction="register2.jsp">Submit</Button></td> 
  						<td></td>
  						</tr>
  						
 				</table>
 	</form>
 	
</div>

</body>
</html>