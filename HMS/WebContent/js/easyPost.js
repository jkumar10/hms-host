//Converts dict to a url-encoded string
function formatParams(paramDict) {
	return Object.keys(paramDict).map(key => key + '=' + paramDict[key]).join('&');
}

//Synchronous ajax post call
//Returns the returned value of the ajax call
function postPage(href, paramStr) {
	var request = new XMLHttpRequest();
	request.open('POST', href, false);
	request.setRequestHeader( 'Content-Type', 'application/x-www-form-urlencoded' );
	request.send(paramStr);

	if(request.status == 200) {
		return request.responseText;
	}
	console.log("help: sync ajax failed");
	return "";
}

//Synchronous ajax post call
//Calls the given callback using the returned value of the ajax call
//If not callback is supplied it simply posts to the page with no further action
function asyncPostPage(href, paramStr, callback) {
	var request = new XMLHttpRequest();
	request.open('POST', href, true);
	request.setRequestHeader( 'Content-Type', 'application/x-www-form-urlencoded' );

	request.onreadystatechange = function() {
		if(this.readyState == 4 && this.status == 200) {
			callback(request.responseText);
		}
		/*else {
			console.log("help: async ajax failed");
		}*/
	};

	request.send(paramStr);
}
