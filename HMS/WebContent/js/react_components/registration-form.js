class RegistrationForm extends React.Component {
    constructor(props) {
        super(props);

        this.registrationFormRef = React.createRef();
    }

    clearAllErrors() {
        var formElem = this.registrationFormRef.current;
        //Clear all error messages
        var formInputs = formElem.querySelectorAll("input");
        formInputs.forEach(elem => {
            var labelElem = elem.parentElement.querySelector("label");
            if(labelElem) {
                elem.classList.remove("invalid");
                labelElem.dataset.error = "";
            }
        });
    }

    insertErrorMessage(elem, errorMsg) {
        var formElem = this.registrationFormRef.current;

        var labelElem = elem.parentElement.querySelector("label");
        if(labelElem) {
            elem.classList.add("validate", "invalid");
            elem.value = ""; //If the value is wrong it shouldn't be kept
            labelElem.classList.remove("active"); // so it destyles

            elem.addEventListener("click", function(e) { //Allows for clearing single errors
                labelElem.dataset.error = "";
                elem.classList.remove("validate", "invalid");
            });

            if(labelElem.dataset.error)
                labelElem.dataset.error += errorMsg;
            else
                labelElem.dataset.error = errorMsg;
        }
    }

    checkFormFilled() {
        var formElem = this.registrationFormRef.current;

        //Clear error message
        this.clearAllErrors();

        var errorOccured = false;
        //Check each element and draw new error messages
        var firstNameInput = formElem.querySelector("#firstNameInput");
        var lastNameInput = formElem.querySelector("#lastNameInput");
        var emailInput = formElem.querySelector("#emailInput");
        var passwordInput = formElem.querySelector("#passwordInput");
        var passwordConfirmationInput = formElem.querySelector("#passwordConfirmationInput");
        var addressInput = formElem.querySelector("#addressInput");

        var petInput = formElem.querySelector("#petInput");
        var specialisationInput = formElem.querySelector("#specialisationInput");
        var companyNameInput = formElem.querySelector("#companyNameInput");
        
        if(firstNameInput.value == "") {
            this.insertErrorMessage(firstNameInput, "First name field is blank");
            errorOccured = true;
        }
        if(lastNameInput.value == "") {
            this.insertErrorMessage(lastNameInput, "Last name field is blank");
            errorOccured = true;
        }
        if(emailInput.value == "") {
            this.insertErrorMessage(emailInput, "Email field is blank");
            errorOccured = true;
        }
        if(passwordInput.value == "") {
            this.insertErrorMessage(passwordInput, "Password field is blank");
            errorOccured = true;
        }
        if(passwordInput.value != passwordConfirmationInput.value) {
            this.insertErrorMessage(passwordConfirmationInput, "Password and confirmation do not match");
            errorOccured = true;
        } else if(passwordConfirmationInput.value == "") {
            this.insertErrorMessage(passwordConfirmationInput, "Password confirmation field is blank");
            errorOccured = true;
        }
        if(addressInput.value == "") {
            this.insertErrorMessage(addressInput, "Address field is blank");
            errorOccured = true;
        }
        if(specialisationInput) {
            if(specialisationInput.value == "") {
                this.insertErrorMessage(specialisationInput, "Specialisation field is blank");
                errorOccured = true;
            }
        }
        if(companyNameInput) {
            if(companyNameInput.value == "") {
                this.insertErrorMessage(companyNameInput, "Company name field is blank");
                errorOccured = true;
            }
        }
        
        return !errorOccured;
    }

    componentDidMount() { //Magic function that runs when the component is added to the html
        var _this = this;
        this.registrationFormRef.current.addEventListener("submit", function(e) {
            if(_this.checkFormFilled()) {
                return true;
            }
            
            e.preventDefault(); //Prevent form from submitting if an error was found
            return false;
        });
    }

    render() {
        var element =  (
            <form ref={this.registrationFormRef} className="md-form" method="POST" action="registrationUpdate.jsp">
                <input id="accountTypeInput" name="accountTypeInput" type="hidden" value={this.props.accountType} />
                <div className="form-row">
                    <div className="col form-group">
                        <input type="text" className="form-control" id="firstNameInput" name="firstNameInput" />
                        <label htmlFor="firstNameInput">First Name</label>
                    </div>
                    <div className="col form-group">
                        <input type="text" className="form-control" id="lastNameInput" name="lastNameInput" />
                        <label htmlFor="lastNameInput">Last Name</label>
                    </div>
                </div>
                <div className="form-group">
                    <input type="text" className="form-control" id="emailInput" name="emailInput" />
                    <label htmlFor="emailInput">Email address</label>
                </div>
                <div className="form-group">
                    <input type="password" className="form-control" id="passwordInput" name="passwordInput" />
                    <label htmlFor="passwordInput">Password</label>
                </div>
		        <div className="form-group">
                    <input type="password" className="form-control" id="passwordConfirmationInput" name="passwordConfirmationInput" />
                    <label autoComplete="new-password" htmlFor="passwordConfirmationInput">Password Confirmation</label>
                </div>
                <div className="form-group">
                    <input type="text" className="form-control" id="addressInput" name="addressInput" />
                    <label htmlFor="addressInput">Address</label>
                </div>
                {
                this.props.accountType == "Patient" &&
                <div className="form-group">
                    <select className="form-control selectpicker" id="petInput" name="petInput">
                        <option>Dog</option>
                        <option>Cat</option>
                    </select>
                </div>
                }
                {
                this.props.accountType == "Doctor" &&
                <div className="form-group"> 
                    <input type="text" className="form-control" id="specialisationInput" name="specialisationInput" />
                    <label htmlFor="specialisationInput">Specialisation</label>
                </div>
                }
                {
                this.props.accountType == "Insurance Provider" &&
                <div className="form-group"> 
                    <input type="text" className="form-control" id="companyNameInput" name="companyNameInput" />
                    <label htmlFor="companyNameInput">Company Name</label>
                </div>
                }
		    <input className="btn btn-primary btn-block"  type="submit" value="Register" />
            </form>
        );
        return element;
    }
}
