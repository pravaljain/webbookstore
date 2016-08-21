<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Manage Users</title>
</head>
<body>
<jsp:include page="header.jsp" />
<h1 align="center">Welcome To CS480 BookStore</h1>


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
			    
			    Statement stat=connection.createStatement();
			    String user= request.getParameter("uid");
			    String admin = "Select full_name from users where userid='"+user+"' and utype='admin'";
			    ResultSet rs1=stat.executeQuery(admin);
			    
			    while (rs1.next())
			    {
			    	%>
			    	<h3 align="center">Hi, <%out.println(rs1.getString("full_name"));%>. Please be careful while conducting your managerial tasks.</h3>
			    	
			    	<table  cellpadding="1" cellspacing="2" align="center">
			    	<tr>
									    
			    		<form action="add.jsp">
						<input type="hidden" name="uid" value="<%= user%>">
						<td align="center"><button type="submit" formaction="add.jsp">Add New User</button></td>
						</form>
			    		<td></td>
			    		<td></td>
			    		<td></td>
			    		<td></td>
			    		<td></td>
			    		<td></td>
			    		<td></td>
			    		<td align="center">or </td>
						<td></td>
			    		<td></td>
			    		<td></td>
			    		<td></td>
			    		<td></td>
			    		<td></td>
			    		<td></td>
			    		<form action="find.jsp">
						<input type="hidden" name="uid" value="<%= user%>">
						<td align="center"><button type="submit" formaction="find.jsp">Search</button></td>
						<td><input type="text" name="name" value="username or fullname" maxlength="50" required></td>
						</form>
			    		<td></td>
			    		<td></td>
			    		<td></td>
			    		<td></td>
			    		<td></td>
			    		<td></td>
			    		<td></td>
			    		<td align="center">or </td>
			    		<td></td>
			    		<td></td>
			    		<td></td>
			    		<td></td>
			    		<td></td>
			    		<td></td>
			    		<td></td>
			    		<form action="findall.jsp">
						<input type="hidden" name="uid" value="<%= user%>">
						<td align="center"><button type="submit" formaction="findall.jsp">Show All</button></td>
						</form>	
			    					    		
					</tr>	
			    	<%
			    }
			    	    
			%>
			
	</table>
	<%
			}
		    else {
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