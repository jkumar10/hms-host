<%@ page import="java.sql.*,com.jndi.*" language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.awt.Toolkit"%>
<%@page import="javax.imageio.ImageIO"%>
<%@page import="javax.swing.ImageIcon"%>
<%@page import="java.awt.Image"%>
<%@page import="java.awt.image.BufferedImage"%>
<head>
	<title>Doctor Homepage</title>
	<meta charset="utf-8"/>
 <!-- CSS -->
    <!-- Font Awesome -->
    <link href="../style/fontawesome-all.min.css" rel="stylesheet" />
    <!-- Bootstrap core CSS -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.1.3/css/bootstrap.min.css" rel="stylesheet">
    <!-- Material Design Bootstrap -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/mdbootstrap/4.5.13/css/mdb.min.css" rel="stylesheet">
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
String fname;
ps=con.prepareStatement("Select doctor_first_name from doctors where doctor_email=?");
ps.setString(1, username.trim());
ResultSet res=ps.executeQuery();
if (res.next()==true)
{ fname=res.getString(1);



%>
	<!-- navbar -->  
	<nav class="navbar navbar-expand-lg fixed-top ">  
		<a class="navbar-brand" href="doctorHome.jsp"></a>
		<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">  
		<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse " id="navbarSupportedContent">
			<ul class="navbar-nav mr-4">
				<li class="nav-item">
				     <a class="nav-link" data-value="about" href="doctorHome.jsp">Home</a>
				</li>  
				  
				<li class="nav-item">  
				<li class="nav-item"> 
				    <a class="nav-link " data-value="providers" href="doctorInputTime.html">Schedule</a>
				</li> 
				   <a class="nav-link " data-value="team" href="doctorAppointments.html">My Appointments</a>
				</li>  
				<li class="nav-item"> 
				 <% out.println("<a class='nav-link' data-value='contact' href='#'>Welcome "+fname+"</a>");%>
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
	<!-- Posts section -->

		<div class="services" id="services">
			<div class="container">
			<h1 class="text-center">Our Services</h1>
				<div class="row">
					<div class="col-md-4 col-lg-4 col-sm-12">
						<div class="card">
							<div class="card-img">
								<img src="../pics/vet2.jpg" class="img-fluid">
							</div>
							
							<div class="card-body">
							<h4 class="card-title">Search Doctors</h4>
								<p class="card-text">
									
									Find vets with various specializations and book an appointment with them instantly.
								</p>
							</div>
							<div class="card-footer">
								<a href="scheduleAppointment.html" class="card-link">See more</a>
							</div>
						</div>
					</div>
					<div class="col-md-4 col-lg-4 col-sm-12">
						<div class="card">
							<div class="card-img">
								<img src="../pics/insurance.jpg" class="img-fluid">
							</div>
							
							<div class="card-body">
							   <h4 class="card-title">Insurance providers</h4>
								<p class="card-text">
									

									Pet insurance protects your four-legged family members.
								</p>
							</div>
							<div class="card-footer">
								<a href="" class="card-link">See more</a>
							</div>
						</div>
					</div>
					<div class="col-md-4 col-lg-4 col-sm-12">
						<div class="card">
							<div class="card-img">
								<img src="../pics/map.jpg" class="img-fluid">
							</div>
							
							<div class="card-body">
							<h4 class="card-title">Hospital Locator</h4>
								<p class="card-text">
									
									Wondering about nearby vets? They are just a click away.
								</p>
							</div>
							<div class="card-footer">
								<a href="" class="card-link">See more</a>
							</div>
						</div>
					</div>
				</div>
			</div>
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