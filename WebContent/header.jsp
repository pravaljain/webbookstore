<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>CS480 Book Store</title>
</head>
<body>
<%@ page import="java.sql.*" %> 
<%@ page import="java.io.*" %>

			<%
			try {
			    String connectionURL = "jdbc:mysql://server_name/database_name";
			    Connection connection = null; 
			    Class.forName("com.mysql.jdbc.Driver").newInstance(); 
			    connection = DriverManager.getConnection(connectionURL, "username", "password");
			    Statement stat=connection.createStatement();
			    String uid4=(String) session.getAttribute("uid");
			    String admin = "Select full_name from users where userid='"+uid4+"'";
			    
			    ResultSet rs1=stat.executeQuery(admin);
			    
			    while (rs1.next())
			    {
			    	%>
			    	<table align="right">
			    		<tr>
			    		<td>Hi, <%out.println(rs1.getString("full_name"));%>!</td>
			    		<td>
			    		<td><a href=logout.jsp>Logout</a>
						</tr>
					</table>
					<br></br>
					
				<%
			    }
			%>
			
	<%
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
%>
</body>
</html>