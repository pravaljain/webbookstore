<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>User History</title>
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
Statement stat8=connection.createStatement();
ResultSet rs8=stat8.executeQuery(check);
while (rs8.next()){
	String s= rs8.getString("utype");
	String s2= "admin";
if (s.equals(s2))
{


String uid= request.getParameter("uid");

%>
<div align="center">Please provide the date and we'll list all the users who have orders after that date.</div>


<div align="center">
	 <form action="ohisuser2.jsp" method="post"> 
			<br/>
				<table>
						<tr >
						<td></td>
  							<td style="font-size: small;">
  								* mandatory fields
  							</td>
  							<td></td>
  						</tr>
						<!--tr>
								<td>Username*:</td>
								<td><input type="text" name="username" maxlength="50" required></td>
 								
					 	</tr-->
				 	 	<tr>
							<td>Date *:</td>
							<td><input type="text" name="date" value="YYYY-MM-DD" required></td>
				 	 	</tr>
						<tr> 	
						<br/>
						<td></td>
						<input type="hidden" name="uid" value="<%= uid %>">
 						<td><Button Type="submit" formaction="ohisuser2.jsp">Submit</Button></td> 
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