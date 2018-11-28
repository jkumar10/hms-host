<%@ page import="java.sql.*,com.jndi.*" language="java" contentType="text/html; charset=UTF-8" session="true" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Your One-Time Password</title>
 <link rel="stylesheet" type="text/css" href="../style/reset.css">
  <link rel="stylesheet" type="text/css" href="../style/main.css">
  <link rel="stylesheet" type="text/css" href="../style/account-selector.css">
  <link rel="stylesheet" type="text/css" href="../style/div-radio.css">
  <link rel="stylesheet" type="text/css" href="../style/clear-fix.css">
</head>
<body>
<%
	DataAccessLayer ob = new DataAccessLayer();
	Connection con = null;
	try {
		con = ob.getConnection();
		String otpInput = request.getParameter("otpInput");
		String emailInput = (String) session.getAttribute("username");
		String accountTypeInput = (String) session.getAttribute("accountTypeInput");
		String otpValue = (String) session.getAttribute("otpValue");
		int uid = -1;
		String site = null;

		System.out.println("OTP INPUT: " + otpInput);
		System.out.println("OTP Value: " + otpValue);
	
		if(otpInput.equals(otpValue) && accountTypeInput.trim().equals("Patient")) {
			site = new String("patientHome.jsp");
			PreparedStatement ps = con.prepareStatement("select patient_id from patients where patient_email=?");
			ps.setString(1, emailInput);
			ResultSet rs = ps.executeQuery();
			
			if (rs.next()) {
				uid = rs.getInt("PATIENT_ID");
			} else {
				System.out.println("No paitent id selected. Something is wrong. Please check the database. ");
			}
		} else if(otpInput.equals(otpValue) && accountTypeInput.trim().equals("Doctor")) {
			site = new String("doctorHome.jsp");
			PreparedStatement ps = con.prepareStatement("select doctor_id from doctors where doctor_email=?");
			ps.setString(1, emailInput);
			ResultSet rs = ps.executeQuery();
			
			if (rs.next()) {
				uid = rs.getInt("DOCTOR_ID");
			} else {
				System.out.println("No doctor id selected. Something is wrong. Please check the database. ");
			}
		} else if (otpInput.equals(otpValue) && accountTypeInput.trim().equals("Insurance Provider")) {
			site = new String("providerHome.jsp");
			PreparedStatement ps = con.prepareStatement("select provider_id from insurance_providers where provider_email=?");
			ps.setString(1, emailInput);
	 		ResultSet rs = ps.executeQuery();
		   
	 		if (rs.next()) {
	 			uid = rs.getInt("PROVIDER_ID");
	 		} else {
	 			System.out.println("No provider id selected. Something is wrong. Please check the database. ");
	 		}
		} else {
 	   		out.println("<script>alert(\"Invalid one-time password\");window.location.href=\"http://localhost:8080/HMS/JSP/loginForm.html\";</script>");
 	    }
		
		session.setAttribute("username",emailInput);
		session.setAttribute("accountTypeInput",accountTypeInput);
		session.setAttribute("userId", uid);
		response.setStatus(response.SC_MOVED_TEMPORARILY);
		response.setHeader("Location", site);
	} catch (SQLException e) {
		e.printStackTrace();
	} finally {
		if (con!=null) {
			try {
				con.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		} 
	}
%>

</body>
</html>

