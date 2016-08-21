<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Modify User</title>
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
				String user= request.getParameter("user");
				String uid= request.getParameter("userid");
			    String uname= request.getParameter("username");
			    String pswd= request.getParameter("password");
			    String fname= request.getParameter("fname");
			    String add= request.getParameter("add");
			    String ccno= request.getParameter("ccno");
			    String type= request.getParameter("type");
			    
			    //int ccno = Integer.valueOf(ccno1);
			    String query =("update users set username='"+uname+"',pass_word='"+pswd+"' , full_name='"+fname+"',address='"+add+"',credit_card='"+ccno+"',utype='"+type+"' where userid='"+uid+"'");
			    Statement stat=connection.createStatement();
			    stat.executeUpdate(query);
			    %>
			    <h3 align="center">Records have been updated!</h3>
			    <br></br>
			    <br></br>
			    <table  cellpadding="1" cellspacing="2" align="center">
			   <tr>
			    	<h3 align="center">What would you like to do next?</h3>
			    	
			    	</tr>
			    	
			    	<tr>
			    		<form action="manage.jsp">
						<input type="hidden" name="uid" value="<%= user%>">
						<td align="center"><button type="submit" formaction="manage.jsp">Manage another User</button></td>
						</form>	
						
						<td align="center">or </td>
			    		
			    		<form action="admin.jsp">
						<input type="hidden" name="uid" value="<%= user%>">
						<td align="center"><button type="submit" formaction="admin.jsp">Go To Main Admin Page</button></td>
						</form>	
			    					    		
					</tr>
					</table>
			    <% 
			    
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