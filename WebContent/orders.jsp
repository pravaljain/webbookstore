<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Order Receipt</title>
</head>
<body>

<%@ page import="java.sql.*" %> 
<%@ page import="java.io.*" %>
<jsp:include page="header.jsp" />
<h1 align="center">CS480 BookStore</h1>
<br>
<br>
<div align="center">
<h2 align="center">Hi</h2>
<h3 align="center">Your Order has been placed successfully!</h3>
<br>

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
			    String uid2= request.getParameter("uid");
			    String isbn= request.getParameter("ISBN");
			    String qt1= request.getParameter("qty");
			    String query1= ("insert into history(orderid, userid,ISBN,quantity,orderdetails) Select orderid,userid,ISBN, quantity, Now() from orders where userid='"+uid2+"'");
			    String query2 =("DELETE FROM orders where userid='"+uid2+"'");
			    
			   
			    stat.executeUpdate(query1);
			    stat.executeUpdate(query2);
			    			   
			    
			    
			    
			   //while (rs.next())
			    	{
			    	%>
			    	<table  cellpadding="1" cellspacing="2" align="center">
			   <tr>
			    	<h4 align="center">What would you like to do next?</h4>
			    	</tr>
			    	
			    	<tr>
			    		<form action="books.jsp">
						<input type="hidden" name="uid" value="<%= uid2%>">
						<td align="center"><button type="submit" formaction="books.jsp">Buy more Books.</button></td>
						</form>
			    		
			    		<td align="center">or</td>
			    		
			    		<form action="logout.jsp">
						<input type="hidden" name="uid" value="<%= uid2%>">
						<td align="center"><button type="submit" formaction="logout.jsp">Logout.</button></td>
						</form>	
						    		
					</tr>
					</table>
		
			    <%
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