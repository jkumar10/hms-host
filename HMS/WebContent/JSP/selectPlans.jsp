<%@ page import="java.sql.*,com.jndi.*" language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Select Plan</title>
</head>
<body>
<%
	// connect to db and get input paramters
	DataAccessLayer ob = new DataAccessLayer();
	Connection con = ob.getConnection();
	String emailInput = (String) session.getAttribute("username"); 
	String petName = request.getParameter("petname"); // to be changed 'petname'
	String plan_id = request.getParameter("plan_id");
	String patient_id = request.getParameter("patient_id");
	
	// insert into paitent_plan table
	PreparedStatement ps = con.prepareStatement("insert into patient_plan (patient_id, plan_id) values (?,?)");
	ps.setString(1, patient_id);
	ps.setString(2, plan_id);
	int count = ps.executeUpdate();
	
	// check if update successful
	if (count>0) {
%>
		<!-- pop a window showing plan successfully chosen -->
		<script>window.alert("Congratulations! You have successfully chosen the plan! ")</script>	
<%

		// send email confirmation to patients
		PreparedStatement psip = con.prepareStatement("select * from insurance_plans where plan_id=?");
		psip.setString(1, plan_id);
	
		ResultSet rs = psip.executeQuery();
		if(rs.next()) {
			String providerName = rs.getString("PROVIDER_NAME");
			String planName = rs.getString("PLAN_NAME");
			SendEmail email = new SendEmail();
			email.sendPlanConfirm(emailInput, providerName, planName, petName);
		}
	} else {
%>
		<!-- pop a window showing plan not chosen -->
		<script>window.alert("Sorry, something went wrong when choosing the plan. ")</script>
<%
	}
	
%>

</body>
</html>