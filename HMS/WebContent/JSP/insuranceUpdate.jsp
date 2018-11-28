<%@ page import="com.justice.HttpHelper,org.json.simple.JSONObject,org.json.simple.parser.JSONParser,java.sql.*,com.jndi.*" language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">

    <!-- CSS -->
    <!-- Font Awesome -->
    <link rel="stylesheet" href="../style/fontawesome-all.min.css" />
    <!-- Bootstrap core CSS -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.1.3/css/bootstrap.min.css" rel="stylesheet">
    <!-- Material Design Bootstrap -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/mdbootstrap/4.5.13/css/mdb.min.css" rel="stylesheet">
    <!-- Changes to mdbootstrap -->
   <link href="../style/mdbootstrap_rework2.css" rel="stylesheet">
    
    
    
    
    
    
  <link rel="stylesheet" type="text/css" href="../style/main_new.css">
  <link rel="stylesheet" type="text/css" href="../style/customer.css">
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
    <main>
    	<div class="container p-0">
		<div class="row" style="padding-top:130px">
			<div class="col-12">
				<div id="InsuranceProviderTable"></div>
			</div>
		</div>
		<div class="row">
			  <div class="col-2"></div>
			  <div class="col-8">
			  	  <div id="SubmitInsuranceFormBtn" style="padding-bottom:120px">
				   <input type="button" class="btn btn-block btn-primary btn-lg" value="Choose" />
				  </div>
			  </div>
		</div>
	</div>
    </main>

    <!-- JAVASCRIPT -->
    <!-- JQuery -->
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <!-- Bootstrap tooltips -->
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.4/umd/popper.min.js"></script>
    <!-- Bootstrap core JavaScript -->
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.1.3/js/bootstrap.min.js"></script>
    <!-- MDB core JavaScript -->
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/mdbootstrap/4.5.13/js/mdb.min.js"></script>

    <!-- Load React. and Babel transpiler for jsx -->
    <script crossorigin src="https://unpkg.com/react@16/umd/react.development.js"></script>
    <script crossorigin src="https://unpkg.com/react-dom@16/umd/react-dom.development.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/babel-standalone/6.21.1/babel.min.js"></script>
    <!-- Load my React component. -->
    <script src="../js/easyPost.js"></script>
    <script charset="utf-8" type="text/babel" src="../js/react_components/filterableTable.js"></script>

    <!-- script specific to this page -->
    <script type="text/javascript">
    var clickedRowObj = null;

	console.log($("#SubmitInsuranceFormBtn").length);

    $(".container").on("click", "#SubmitInsuranceFormBtn", function(e) {
    	console.log("Got inside");
		if(clickedRowObj == null) return; //TODO: ADD MESSAGE TELLING USER TO SELECT A ROW

		console.log("form submit started");
    	//Create a form from json and submits it
        var form = document.createElement("FORM");
        form.style.display = "none";
	    form.method = "POST";
	    form.action = "selectInsurancePlan.jsp";
        Object.keys(clickedRowObj).forEach((key) => {
        	var input = document.createElement("INPUT");
        	input.type = "text";
        	input.name = key;
        	input.value = clickedRowObj[key];

        	form.appendChild(input);
        });
					
        console.log("Pre-jsp");
        //Pet type and pet name pass thru
        var petTypeInput = document.createElement("INPUT");
        petTypeInput.type = "text";
        petTypeInput.name = "pettype";
        petTypeInput.value = "<%= request.getParameter("pettype") %>";
        form.appendChild(petTypeInput);
        var petNameInput = document.createElement("INPUT");
        petNameInput.type = "text";
        petNameInput.name = "petname";
        petNameInput.value = "<%= request.getParameter("petname") %>";
		form.appendChild(petNameInput);
        
        document.body.appendChild(form);
        form.submit();
        console.log("After form submitted");
        
    }); 
    </script>
    <script type="text/babel">
        asyncPostPage("PublicTables.jsp", "table=insurance_plans", function(responseJson) {
            const data = JSON.parse(responseJson);
            const columns = [
	    	{ name: "provider_name",   displayName: "Provider",    exactFilter: true},
            { name: "plan_name",       displayName: "Plan"},
	    	{ name: "plan_coverage",   displayName: "Coverage",    csvExactFilter: true, forceSpaceAfterComma: true},
	    	{ name: "plan_premium",	   displayName: "Premium",     minMaxFilter: true, render: (columnData) => (<p className="text-center">{"$"+columnData}</p>)},
			{ name: "plan_deduction",  displayName: "Deductible",  minMaxFilter: true, render: (columnData) => (<p className="text-center">{"$"+columnData}</p>)},
			{ name: "pet_type", 	   displayName: "Pet Covered", exactFilter: true, render: (columnData) => (<p className="text-center">{columnData}</p>)}
            ];

            ReactDOM.render(
                <FilterableTable
                    id="ReactInsuranceProviderTable" 
                    data={data} 
                    columns={columns}
                    onRowSelected={(rowObj) => {
						console.log("row clicked");
						clickedRowObj = rowObj;
                    }} />,
                document.getElementById("InsuranceProviderTable")
            );
        });
    </script>
    
    
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




</body>
</html>

