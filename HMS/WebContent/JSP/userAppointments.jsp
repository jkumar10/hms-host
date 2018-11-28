<%@ page import="java.sql.*,com.jndi.*" language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.awt.Toolkit"%>
<%@page import="javax.imageio.ImageIO"%>
<%@page import="javax.swing.ImageIcon"%>
<%@page import="java.awt.Image"%>
<%@page import="java.awt.image.BufferedImage"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">

   <!-- Font Awesome -->
    <link href="../style/fontawesome-all.min.css" rel="stylesheet" />
    <!-- Bootstrap core CSS -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.1.3/css/bootstrap.min.css" rel="stylesheet">
    <!-- Material Design Bootstrap -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/mdbootstrap/4.5.13/css/mdb.min.css" rel="stylesheet">


  <link rel="stylesheet" type="text/css" href="../style/stars.css">
  <!--  <link rel="stylesheet" type="text/css" href="../style/subpage.css">-->
  <link rel="stylesheet" type="text/css" href="../style/userAppointments.css">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
	<link rel="stylesheet" type="text/css" href="../style/main_new.css">
  
  <!--  <link rel="stylesheet" type="text/css" href="../style/themes.css">-->
  <script src="../js/cookies.js"></script>
  <script src="../js/themes.js"></script>
  <script src="../js/div-radio.js"></script>
  
  <!-- Start of LiveChat (www.livechatinc.com) code -->
<script type="text/javascript">
window.__lc = window.__lc || {};
window.__lc.license = 10278297;
(function() {
  var lc = document.createElement('script'); lc.type = 'text/javascript'; lc.async = true;
  lc.src = ('https:' == document.location.protocol ? 'https://' : 'http://') + 'cdn.livechatinc.com/tracking.js';
  var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(lc, s);
})();
</script>
<!-- End of LiveChat code -->
</head>
<body>

     
	<!-- navbar -->  
	<nav class="navbar navbar-expand-lg fixed-top ">  
		<a class="navbar-brand" href="patientHome.jsp"></a>
		<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">  
		<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse " id="navbarSupportedContent">
			<ul class="navbar-nav mr-4">
				<li class="nav-item">
				     <a class="nav-link" data-value="about" href="patientHome.jsp">Home</a>
				</li>  
				<li class="nav-item"> 
				 <a class="nav-link " data-value="hospitals" href="patientHospitals.html">Hospitals</a>
				</li>
				<li class="nav-item">
				    <a class="nav-link " data-value="doctors" href="scheduleAppointment.html">Search Doctor</a>    
				</li>
				<li class="nav-item"> 
				    <a class="nav-link " data-value="providers" href="insurance.html">Insurance Providers</a>
				</li>   
				<li class="nav-item">  
				   <a class="nav-link " data-value="team" href="userAppointments.jsp">My Appointments</a>
				</li>  
				
				<li class="nav-item">  
				   <a class="nav-link " data-value="team" href="logout.jsp">Sign out</a>
				</li> 
			</ul> 
		</div>
	</nav>
	
<div style="padding-top:100px; padding-left:300px;">
<h3>Your appointments</h3>
</div>
<%
try
{
DataAccessLayer ob=new DataAccessLayer();
Connection con = ob.getConnection();
String username = (String) session.getAttribute("username");
//String username="jainendrakumar10@gmail.com";
PreparedStatement ps;
ps=con.prepareStatement("SELECT doctors.doctor_id, book.date, doctors.doctor_first_name, doctors.doctor_last_name, book.start_time from doctors INNER JOIN book ON doctors.doctor_id=book.doctor_id WHERE pid=?");
ps.setString(1, username.trim());
ResultSet res=ps.executeQuery();
if (res.next()==true)
{
//String doctor_id=res.getString(2);

out.println("<form action='ratingUpdate.jsp' id='feedbackForm'>");
out.println("<div class='radio-group'>");
out.println("<table id='customers'>");
out.println("<th style='display:none;'>Doctor ID</th>");
out.println("<th><img src='../pics/dateicon.png' alt='' width='50' height='50'>&nbsp;&nbsp;Date</th>");
out.println("<th><img src='../pics/docicon.png' alt='' width='50' height='50'>&nbsp;&nbsp;Doctor Name</th>");
out.println("<th><img src='../pics/timeicon.png' alt='' width='40' height='40'>&nbsp;&nbsp;Appointment Time</th>");
res.previous();
while (res.next()==true)
{
out.println("<tr class='radio' data-radio_value='" + res.getString(1) +"'>");
out.println("<td style='display:none;' class='non-selectable'>"+res.getString(1)+"</td>");
out.println("<td class='non-selectable'>"+res.getString(2)+"</td>");
out.println("<td class='non-selectable'>Dr."+res.getString(3)+" "+res.getString(4)+"</td>");
out.println("<td class='non-selectable'>"+res.getString(5)+"</td>");
out.println("</tr>");
}
out.println("</table>");

out.println("<input style='display:none;' name='doctor_id' type='text' class='radio-input'");
out.println("</div>");

con.close();
}
else
{%>
echo ("<script>
alert("You don't have any appointments. Please book an appointment first.");
window.location.href='http://localhost:8080/HMS/JSP/scheduleAppointment.html';
</script>");
<%}
}
catch(Exception e)
{
	e.printStackTrace();
}

%>

<div class="star">
<br><br>
	<h3>Give rating for your appointment:</h3>
<fieldset class="rating">
    <input type="radio" id="star5" name="rating" value="5" /><label class = "full" for="star5" title="Awesome - 5 stars"></label>
    <input type="radio" id="star4half" name="rating" value="4.5" /><label class="half" for="star4half" title="Pretty good - 4.5 stars"></label>
    <input type="radio" id="star4" name="rating" value="4" /><label class = "full" for="star4" title="Pretty good - 4 stars"></label>
    <input type="radio" id="star3half" name="rating" value="3.5" /><label class="half" for="star3half" title="Meh - 3.5 stars"></label>
    <input type="radio" id="star3" name="rating" value="3" /><label class = "full" for="star3" title="Meh - 3 stars"></label>
    <input type="radio" id="star2half" name="rating" value="2.5" /><label class="half" for="star2half" title="Kinda bad - 2.5 stars"></label>
    <input type="radio" id="star2" name="rating" value="2" /><label class = "full" for="star2" title="Kinda bad - 2 stars"></label>
    <input type="radio" id="star1half" name="rating" value="1.5" /><label class="half" for="star1half" title="Meh - 1.5 stars"></label>
    <input type="radio" id="star1" name="rating" value="1" /><label class = "full" for="star1" title="Sucks big time - 1 star"></label>
    <input type="radio" id="starhalf" name="rating" value="0.5" /><label class="half" for="starhalf" title="Sucks big time - 0.5 stars"></label>
</fieldset>
<br><br><br>
<input type="submit" value="Submit" class="button"><br><br><br><br><br>
<!--</form>  -->

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
		                <a href="patientHome.html" style="color:#fff">Home</a>
		              </li>
		              <li>
		                <a href="patientAbout.html" style="color:#fff">About Us</a>
		              </li>
		              <li>
		                <a href="scheduleAppointment.html" style="color:#fff">Search Doctors</a>
		              </li>
		              <li>
		                <a href="userAppointments.jsp" style="color:#fff">My Appointments</a>
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
		    <div class="footer-copyright text-center py-3"><p>Designed with &#9829; just for you.</p>
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
 