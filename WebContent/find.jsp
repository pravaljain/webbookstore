<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Find User(s)</title>
</head>
<body>
<jsp:include page="header.jsp" />
<h1 align="center">Welcome To CS480 BookStore</h1>


<%@ page import="java.sql.*" %> 
<%@ page import="java.io.*" %>



	<table  cellpadding="1" cellspacing="2" align="center">
		
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
			    while (rs8.next()){
			    	String s= rs8.getString("utype");
			    	String s2= "admin";
			    if (s.equals(s2))
			    {
			    String user= request.getParameter("uid");
			    String name= request.getParameter("name");
			    
			    String admin = "Select full_name from users where userid='"+user+"' and utype='admin'";
			    Statement stat=connection.createStatement();
			    ResultSet rs1=stat.executeQuery(admin);
			    
			    String query= "Select userid, username, pass_word, full_name, address, credit_card,utype from users where (username='"+name+"') or (full_name='"+name+"%')";
			    Statement stat2=connection.createStatement();
			    ResultSet rs2=stat2.executeQuery(query);
			    String name2= "username or fullname";
			    Boolean comp= name.equals(name2);
			    if (name==null||name=="" || comp==true){
			    	%>
			    	<h4 align="center"><%out.println("No Records Found.");%></h4>
			    	<%
			    }
			    else {
			    while (rs1.next())
			    {
			    	%>
			    	<h3 align="center"><%out.println(rs1.getString("full_name"));%>,Here is/are the user(s) you were looking for.</h3>
			    	<br></br>
			    	<table  border="2" cellpadding="1" cellspacing="2"  align="center">
			    	<thead>
						<tr>
							<td align="center" style="width: 200px; font-weight:bold;">User ID</td>
							<td align="center" style="width: 200px; font-weight:bold;">User Name</td>
							<td align="center" style="width: 200px; font-weight:bold;">Password</td>
							<td align="center" style="width: 200px; font-weight:bold;">Full Name</td>
							<td align="center" style="width: 200px; font-weight:bold;">Address</td>
							<td align="center" style="width: 200px; font-weight:bold;">Credit Card#</td>
							<td align="center" style="width: 200px; font-weight:bold;">User Type</td>
							<td align="center" style="width: 200px; font-weight:bold;">Modify User</td>
							<td align="center" style="width: 200px; font-weight:bold;">Delete User</td>
						</tr>
					</thead>
			    	<%
			    	while(rs2.next()){
			    	%>
			    	
			    	<tr>
			    	<td align="center"><%out.println(rs2.getString("userid"));%></td>
					<td align="center"><%out.println(rs2.getString("username"));%></td>
					<td align="center"><%out.println(rs2.getString("pass_word"));%></td>
					<td align="center"><%out.println(rs2.getString("full_name"));%></td>
					<td align="center"><%out.println(rs2.getString("Address"));%></td>
					<td align="center"><%out.println(rs2.getString("credit_card"));%></td>
					<td align="center"><%out.println(rs2.getString("utype"));%></td>
					<form action="modify.jsp">
					<input type="hidden" name="userid" value="<%= rs2.getString("userid")%>">
					<input type="hidden" name="uid" value="<%= user%>">
					<td align="center"><button type="submit" formaction="modify.jsp">Modify</button></td>
					</form>
					
					<form action="delete.jsp">
					<input type="hidden" name="userid" value="<%= rs2.getString("userid")%>">
					<input type="hidden" name="uid" value="<%= user%>">
					<td align="center"><button type="submit" formaction="delete.jsp">Delete</button></td>
					</form>
					</tr>	
					
			    	<%
			    	}
			    	%>
			    	</table>
			    	<%
			    }
			    }	
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
%>
</body>
</html>