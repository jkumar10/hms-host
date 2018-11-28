<%@ page import="java.sql.*,com.jndi.*" language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Provider's Patients</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
<link rel="stylesheet" type="text/css" href="../style/main_new.css">
</head>
<body>

<%
try
{
DataAccessLayer ob=new DataAccessLayer();
Connection con = ob.getConnection();
String username = (String) session.getAttribute("username");
PreparedStatement ps;
String pname;
ps=con.prepareStatement("Select provider_name from insurance_providers where provider_email=?");
ps.setString(1, username.trim());
ResultSet res=ps.executeQuery();
if (res.next()==true)
{ pname=res.getString(1);

%>

	<!-- navbar -->  
	<nav class="navbar navbar-expand-lg fixed-top ">  
		<a class="navbar-brand" href="providerHome.jsp"></a>
		<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">  
		<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse " id="navbarSupportedContent">
			<ul class="navbar-nav mr-4">
				<li class="nav-item">
				     <a class="nav-link" data-value="about" href="providerHome.jsp">Home</a>
				</li>  
				
				<li class="nav-item"> 
				    <a class="nav-link " data-value="providers" href="providerDoctors.jsp">My Doctors</a>
				</li>   
				<li class="nav-item">  
				<!-- TODO -->
				   <a class="nav-link " data-value="team" href="providerPatients.jsp">My Patients</a>
				</li>  
				<li class="nav-item"> 
				<% out.println("<a class='nav-link' data-value='contact' href='#'>Welcome "+pname+"</a>");%>
				</li> 
				<li class="nav-item">  
				   <a class="nav-link " data-value="team" href="logout.jsp">Sign out</a>
				</li> 
			</ul> 
		</div>
	</nav>

<%}

	int providerId = (int) session.getAttribute("userId");
	PreparedStatement pspp = con.prepareStatement("select * from patient_plan where provider_id=?");
	pspp.setInt(1, providerId);
	ResultSet rspp = pspp.executeQuery();
	
	if(rspp.next()) {
		int i = 0;
		rspp.previous();
%>

	<div class="container" style="padding-top:200px;">
	<h3>Registered Patients</h3><br><br>
	<table class="table table-bordered table-hover" >
 	 <thead style="background:#3399ff; color:#fff">
      <tr>
       <th scope="col">#</th>
       <th scope="col">Patient Name</th>
       <th scope="col">Plan Name</th>
       <th scope="col">Pet Name</th>
       <th scope="col">Pet Type</th>
      </tr>
     </thead>
     <tbody>
<%		
		
		while(rspp.next()) {
			String petname = rspp.getString("PETNAME");
			String pettype = rspp.getString("PETTYPE");
			String plan_name = rspp.getString("PLAN_NAME");
			
			PreparedStatement psInfo = con.prepareStatement("select * from patients where patient_id=?");
			psInfo.setInt(1, rspp.getInt("PATIENT_ID"));
			ResultSet rsInfo = psInfo.executeQuery();
			
			
			if(rsInfo.next()) {
				String pfname = rsInfo.getString("PATIENT_FIRSTNAME");
				String plname = rsInfo.getString("PATIENT_LASTNAME");
				
%>
	  <tr>
	   <th scope="row"> <% out.println(++i); %></th>
	    <td> <% out.println(pfname + " " + plname); %> </td>
	    <td> <% out.println(plan_name); %> </td>
	    <td> <% out.println(petname); %> </td>
	    <td> <% out.println(pettype); %>
	  </tr>

<%
				
			}
		}
%>

	</tbody>
	</table>
	</div>
	
<%
	}
	
	con.close();

}
catch(Exception e)
{
	e.printStackTrace();
}%>

    
		<div style="padding-top:200px;">
		</div>
		<!-- Footer -->
		<footer class="page-footer font-small blue pt-4" style="color: #fff; background-color: #1E88E5;">

		    <!-- Footer Links -->
		    <div class="container-fluid text-center text-md-left">

		      <!-- Grid row -->
		      <div class="row">

		        <!-- Grid column -->
		        <div class="col-md-6 mt-md-0 mt-3">

		          <!-- Content -->
		          <h5 class="text-uppercase">Contact Us</h5>
		          <p>115 N. Smith Rd.</p>
		          <p>Bloomington, Indiana,</p>
		          <p>47408</p>

		        </div>
		        <!-- Grid column -->

		        <hr class="clearfix w-100 d-md-none pb-3">

		        <!-- Grid column -->
		        <div class="col-md-3 mb-md-0 mb-3">

		            <!-- Links -->
		            <h5 class="text-uppercase">Browse</h5>

		            <ul class="list-unstyled">
		              <li>
		                <a href="visitorHome.html" style="color:#fff">Home</a>
		              </li>
		              <li>
		                <a href="visitorAbout.html" style="color:#fff">About Us</a>
		              </li>
		             
		            </ul>

		          </div>
		          <!-- Grid column -->

		          <!-- Grid column -->
		          <div class="col-md-3 mb-md-0 mb-3">

		            <!-- Links -->
		            <h5 class="text-uppercase">Register for free</h5>

		            <ul class="list-unstyled">
		              <li>
		                <a href="loginForm.html" class="btn btn-danger btn-rounded">Sign up!</a>
		              </li>

		              
		            </ul>

		          </div>
		          <!-- Grid column -->

		      </div>
		      <!-- Grid row -->

		    </div>
		    <!-- Footer Links -->

		    <!-- Copyright -->
		    <div class="footer-copyright text-center py-3"><p>Only for educational purpose. All images are Copyright © 2018 The Pet Hospitals</p>
		     <!-- <a href="https://mdbootstrap.com/education/bootstrap/" style="color:#fff"> Vetpet.com</a>-->
		    </div>
		    <!-- Copyright -->

		  </footer>
		  <!-- Footer -->



<!-- add Javasscript file from js file -->
<script type="text/javascript" src="../js/jquery.min.js"></script>
<script type="text/javascript" src="../js/bootstrap.min.js"></script>
<script type="text/javascript" src='../js/main.js'></script>

</body>
</html>