window.addEventListener("load", function() {
    var doctorSearchForm = document.getElementById("DoctorSearch2");
    doctorSearchForm.addEventListener("submit", function(e) {
    	e.preventDefault()
    	
        var petTypeInput = doctorSearchForm.querySelector("*[name=pettype]");
        var specialisationInput = doctorSearchForm.querySelector("*[name=specialisation]");

        
        var xhttp = new XMLHttpRequest();
        xhttp.onreadystatechange = function() {
        	
            if(this.readyState == 4 && this.status == 200) {
                //Insert raw html table into this page
                var doctorTableElement = document.getElementById("DoctorTableSearch");
            	doctorTableElement.innerHTML = this.responseText;
                var radioGroup = doctorTableElement.querySelector(".radio-group");
                setupDivRadio(radioGroup);
            }
        };

        xhttp.open("POST", "doctorTableSearch.jsp", true);
        //Tell that post inputs are coming then send them
        xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
        var inputStr = "pettype="+ petTypeInput.value +"&specialisation="+specialisationInput.value;
        console.log(inputStr);
        xhttp.send(inputStr);
        
        return false;
    });
});