<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Statistics</title>
</head>
<body>
<jsp:include page="header.jsp" />
<h1 align="center">Welcome to CS480 BookStore</h1>
<br>
<br>
<%@ page import="java.sql.*" %> 
<%@ page import="java.io.*" %>
<%

if ( session.getAttribute("uid") == null || ((String) session.getAttribute("uid")).compareTo("") == 0 ) {
	response.sendRedirect("login.jsp");
}
else {
	 
String connectionURL = "jdbc:mysql://server_name/database_name";
Connection connection = null; 
Class.forName("com.mysql.jdbc.Driver").newInstance(); 
connection = DriverManager.getConnection(connectionURL, "username", "password");

String user1=(String) session.getAttribute("uid");
int uid4 = Integer.parseInt(user1);
String check= "select utype from users where userid='"+uid4+"'";
Statement stat=connection.createStatement();
ResultSet rs=stat.executeQuery(check);
while (rs.next()){
	String s= rs.getString("utype");
	String s2= "admin";
if (s.equals(s2))
{

String user= request.getParameter("uid");

%>
<div align="center">Please provide the following details:</div>


<div align="center">
	 <form action="stats2.jsp" method="post"> 
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
							<td>Date 1 *:</td>
							<td><input type="text" name="date1" value="YYYY-MM-DD" required></td>
				 	 	</tr>
						<tr>
							<td>Date 2 *:</td>
							<td><input type="text" name="date2" value="YYYY-MM-DD" required></td>
				 	 	</tr>
						<tr>
								<td>Book's ISBN:</td>
								<td><input type="text" name="isbn" maxlength="13"></td>
 								
					 	</tr>
				 	 	<tr>
								<td>Author's Name:</td>
								<td><input type="text" name="authname" maxlength="80"></td>
 								
					 	</tr>
						<tr> 	
						<br/>
						<td></td>
						<input type="hidden" name="uid" value="<%= user%>">
 						<td><Button Type="submit" formaction="stats2.jsp">Submit</Button></td> 
  						<td></td>
  						</tr>
  						
 				</table>
 	</form>
 	
</div> 
<%
}
else { 
	response.sendError(401);
}
}
}
%>
</body>
</html>