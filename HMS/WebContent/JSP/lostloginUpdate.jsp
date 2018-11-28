<%@ page import="java.sql.*,com.jndi.*" language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- <%@ page import = "java.io.*,java.util.*,javax.mail.*"%>
<%@ page import = "javax.mail.internet.*"%>
<%@ page import = "javax.activation.*"%>
<%@ page import = "javax.servlet.http.*,javax.servlet.*" %>
<%@ page import = "javax.net.*" %> --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Send Email</title>
</head>
<body>

<%

	// establish connection to database
	DataAccessLayer ob=new DataAccessLayer();
	Connection con = ob.getConnection();
	
	// init email sending class
    SendEmail email = new SendEmail();
	
	// get input params
	String accountTypeInput = request.getParameter("accountTypeInput");
	String emailInput = request.getParameter("emailInput");
	System.out.println(accountTypeInput);
	System.out.println(emailInput);
	
	// check if user exists
	PreparedStatement ps = null;
	
	if (accountTypeInput.trim().equals("Doctor")) {
		ps = con.prepareStatement("Select * from doctors where doctor_email=?");
	} else if (accountTypeInput.trim().equals("Patient")) {
		ps = con.prepareStatement("Select * from patients where patient_email=?");
	} else if (accountTypeInput.trim().equals("Insurance Provider")) {
		ps = con.prepareStatement("Select * from insurance_providers where provider_email=?");
	} else {
		%>
		<script>alert("Account type does not exist.");</script>
		<%
	}
	
	ResultSet res = null;
	ps.setString(1,emailInput.trim());
	try {
		res = ps.executeQuery();
	} catch (SQLException e) {
		%>
		
		<script>alert("User not found in database. Please make sure you type in the correct email address or select the right account type. ")</script>
		
		<% 
		e.printStackTrace();
	}
	
	if (res.next()) {
		// send temp pwd
		email.sendEmail(2, emailInput.trim());
		String tempPwd = email.getTempPwd();
		
		ps = null;
		// update pwd for user in database
		if (accountTypeInput.trim().equals("Doctor")) {
			ps = con.prepareStatement("update doctors set doctor_password=? where doctor_email=?");
		} else if (accountTypeInput.trim().equals("Patient")) {
			ps = con.prepareStatement("update patients set patient_password=? where patient_email=?");
		} else {
		ps = con.prepareStatement("update insurance_providers set provider_password=? where provider_email=?");
		}
		ps.setString(1, tempPwd);
		ps.setString(2, emailInput.trim());
		
		try {
			ps.executeUpdate();
			String site = new String("loginForm.html");
			response.setStatus(response.SC_MOVED_TEMPORARILY);
		 	response.setHeader("Location", site);
		} catch (SQLException e) {
			%>
			
			<script>alert("User not found in database. Please make sure you type in the correct email address or select the right account type. ")</script>
			
			<% 
			e.printStackTrace();
		}
		
	} else {
		// user not found
		%>
		
		<script>alert("User not found in database. Please make sure you type in the correct email address or select the right account type. ")</script>
		
		<% 
	}
	
	//String site = new String("loginForm.html");
 	//response.setHeader("Location", site);
 	con.close();
%>

</body>
</html>