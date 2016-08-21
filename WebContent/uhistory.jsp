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
			    
			    String date= request.getParameter("date");
			    String user= request.getParameter("uid");
			    String userid= request.getParameter("userid");
			    String username= request.getParameter("username");
			  
			    String query4 = "SELECT h.orderid, h.userid, h.ISBN, h.quantity, h.orderdetails from history as h, users as u where u.userid=h.userid and u.username='"+username+"' and h.orderdetails in (select orderdetails from history where orderdetails > '"+date+"') union SELECT o.orderid, o.userid, o.ISBN, o.quantity, o.order_date from orders as o, users as u where u.userid=o.userid and u.username='"+username+"' and o.order_date in (select order_date from orders where order_date > '"+date+"')";
			    Statement stat4=connection.createStatement();
			    ResultSet rs=stat4.executeQuery(query4);
			    
			  
			    	%>
			    		<h1 align="center">Welcome to CS480 BookStore</h1>
			    		<br/>
			    		<br/>
			    		<h3 align="center">User history for <%out.println(""+username+"");%> is as follows:</h3>
			    		<br/>
			    		<br/>
			    		
	 					<table border="2" cellpadding="1" cellspacing="2" align="center">
							<thead>
								<tr>
									<td align="center" style="width: 200px; font-weight:bold;">Order ID</td>
									<td align="center" style="width: 200px; font-weight:bold;">User ID</td>
									<td align="center" style="width: 200px; font-weight:bold;">ISBN</td>
									<td align="center" style="width: 200px; font-weight:bold;">Quantity</td>
									<td align="center" style="width: 200px; font-weight:bold;">Order Date</td>
								</tr>
							</thead>
  						<%
  						
  						while (rs.next())
  			    	{	
  						
  						  %>
  							<tr>
			    				<td align="center"><%out.println(rs.getString("orderid"));%></td>
								<td align="center"><%out.println(rs.getString("userid"));%></td>
								<td align="center"><%out.println(rs.getString("ISBN"));%></td>
								<td align="center"><%out.println(rs.getString("quantity"));%></td>
								<td align="center"><%out.println(rs.getString("orderdetails"));%></td>
							</tr>
  						<%
  			    	}				
						
  						%>
  						
  						
 						</table>
 		
			    	
			   <table  cellpadding="1" cellspacing="2" align="center">
			   <tr>
			    	<h4 align="center">What would you like to do next?</h4></tr>
			    	
			    	<tr>
			    		<form action="ohisuser.jsp">
						<input type="hidden" name="uid" value="<%= user%>">
						<td align="center"><button type="submit" formaction="ohisuser.jsp">See Order History for another user.</button></td>
						</form>
			    		
			    		<td align="center">or </td>
			    		
			    		<form action="userstats.jsp">
						<input type="hidden" name="uid" value="<%= user%>">
						<td align="center"><button type="submit" formaction="userstats.jsp">See Statistics about orders.</button></td>
						</form>	
			    					    		
					</tr>
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