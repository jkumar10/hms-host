function submitLoginForm(e) {
	e.preventDefault();
	console.log("Submit for called");

	const loginUpdateURL = "loginUpdate.jsp";

	var loginForm = document.getElementById("reactLoginForm");
	var accountTypeInput = loginForm.querySelector("#accountTypeInput");
	//var googleOAuthUsedInput = loginForm.querySelector("#googleOAuthUsed");
	var emailInput = loginForm.querySelector("#emailInput");
	var passwordInput = loginForm.querySelector("#passwordInput");

	var paramDict = {
		"accountTypeInput": accountTypeInput.value,
		//"googleOAuthUsed": googleOAuthUsedInput.value,
		"emailInput": emailInput.value,
		"passwordInput": passwordInput.value
	};
	var paramStr = formatParams(paramDict);

	console.log("Async call made")
	asyncPostPage(loginUpdateURL, paramStr, function(responseText) {
		responseText = responseText.trim();

		console.log("Async succeeded");
		console.log(responseText);
		if(responseText == "1") {
			console.log("Successful login");
			window.location.replace("otp.html");
		}
		else if(responseText == "0") {
			console.log("User doesn't exist");
		}
		else if(responseText == "2") {
			console.log("Email failed");
		}
	});
	return false; //To prevent default form submission
}

var displayLoginForm = function(type) {
            var loginForm = document.getElementById("LoginForm");
            var element = (
                <form id="reactLoginForm" onSubmit={submitLoginForm} className="col md-form">
                    <input type="hidden" value={type} id="accountTypeInput" name="accountTypeInput" required />
                    <input className="form-control" type="text" placeholder="email" id="emailInput" name="emailInput" required />
                    <input className="form-control" type="password" placeholder="password" id="passwordInput" name="passwordInput" required />
		    <input onClick={submitLoginForm} className="form-control btn btn-primary btn-block" type="submit" value="Login" />
		    <p className="text-center" style={{"marginBottom": ".55rem"}}>Or Login With</p>
		    <GoogleSignInBtn />
                </form>
            );
            ReactDOM.render(
                element,
                loginForm
            );
        };

        //Load in the account- selector
        var accountSelectorTargets = document.querySelectorAll("#account-selector");
        accountSelectorTargets.forEach(element => {
            ReactDOM.render(
                <AccountSelector onAccountSelected={(type) => displayLoginForm(type)} />,
                element
            );
        });

