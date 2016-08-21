<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Your Cart</title>
</head>
<body>
<jsp:include page="header.jsp" />
<h1 align="center">This is Your Cart.</h1>
<br></br>
<br></br>

<%@ page import="java.sql.*" %> 
<%@ page import="java.io.*" %>

<%

if ( session.getAttribute("uid") == null || ((String) session.getAttribute("uid")).compareTo("") == 0 ) {
	response.sendRedirect("login.jsp");
}
else {
	 %>
	
		
	<table border="2" cellpadding="1" cellspacing="2"  align="center">
		<thead>
			<tr>
				<td align="center" style="width: 200px; font-weight:bold;">Book Title</td>
				<td align="center" style="width: 200px; font-weight:bold;">ISBN</td>
				<td align="center" style="width: 200px; font-weight:bold;">Author(s))</td>
				<td align="center" style="width: 200px; font-weight:bold;">Description</td>
				<td align="center" style="width: 200px; font-weight:bold;">Quantity</td>
				<td align="center" style="width: 200px; font-weight:bold;">Price (in USD)</td>
				
				
				
			</tr>
			</thead>
			<%
			try {
			    String connectionURL = "jdbc:mysql://server_name/database_name";
			    Connection connection = null; 
			    Class.forName("com.mysql.jdbc.Driver").newInstance(); 
			    connection = DriverManager.getConnection(connectionURL, "username", "password");
			    
			    
			    String isbn= request.getParameter("ISBN");
			    String qt1= request.getParameter("qty");
			    int qty2= Integer.valueOf(qt1);
			    String uid1= request.getParameter("uid");
			    
			    String query1 =("insert into orders(ISBN,userid, quantity,order_date) values('"+isbn+"','"+uid1+"',"+qty2+", Now())");
			    String query2="select b.title, b.ISBN, a.author_name, b.description, sum(o.quantity) as quant, b.cost*sum(o.quantity) as Cost, o.orderid from books as b, orders as o, writer as a where b.ISBN=O.ISBN and b.id=a.id and o.userid='"+uid1+"' group by o.ISBN";
			    String query3= "Select sum(Cost) from (select b.cost*sum(o.quantity) as Cost from books as b, orders as o where b.ISBN=O.ISBN and o.userid='"+uid1+"' group by o.ISBN)as Total_Cost";
			    Statement stat=connection.createStatement();
			    Statement stat2=connection.createStatement();
			    stat.executeUpdate(query1);
			    ResultSet rs=stat.executeQuery(query2);
			    ResultSet rs2=stat2.executeQuery(query3);
			   while (rs.next())
			    	{
			    	%>
			    							
			    	<tr>
			    	<td align="center"><img src="<%out.println(rs.getString("title"));%>" style="height: 318px; width:197px;"></td>
					<td align="center"><%out.println(rs.getString("ISBN"));%></td>
					<td align="center"><%out.println(rs.getString("author_name"));%></td>
					<td align="center"><%out.println(rs.getString("description"));%></td>
					<td align="center"><%out.println(rs.getInt("quant"));%> 
										<form action="change.jsp">
											<input type="hidden" name="uid" value="<%out.println(""+uid1+"");%>">
											<input type="hidden" name="ISBN" value="<%out.println(""+isbn+"");%>">
											<input type="hidden" name="qty" value="<%out.println(rs.getInt("quant"));%>">
											<button type="submit" formaction="change.jsp">Add More</button>
										</form>
					</td>
					<td align="center"><%out.println(rs.getFloat("Cost"));%></td>
					</tr>
				   <%
				  
			    	}
			    while(rs2.next())
				   {
					%>
					   <tr>
					   <td></td>
					   <td></td>
					   <td></td>
					   <td></td>
					   <td style="font-weight:bold;" align="center">Total Cost</td>
					   <td align="center"><%out.println(rs2.getFloat("sum(cost)"));%></td>
				   		</tr>
				   <%
				   }
			     
			%>
			
			
		</table>
		 <table align="center">
			    		<tr>
							<td align="left" >
								<form action="books.jsp" >
									<button type="submit" formaction="books.jsp">Continue Shopping</button>
								</form>
							</td>
							<td align="right">
								<form action="orders.jsp">
									<input type="hidden" name="uid" value="<%out.println(""+uid1+"");%>">
									<input type="hidden" name="ISBN" value="<%out.println(""+isbn+"");%>">
									<input type="hidden" name="qty" value="<%out.println(""+qty2+"");%>">
									<button type="submit" formaction="orders.jsp">Confirm and Checkout</button>
														
								</form>
							</td>
						</tr>	
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