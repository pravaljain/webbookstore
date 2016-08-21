<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Check Availability</title>
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
			    
			    String uid4=(String) session.getAttribute("uid");
			    //int uid4 = Integer.parseInt(user1);
			    String check= "select utype from users where userid='"+uid4+"'";
			    Statement stat8=connection.createStatement();
			    ResultSet rs8=stat8.executeQuery(check);
			    while (rs8.next()){
			    	String s= rs8.getString("utype");
			    	String s2= "admin";
			    if (s.equals(s2))
			    {
			    
			    String user=request.getParameter("user");
				String uid= request.getParameter("userid");
				String uname= request.getParameter("username");
				String pass= request.getParameter("password");
				String fname= request.getParameter("fname");
				String add= request.getParameter("add");
				String ccn= request.getParameter("ccno");
				String type= request.getParameter("type");
			    String query="select userid from users where userid='"+uid+"'";
			    Statement stat=connection.createStatement();
			    ResultSet rs=stat.executeQuery(query);
			    
			    
			    
			    if (rs.next())
			    	{
			    	%>
			    		<h1 align="center">Welcome to CS480 BookStore</h1>
			    		<br/>
			    		<br/>
			    		<h3 align="center">Username Unavailable!</h3>
			    		<br/>
			    		<div align="center">Please try again with a different Username.</div>

						<div align="center">
					
					<form action="add2.jsp" method="post"> 
						<br/>
							<table>
									<tr >
									<td></td>
			  							<td style="font-size: small;">
			  								* mandatory fields
			  							</td>
			  							<td></td>
			  						</tr>
									<tr>
										<form action="cavail2.jsp" method="post">
			 								<td>UserID*:</td>
											<td><input type="text" name="userid" maxlength="2" required></td>
			 								<td><input type="hidden" name="user" value="<%= user%>"></td>
			 								<td><Button Type="submit" formaction="cavail2.jsp">Check Availability</Button></td>
			 							</form>
								 	</tr>
							 	 	<tr>
										<td>Username *:</td>
										<td><input type="text" name="username" maxlength="50" required></td>
							 	 	</tr>
									<tr>
										<td>Password *:</td>
										<td><input type="password" name="password" maxlength="50" required></td>
							 	 	</tr>
			 						<tr>
			 							<td>Full Name *:</td>
			 							<td><input type="text" name="fname" maxlength="50" required></td>
									</tr>
									<tr>
										<td>Address *:</td>
										<td><input type="text" name="add" maxlength="80" required></td>
							 	 	</tr>
							 	 	<tr>
										<td>Credit Card Number *:</td>
										<td><input type="number" name="ccno" required maxlength="16"></td>
							 	 	</tr>
									<tr>
										<td>User Type *:</td>
										<td><input type="text" name="type" required maxlength="10"></td>
							 	 	</tr>
									<tr> 	
									<br/>
									<td></td>
									<td><input type="hidden" name="user" value="<%= user%>"></td>
			 						<td><Button Type="submit" formaction="add2.jsp">Submit</Button></td> 
			  						<td></td>
			  						</tr>
			  						
			 				</table>
			 	</form>
 		
			</div>  
			    	<%
			    	
			    	}
			    else 
			    	%>
			    	<h1 align="center">Welcome to CS480 BookStore</h1>
		    		<br/>
		    		<br/>
		    		<h3 align="center">Username Available!</h3>
		    		<br/>
		    		<div align="center">You may edit the details or proceed by clicking Submit button.</div>

					<div align="center">
 					<form action="add2.jsp" method="post"> 
						<br/>
						<table>
							<tr >
								<td></td>
  								<td style="font-size: small;">
  								* mandatory fields
  								</td>
  								<td></td>
  							</tr>
							<tr>
								
 									<td>UserID*:</td>
									<td><input type="text" name="userid" value="<%out.println(""+uid+"");%>"required maxlength="2" ></td>
	 								
					 		</tr>
					 	 	<tr>
									<td>Username *:</td>
									<td><input type="text" name="username" value="<%out.println(""+uname+"");%>"required maxlength="50" ></td>
					 	 	</tr>
							<tr>
									<td>Password *:</td>
									<td><input type="password" name="password" value="<%out.println(""+pass+"");%>" required maxlength="50" ></td>
					 	 	</tr>
	 						<tr>
		 							<td>Full Name *:</td>
		 							<td><input type="text" name="fname" value="<%out.println(""+fname+"");%>" required maxlength="50" ></td>
							</tr>
							<tr>
									<td>Address *:</td>
									<td><input type="text" name="add" value="<%out.println(""+add+"");%>" required maxlength="80" ></td>
					 	 	</tr>
					 	 	<tr>
									<td>Credit Card Number *:</td>
									<td><input type="number" name="ccno" value="<%out.println(""+ccn+"");%>" required maxlength="16" ></td>
				 		 	</tr>
							<tr>
									<td>User Type *:</td>
									<td><input type="text" name="type" value="<%out.println(""+type+"");%>" required maxlength="10" ></td>
					 	 	</tr>
							<tr> 	
								<br/>
								<td></td>
								<td><input type="hidden" name="uid" value="<%out.println(""+user+"");%>"></td>
 								<td><Button Type="submit" formaction="add2.jsp">Submit</Button></td> 
  								<td></td>
  							</tr>
  						
 						</table>
 					</form>
	
</div>
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
		//System.out.println(ex.toString());
   		out.println("Unable to connect to database.");
	}
}
%>
</body>
</html>