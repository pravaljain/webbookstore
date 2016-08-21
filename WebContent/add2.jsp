<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Add New User</title>
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
	 
try {
String connectionURL = "jdbc:mysql://server_name/database_name";
Connection connection = null; 
Class.forName("com.mysql.jdbc.Driver").newInstance(); 
connection = DriverManager.getConnection(connectionURL, "username", "password");

String uid4=(String) session.getAttribute("uid");
//int uid4 = Integer.parseInt(user1);
String check= "select utype from users where userid='"+uid4+"'";
Statement stat8=connection.createStatement();
ResultSet rs8=stat8.executeQuery(check);
while (rs8.next()){
	String s= rs8.getString("utype");
	String s2= "admin";
if (s.equals(s2))
{
				String user= request.getParameter("user");
				String uid= request.getParameter("userid");
			    String uname= request.getParameter("username");
			    String pswd= request.getParameter("password");
			    String fname= request.getParameter("fname");
			    String add= request.getParameter("add");
			    String ccno= request.getParameter("ccno");
			    String type= request.getParameter("type");
			    
			    String query1="select userid from users where userid='"+uid+"'";
			    String query =("insert into users(userid,username,pass_word, full_name,address,credit_card,utype) values('"+uid+"','"+uname+"','"+pswd+"','"+fname+"','"+add+"','"+ccno+"','"+type+"')");
			    Statement stat=connection.createStatement();
			    ResultSet rs=stat.executeQuery(query1);
			     
			    if (rs.next())
			    	{
			    	%>
			    		<h1 align="center">Welcome to CS480 BookStore</h1>
			    		<br/>
			    		<br/>
			    		<h3 align="center">Username Unavailable!</h3>
			    		<br/>
			    		<br/>
			    		<div align="center">Please try again with a different username.</div>

						<div align="center">
	 <form action="add2.jsp" method="post"> 
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
							<form action="cavail2.jsp" method="post">
 								<td>UserID*:</td>
								<td><input type="text" name="userid" maxlength="2" required></td>
								<td><input type="hidden" name="user" value="<%= user%>"></td>
 								<td><Button Type="submit" formaction="cavail2.jsp">Check Availability</Button></td>
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
							<td>User Type *:</td>
							<td><input type="text" name="type" required maxlength="10"></td>
				 	 	</tr>
						<tr> 	
						<br/>
						<td></td>
 						<td><Button Type="submit" formaction="add2.jsp">Submit</Button></td> 
  						<td></td>
  						</tr>
  						
 				</table>
 	</form>
 	
</div> 		    	<%
			    	
			    	}
			    else
			    	{		    
			    		stat.executeUpdate(query);
			    		%>
			    		<h3 align="center"> The User has been added to the database</h3>
			    		<%
			    		

			    
			    %>
			    <table  cellpadding="1" cellspacing="2" align="center">
			   <tr>
			    	<h4 align="center">What would you like to do next?</h4>
			    	</tr>
			    	
			    	<tr>
			    		<form action="add.jsp">
						<input type="hidden" name="uid" value="<%= user%>">
						<td align="center"><button type="submit" formaction="add.jsp">Add another user.</button></td>
						</form>
			    		
			    		<td align="center">or </td>
			    		
			    		<form action="manage.jsp">
						<input type="hidden" name="uid" value="<%= user%>">
						<td align="center"><button type="submit" formaction="manage.jsp">Manage User</button></td>
						</form>	
						
						<td align="center">or </td>
			    		
			    		<form action="admin.jsp">
						<input type="hidden" name="uid" value="<%= user%>">
						<td align="center"><button type="submit" formaction="admin.jsp">Go To Main Admin Page.</button></td>
						</form>	
			    					    		
					</tr>
					</table>
			    <% 
			    	}
			}
		    else 
		    {
		    	response.sendError(401);
		    }
		   } 
			if(!connection.isClosed())
			{    
				connection.close();
			}
			}
			catch(Exception ex)
				{
				System.out.println(ex.toString());
					out.println("Unable to connect to database.");
				}
}
%>
</body>
</html>