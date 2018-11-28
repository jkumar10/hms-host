//Based on the original w3-include.js
//but changes were made to allow for javascript to be loaded and used dynamically

function domFromText(text) {
	var dom = new DOMParser().parseFromString(text, "text/html");
	return dom;
}

function includeHTML() {
  var z, i, elmnt, file, xhttp;
  /*loop through a collection of all HTML elements:*/
  z = document.getElementsByTagName("*");
  for (i = 0; i < z.length; i++) {
    elmnt = z[i];
    /*search for elements with a certain atrribute:*/
    file = elmnt.getAttribute("w3-include-html");

    if (file) {
      /*make an HTTP request using the attribute value as the file name:*/
      xhttp = new XMLHttpRequest();
      xhttp.onreadystatechange = function() {
        if (this.readyState == 4) {
	  if (this.status == 200) {
	    var dom = domFromText(this.responseText);
	    var scripts = dom.getElementsByTagName("script");
	    var links = dom.getElementsByTagName("link");
            var onloadFuncStr = elmnt.getAttribute("w3-include-html-load");

	    //Load all the link elements
	    for(var j = 0; j < links.length; j++) {
		console.log(links[j]);
	    	var tempLink = document.createElement("link");
		tempLink.rel = links[j].rel;
		tempLink.href = links[j].href;
		document.head.appendChild(tempLink);
	    }

            var externalScriptCount = 0;
            var loadedScriptCount = 0;
            var domInjected = false;

            function runOnLoad() {
              if(externalScriptCount == loadedScriptCount && domInjected) {
	        eval(onloadFuncStr);
	      }
	    }

            //Add all script elements to the head
            for(var j = 0; j < scripts.length; j++) {
	      var scriptElem = document.createElement("script");
	      if(scripts[j].src) {
	        scriptElem.src = scripts[j].src;

		//when all scripts are loaded run onload, 
		externalScriptCount++;
                scriptElem.onload = function() {
                  loadedScriptCount++;
                  runOnLoad();
		}

	        scriptElem.innerHTML = scripts[j].innerHTML;
	        document.head.appendChild(scriptElem);
	      }
	      else {
		//if it's not an external script the append it to the onload script
	        onloadFuncStr += scripts[j].innerHTML;
	      }
	    }
	     
	    //Add the body first so elements are available to the script, Add all elements of body to inner body of element
	    var domBody = dom.getElementsByTagName("body")[0];
	    for(var j = 0; j < domBody.children.length; j++) {
	      elmnt.appendChild(domBody.children[j]);
	    }

            domInjected = true;
            runOnLoad();
            // ...
	  }
          if (this.status == 404) {elmnt.innerHTML = "<p>Page not found.</p>";}
	  // remove the attribute to mark that an include should occur
          elmnt.removeAttribute("w3-include-html");

	  //Rechecks if more includes have been added in after the page was made
          includeHTML();
        }
      } 
      xhttp.open("GET", file, true);
      xhttp.send();
      /*exit the function:*/
      return;
    }
  }
}

//Add automatic event listener
window.addEventListener('load', function() {
  includeHTML();
});
