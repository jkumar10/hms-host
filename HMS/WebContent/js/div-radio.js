function setupDivRadio(radioGroup) {
    var input = radioGroup.querySelector(".radio-input");
    var selectedRadio = null;

    var radioButtons = radioGroup.querySelectorAll(".radio-group .radio");
    console.log(radioButtons);
    for(var j = 0; j < radioButtons.length; j++) {
        var radioButton = radioButtons[j];
        
        //onclick change the selected view to the clicked view
        radioButton.addEventListener("click", function() {
            //Remove selected class from all elements in the same radio group
            if(selectedRadio != null) {
                selectedRadio.classList.remove("selected");
            }
            //Add selected to the clicked element
            this.classList.add("selected");  
            selectedRadio = this;  

            //Find the input for the radio-group and assign it the value of the radio
            input.value = this.dataset.radio_value;
        });
    }
}

window.addEventListener("load", function() {
    //Ensures that only one element of a radio-group is selected at any given time
    var radioGroups = document.querySelectorAll(".radio-group");
    for(var i = 0; i < radioGroups.length; i++) {
        var radioGroup = radioGroups[i];
        setupDivRadio(radioGroup);
    }
});