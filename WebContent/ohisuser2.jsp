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
			    
			    
			    String user= request.getParameter("uid");
			    String date= request.getParameter("date");
			   	String uname= request.getParameter("username");
			    
			    String query4 = "SELECT h.userid, u.username from history as h, users as u where u.userid=h.userid and h.orderdetails in (select orderdetails from history where orderdetails > '"+date+"') union SELECT o.userid, u.username from orders as o, users as u where u.userid=o.userid and o.order_date in (select order_date from orders where order_date > '"+date+"')";
			    Statement stat4=connection.createStatement();
			    ResultSet rs=stat4.executeQuery(query4);
			    
			  
			    	%>
			    		<h1 align="center">Welcome to CS480 BookStore</h1>
			    		<br/>
			    		<br/>
			    		<h3 align="center">List of users having orders after <%out.println(""+date+"");%> is as follows:</h3>
			    		<br/>
			    		<br/>
			    		
			    		<%
			    		if (!rs.next()){
			    		%>
			    		<br></br>
		    	   		<div align="center">No Record(s) found!</div>
							<%
			    		} else {
							%>
						
	 					<table border="2" cellpadding="1" cellspacing="2" align="center">
							<thead>
								<tr>
									<td align="center" style="width: 200px; font-weight:bold;">User ID</td>
									<td align="center" style="width: 200px; font-weight:bold;">User Name</td>
									<td></td>
								</tr>
							</thead>
  						<%
  						
  					  do
  			    	{
  						
  						  %>
  							<tr>
			    				<td align="center"><%out.println( rs.getString("userid"));%></td>
								<td align="center"><%out.println(rs.getString("username"));%></td>
								<form action="uhistory.jsp">
									<input type="hidden" name="uid" value="<%= user %>">
									<input type="hidden" name="date" value="<%= date %>">
									<input type="hidden" name="userid" value="<%= rs.getString("userid")%>">
									<input type="hidden" name="username" value="<%= rs.getString("username")%>">
									<td align="center"><button type="submit" formaction="uhistory.jsp">View Details</button></td>
								</form>
							</tr>
  						<%
  			    	}while (rs.next());
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