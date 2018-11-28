<%@ page import="java.sql.*,com.jndi.*" language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insurance Provider Homepage</title>
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
}
catch(Exception e)
{
	e.printStackTrace();
}%>


<img src="../pics/img2 - Copy.JPG" alt="Trulli" height=100% width=100%>
	
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