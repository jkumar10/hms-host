window.addEventListener("load", function() {
    var doctorSearchForm = document.getElementById("DoctorSearch");
    doctorSearchForm.addEventListener("submit", function(e) {
    	e.preventDefault()
    	
        var petTypeInput = doctorSearchForm.querySelector("*[name=pettype]");
        var specialisationInput = doctorSearchForm.querySelector("*[name=specialisation]");

        
        var xhttp = new XMLHttpRequest();
        xhttp.onreadystatechange = function() {
        	
            if(this.readyState == 4 && this.status == 200) {
                //Insert raw html table into this page
                var doctorTableElement = document.getElementById("DoctorTable");
            	doctorTableElement.innerHTML = this.responseText;
                var radioGroup = doctorTableElement.querySelector(".radio-group");
                setupDivRadio(radioGroup);
            }
        };

        xhttp.open("POST", "doctorTable.jsp", true);
        //Tell that post inputs are coming then send them
        xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
        var inputStr = "pettype="+ petTypeInput.value +"&specialisation="+specialisationInput.value;
        console.log(inputStr);
        xhttp.send(inputStr);
        
        return false;
    });
    
    var timeSlotForm = document.getElementById("TimeSlotForm");
    timeSlotForm.addEventListener("submit", function(e) {
    	e.preventDefault()
    	
        var doctorIdInput = timeSlotForm.querySelector("*[name=doctor_id]");
        var dateInput = timeSlotForm.querySelector("*[name=date]");

        
        var xhttp = new XMLHttpRequest();
        xhttp.onreadystatechange = function() {
        	
            if(this.readyState == 4 && this.status == 200) {
                //Insert raw html table into this page
                /*var doctorTableElement = document.getElementById("DoctorTable");
            	doctorTableElement.innerHTML = this.responseText;
                var radioGroup = doctorTableElement.querySelector(".radio-group");
                setupDivRadio(radioGroup);*/
            	
            	var timeSlotTableElement = document.getElementById("TimeSlotTable");
            	timeSlotTableElement.innerHTML = this.responseText;
            	
            	//make a submit button
            	var submitBtn = document.createElement("input");
            	submitBtn.type = "submit";
            	submitBtn.value = "Book";
            	submitBtn.style.position = "relative";
            	submitBtn.style.left = "300px";
            	submitBtn.style.top = "120px";
            	submitBtn.style.background = "#3498DB";
            	submitBtn.style.color = "white";
            	submitBtn.style.padding = "8px 10px";
            	submitBtn.style.display = "inline-block";
            	submitBtn.style.border = "none";
            	submitBtn.style.margin = "4px 2px";
            	submitBtn.style.margin = "inline-block";
            	submitBtn.style.borderRadius = "8px";
            	timeSlotTableElement.appendChild(submitBtn);
            	
            	var timeSlotRadioGroup = document.getElementById("TimeSlotRadioGroup");
            	setupDivRadio(timeSlotRadioGroup);
            }
        };

        xhttp.open("POST", "TimeSlots.jsp", true);
        //Tell that post inputs are coming then send them
        xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
        //var inputStr = "pettype="+ petTypeInput.value +"&specialisation="+specialisationInput.value;
        var inputStr = "doctor_id="+doctorIdInput.value + "&date=" + dateInput.value;
        console.log(inputStr);
        xhttp.send(inputStr);
        
        return false;    	
    });
});