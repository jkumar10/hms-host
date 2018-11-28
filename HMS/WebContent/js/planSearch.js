window.addEventListener("load", function() {
	// search by interest
	var planSearchForm = document.getElementById("PlanSearch");
	planSearchForm.addEventListener("submit", function(e) {
		e.preventDefault();
		
		var petTypeInput = planSearchForm.querySelector("*[name=pettype]");
		var petNameInput = planSearchForm.querySelector("*[name=petname]");
		var petGenderInput = planSearchForm.querySelector("*[name=petgender]");
		var deductibleInput = planSearchForm.querySelector("*[name=deductible]");
		var coverageInput = planSearchForm.querySelector("*[name=coverage]");
        
		
		var xhttp = new XMLHttpRequest();
		xhttp.onreadystatechange = function() {
			
			if(this.readyState == 4 && this.status == 200) {
				// insert html page into this page
				var planTableElement = document.getElementById("PlanTable");
				planTableElement.innerHTML = this.responseText;
				var radioGroup = planTableElement.querySelector(".radio-group");
                setupDivRadio(radioGroup);
			}
		};
		
		xhttp.open("POST", "searchPlansUpdate.jsp", true);
		xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
		var inputStr = "pettype="+petTypeInput.value+"&petname="+petNameInput.value+"&petgender="+petGenderInput.value+"&deductible="+deductibleInput.value;
		inputStr += "&coverage=" + coverageInput.value;
		console.log(inputStr);
		xhttp.send(inputStr);
		
		return false;
	});
	
	// select plan
	var planForm = document.getElementById("PlanForm");
	planForm.addEventListener(submit, function(e) {
		e.preventDefault();

		var plan_id = planForm.querySelector("*[name=plan_id]");
		var patient_id = planForm.querySelector("*[name=patient_id]");
		var petname = planForm.querySelector("*[name=petname]");

		var xhttp = new XMLHttpRequest();
		xhttp.open("POST", "selectPlans.jsp", true);
		xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
		var inputStr = "plan_id=" + plan_id.value + "&patient_id=" + patient_id.value + "&petname=" + petname.value;
		console.log(inputStr);
		xhttp.send(inputStr);

		return false;
	})
});