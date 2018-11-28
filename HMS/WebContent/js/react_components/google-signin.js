//Fetch the user's person information
// ... console.log(googleUser.getBasicProfile().getName());

//Setup login button autofilling with react elements
class GoogleSignInBtn extends React.Component {
	constructor(props) {
		super(props);
	}

	render() {
		return (<button onClick={signInBtnClickedHandler} className="form-control btn btn-primary btn-block"><i className="fab fa-google"></i> Google</button>);
	}
}

//Stops sign in from occuring automatically onload, 
var signInBtnClicked = false; // Stops google api from auto-signing in
function signInBtnClickedHandler() {
	signInBtnClicked = true;
	var auth2 = gapi.auth2.getAuthInstance();
	auth2.grantOfflineAccess().then(onSignIn); //Calls the sign in callback
};

//Setup gapi and auth2
var discoveryDocs = ["https://people.googleapis.com/$discovery/rest?version=v1"];
var clientId = "224877148621-38kvdgdjt0n4sk0i3dvdm9nted9epfjb.apps.googleusercontent.com";
var scopes = "profile email openid";
function initClient() {
	gapi.client.init({
		discoveryDocs: discoveryDocs,
		clientId: clientId,
		scope: scopes
	}).then(function () {
		// and listen for sign-in state changes.
		gapi.auth2.getAuthInstance().isSignedIn.listen(onSignIn);

		//Replaces every use of .google-signin-btn with a react component
		$("body").find(".google-signin-btn").each(function() {
			ReactDOM.render(<SignInBtnComponent />, this);
		});
	});
}

//Google Sign In Callbacks
function onSignIn() {
	var auth2 = gapi.auth2.getAuthInstance();
	var googleUser = auth2.currentUser.get();

	//Fetch id_token and confirm it's valid server side
	confirmIdToken(
		googleUser.getAuthResponse().id_token,
		function() {
			//Google login succesful
			console.log("Login succeeded");
			window.location.replace("index.jsp?login_successful=1");
		},
		function() {
			//Google login unsucessful
			console.log("login failed"); //TODO: Add failed async call throw back
		}
	);
}

/*function signOut() {
	var auth2 = gapi.auth2.getAuthInstance();
	auth2.signOut().then(function() {
		alert("Signed out"); //Signs out user
		//TODO: Inform server to clear the session
	});
}*/

//Determines if id_token is valid asynchronously
//Two callbacks are handed in and which one is ran is determined by the returned
//value of the server
function confirmIdToken(id_token, successCallback, failureCallback) {
	var loginForm = document.getElementById("reactLoginForm");
	var paramDict = {
		"idToken": id_token,
		"accountTypeInput": loginForm.querySelector("#accountTypeInput").value
	}
	var paramStr = formatParams(paramDict);
	asyncPostPage(
		"http://www.vetpet.online:8080/loginUpdate.jsp",
		paramStr,
		function(responseText) {
			responseText = responseText.trim();
			console.log(responseText);
			if(responseText == "1") {
				successCallback();
			} else {
				failureCallback();
			}
		}
	);
}

// Required setup for google-api, calls initClient when api is ready
gapi.load("client", initClient);
