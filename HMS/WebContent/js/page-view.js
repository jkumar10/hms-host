const activePageClass = "active-page";
const pageClass = "page";

function makeNavButton(buttonLabel, buttonClass, onClickFunc) {
	var button = document.createElement("input");
    button.type = "button";
    button.value = buttonLabel;
    button.classList.add(buttonClass);
    button.addEventListener("click", onClickFunc);
    return button;
}

function makeNextButton(pageView) {
	return makeNavButton("Next", "next-button", function() {
        //TODO:self.clearErrors(); // Clear error messages from previous runs

        var errors = pageView.pages[pageView.currentPageIndex].nextPageRequirements();
        if(errors.length == 0) {
            //TODO: Clear error messages
            pageView.nextPage();
        } 
        else {
            // Display the errors
            //TODO: pageView.displayErrors(errors);
        }
    });
}

function makePrevButton(pageView) {
	return makeNavButton("Prev", "prev-button", function() {
        //TODO: pageView.clearErrors(); // Clear error messages from previous runs
        pageView.prevPage();
    });
}

var PageView = function(element, pages) {
	this.element = element;
	this.pages = [];
	for(var i=0; i<pages.length; i++) {
		this.addPage(pages[i]);
	}
	
	this.currentPageIndex = 0;
	
    this.nextButton = makeNextButton(this);
    this.prevButton = makePrevButton(this);
    //Add next and prev buttons to the overall page-view element
    this.element.appendChild(this.nextButton);
    this.element.appendChild(this.prevButton);
    
    this.displayButtons();
};

PageView.prototype.addPage = function(page) {
	this.pages.push(page);
	
	//Insert the element of the page above next button
	for(var i = 0; i < page.subpages.length; i++) {
		var subpage = page.subpages[i];
		this.element.insertBefore(subpage.element, this.nextButton);
	}
	
	if(this.pages.length == 1) {
		this.activatePage(0);
	}
};

PageView.prototype.removePage = function(page) {
	this.pages.splice(this.pages.indexOf(page), 1);
	
	for(var i = 0; i < page.subpages.length; i++) {
		var subpage = page.subpages[i];
		subpage.element.remove();
	}
};

PageView.prototype.nextPage = function() {
    //Execute on the next page listener
    this.pages[this.currentPageIndex].onNextPageFunc();

    //Remove active from current page
    this.deactivatePage(this.currentPageIndex);
    //Add active to the next page
    this.activatePage(this.currentPageIndex + 1);

    this.currentPageIndex += 1;
    this.displayButtons(); //Reset what buttons should be displayed for the given page
};

PageView.prototype.prevPage = function() {
    //Remove active from current page
    this.deactivatePage(this.currentPageIndex);
    //Add active to the next page
    this.activatePage(this.currentPageIndex - 1);

    this.currentPageIndex -= 1;
    this.displayButtons(); //Reset what buttons should be displayed for the given page
};

PageView.prototype.activatePage = function(pageIndex) {
    var page = this.pages[pageIndex];
    page.visible();
};

PageView.prototype.deactivatePage = function(pageIndex) {
    var page = this.pages[pageIndex];
    page.invisible();
};

PageView.prototype.displayButtons = function() {
    // Decides what buttons should be displays then enables them if so...
    this.nextButton.style.display = (this.currentPageIndex != this.pages.length - 1) ? "block" : "none";
    this.prevButton.style.display = (this.currentPageIndex != 0) ? "block" : "none";
};





var Page = function(subpages) {
	this.subpages = subpages;
};

Page.prototype.visible = function() {
	for(var i = 0; i < this.subpages.length; i++) {
		this.subpages[i].visible();
	}
};

Page.prototype.invisible = function() {
	for(var i = 0; i < this.subpages.length; i++) {
		this.subpages[i].invisible();
	}
};

Page.prototype.onNextPageFunc = function() {
	console.log("next page attempted")
	for(var i = 0; i < this.subpages.length; i++) {
		this.subpages[i].onNextPageFunc();
	}
}

Page.prototype.nextPageRequirements = function() {
	errors = [];
	for(var i = 0; i < this.subpages.length; i++) {
		errors = errors.concat(this.subpages[i].nextPageReqsFunc());
	}
	return errors;
};





var Subpage = function(element, nextPageReqsFunc) {
	this.element = element;
	
	this.nextPageReqsFunc = nextPageReqsFunc;
	this.onNextPageFunc = function() {};
	
	this.invisible();
};

Subpage.prototype.visible = function() { 
	this.element.style.display = "block";
};
Subpage.prototype.invisible = function() { this.element.style.display = "none"; };

Subpage.prototype.setNextPageRequirements = function(nextPageReqsFunc) {this.nextPageReqsFunc = nextPageReqsFunc; };
Subpage.prototype.setOnNextPage = function(onNextPageFunc) {this.onNextPageFunc = onNextPageFunc; };