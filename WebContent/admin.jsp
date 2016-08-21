<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>CS480 Book Store</title>
</head>
<body>
<jsp:include page="header.jsp" />
<h1 align="center">Welcome To CS480 BookStore</h1>


<%@ page import="java.sql.*" %> 
<%@ page import="java.io.*" %>



	<table  cellpadding="1" cellspacing="2" align="center">
		
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
			    Statement stat=connection.createStatement();
			    Statement stat1=connection.createStatement();
			    
			   String user=(String) session.getAttribute("uid");
			   int uid4 = Integer.parseInt(user);
			  
			  	String check= "select utype from users where userid='"+uid4+"'";
			    String admin = "Select full_name from users where userid='"+user+"' and utype='admin'";
			    //String query="select b.title, a.author_name, b.description, b.cost, b.ISBN from books as b, writer as a where b.id=a.id";
			    //String uid1 = (String) session.getAttribute("uid");
			    //int u_id = Integer.valueOf(uid1);
			    //Statement stat=connection.createStatement();
			    ResultSet rs=stat.executeQuery(check);
			    while (rs.next()){
			    	String s= rs.getString("utype");
			    	String s2= "admin";
			    if (s.equals(s2))
			    {
			    ResultSet rs1=stat1.executeQuery(admin);
			    while (rs1.next())
			    {
			    	%>
			    	<tr>
			    	<td></td>
			    	<td align="left"><h3><%out.println(rs1.getString("full_name"));%>,</h3></td>
			    	<td></td>
			    	</tr>
			    	
			    	<tr>
			    	<td></td>
			    	<td><h4>What would you like to do?</h4></td>
			    	<td></td>
			    	</tr>
			    	
			    	<tr>
			    		<form action="manage.jsp">
						<input type="hidden" name="uid" value="<%= user%>">
						<td align="center"><button type="submit" formaction="manage.jsp">I want to Manage Users.</button></td>
						</form>
			    		
			    		<form action="stats.jsp">
						<input type="hidden" name="uid" value="<%= user%>">
						<td align="center"><button type="submit" formaction="stats.jsp">I want to see Statistics.</button></td>
						</form>	
			    		
			    		<form action="books.jsp">
						<input type="hidden" name="uid2" value="<%= user%>">
						<td align="center"><button type="submit" formaction="books2.jsp">I want to continue to the Bookstore.</button></td>
						</form>
					</tr>	
			    	<%
			    }
			    }
			    else {
			    	response.sendError(401);
			    }
			    }
			%>
			
	</table>
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
}
%>
</body>
</html>