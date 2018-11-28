<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
	<link rel="stylesheet" type="text/css" href="../style/main_new.css">
<style>
body {
  font-family: Arial;
  font-size: 17px;
  padding: 8px;
}

* {
  box-sizing: border-box;
}

.row {
  display: -ms-flexbox; /* IE10 */
  display: flex;
  -ms-flex-wrap: wrap; /* IE10 */
  flex-wrap: wrap;
  margin: 0 -16px;
  padding-top: 100px;
  padding-bottom: 0px;
}

.col-25 {
  -ms-flex: 25%; /* IE10 */
  flex: 25%;
}

.col-50 {
  -ms-flex: 50%; /* IE10 */
  flex: 50%;
}

.col-75 {
  -ms-flex: 75%; /* IE10 */
  flex: 75%;
}

.col-25,
.col-50,
.col-75 {
  padding: 0 16px;
}

.container {
  background-color: #f2f2f2;
  padding: 5px 20px 15px 20px;
  border: 1px solid lightgrey;
  border-radius: 3px;
}

input[type=text] {
  width: 100%;
  margin-bottom: 20px;
  padding: 12px;
  border: 1px solid #ccc;
  border-radius: 3px;
}

label {
  margin-bottom: 10px;
  display: block;
}

.icon-container {
  margin-bottom: 20px;
  padding: 7px 0;
  font-size: 24px;
}

.btn {
  background-color: #1E88E5;
  color: white;
  padding: 12px;
  margin: 10px 0;
  border: none;
  width: 100%;
  border-radius: 3px;
  cursor: pointer;
  font-size: 17px;
}

.btn:hover {
  background-color: #45a049;
}

a {
  color: #2196F3;
}

hr {
  border: 1px solid lightgrey;
}

span.price {
  float: right;
  color: grey;
}

/* Responsive layout - when the screen is less than 800px wide, make the two columns stack on top of each other instead of next to each other (also change the direction - make the "cart" column go on top) */
@media (max-width: 800px) {
  .row {
    flex-direction: column-reverse;
  }
  .col-25 {
    margin-bottom: 20px;
  }
}
</style>
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
				    <a class="nav-link " data-value="doctors" href="scheduleAppointment.html">Doctors</a>    
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


<div class="row">
  <div class="col-75">
    <div class="container">
      <form action="/action_page.php">
      
        <div class="row">
          <div class="col-50">
            <h3>Billing Address</h3>
            <label for="fname"><i class="fa fa-user"></i> Full Name</label>
            <input type="text" id="fname" name="firstname" placeholder="John M. Doe">
            <label for="email"><i class="fa fa-envelope"></i> Email</label>
            <input type="text" id="email" name="email" placeholder="john@example.com">
            <label for="adr"><i class="fa fa-address-card-o"></i> Address</label>
            <input type="text" id="adr" name="address" placeholder="542 W. 15th Street">
            <label for="city"><i class="fa fa-institution"></i> City</label>
            <input type="text" id="city" name="city" placeholder="New York">

            <div class="row">
              <div class="col-50">
                <label for="state">State</label>
                <input type="text" id="state" name="state" placeholder="NY">
              </div>
              <div class="col-50">
                <label for="zip">Zip</label>
                <input type="text" id="zip" name="zip" placeholder="10001">
              </div>
            </div>
          </div>

          <div class="col-50">
            <h3>Payment</h3>
            <label for="fname">Accepted Cards</label>
            <div class="icon-container">
              <i class="fa fa-cc-visa" style="color:navy;"></i>
              <i class="fa fa-cc-amex" style="color:blue;"></i>
              <i class="fa fa-cc-mastercard" style="color:red;"></i>
              <i class="fa fa-cc-discover" style="color:orange;"></i>
            </div>
            <label for="cname">Name on Card</label>
            <input type="text" id="cname" name="cardname" placeholder="John More Doe">
            <label for="ccnum">Credit card number</label>
            <input type="text" id="ccnum" name="cardnumber" placeholder="1111-2222-3333-4444">
            <label for="expmonth">Exp Month</label>
            <input type="text" id="expmonth" name="expmonth" placeholder="September">
            <div class="row">
              <div class="col-50">
                <label for="expyear">Exp Year</label>
                <input type="text" id="expyear" name="expyear" placeholder="2018">
              </div>
              <div class="col-50">
                <label for="cvv">CVV</label>
                <input type="text" id="cvv" name="cvv" placeholder="352">
              </div>
            </div>
          </div>
          
        </div>
        <label>
          <input type="checkbox" checked="checked" name="sameadr"> Shipping address same as billing
        </label>
        <input type="submit" value="Continue to checkout" class="btn">
      </form>
    </div>
  </div>
  <div class="col-25">
    <div class="container">
      <h4>Cart <span class="price" style="color:black"><i class="fa fa-shopping-cart"></i> <b>1</b></span></h4>
      <p><a href="#">Insurance Plan</a> <span class="price">$500</span></p>
      <!--  <p><a href="#">Product 2</a> <span class="price">$5</span></p>
      <p><a href="#">Product 3</a> <span class="price">$8</span></p>
      <p><a href="#">Product 4</a> <span class="price">$2</span></p>-->
      <hr>
      <p>Total <span class="price" style="color:black"><b>$500</b></span></p>
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
    