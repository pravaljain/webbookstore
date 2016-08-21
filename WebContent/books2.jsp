<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Books Catalog</title>
</head>
<body>
<jsp:include page="header.jsp" />
<h1 align="center">Welcome To CS480 BookStore</h1>
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


	<table border="2" cellpadding="1" cellspacing="2" align="center">
		<thead>
			<tr>
				<td align="center" style="width: 200px; font-weight:bold;">Book Title</td>
				<td align="center" style="width: 200px; font-weight:bold;">Author(s)</td>
				<td align="center" style="width: 200px; font-weight:bold;">Description</td>
				<td align="center" style="width: 200px; font-weight:bold;">Price (in USD)</td>
				<td align="center" style="width: 200px; font-weight:bold;">Quantity</td>
				<td align="center" style="width: 200px; font-weight:bold;">Order</td>
			</tr>
			</thead>
			<%
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
			    if (rs8.next()){
			    	String s= rs8.getString("utype");
			    	String s2= "admin";
			    if (s.equals(s2))
			    {
			    	String admin = "Select userid from users where userid='"+user1+"' and utype='admin'";
			    	Statement stat4=connection.createStatement();
			    	ResultSet rs4=stat4.executeQuery(admin);
				    if (rs4.next())
				    {
				    	session.setAttribute("uid", rs4.getString("userid"));
				    	
				    }
			    
			    String uid2= request.getParameter("uid2");
			    String query="select b.title, a.author_name, b.description, b.cost, b.ISBN from books as b, writer as a where b.id=a.id";
			    Statement stat=connection.createStatement();
			    ResultSet rs=stat.executeQuery(query);
			    
			    while (rs.next())
			    {
			    	%>
			    	<tr>
			    	<td align="center"><img src="<%out.println( rs.getString("title"));%>" style="height: 318px; width:197px;"></td>
					<td align="center"><%out.println(rs.getString("author_name"));%></td>
					<td align="center"><%out.println(rs.getString("description"));%></td>
					<td align="center"><%out.println(rs.getFloat("cost"));%></td>
					<form action="cart.jsp">
					<input type="hidden" name="ISBN" value="<%out.println(rs.getString("ISBN"));%>">
					<input type="hidden" name="uid" value="<%out.println(""+uid2+"");%>">
					<td align="center"><input type="text" name="qty" value=""></td>
					<td align="center"><button type="submit" formaction="cart.jsp">Buy Now</button></td>
					</form>
					
					</tr>
				<%
			    }
			     }
			    else{
			    	response.sendRedirect("login.jsp");
			    	}
			   
			%>
			
	</table>
	<%
		if(!connection.isClosed())
		{    
   		connection.close();
		}
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