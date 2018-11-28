window.addEventListener("load", function() {
    var ratingForm = document.getElementById("rating");
    ratingForm.addEventListener("submit", function(e) {
    	e.preventDefault()
    	
        var ratingInput = doctorSearchForm.querySelector("*[name=rating]");
        
        var xhttp = new XMLHttpRequest();
        xhttp.onreadystatechange = function() {
        	
            if(this.readyState == 4 && this.status == 200) {
                //Insert raw html table into this page
                var ratingElement = document.getElementById("ratingUpdate");
            	doctorTableElement.innerHTML = this.responseText;
      
            }
        };

        xhttp.open("POST", "ratingUpdate.jsp", true);
        //Tell that post inputs are coming then send them
        xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
        var inputStr = "pettype="+ petTypeInput.value +"&specialisation="+specialisationInput.value;
        console.log(inputStr);
        xhttp.send(inputStr);
        
        return false;
    });
});