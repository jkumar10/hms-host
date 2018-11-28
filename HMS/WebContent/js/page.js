

/*const activePageClass = "active-page";
const pageClass = "page";

function makeNavButton(buttonLabel, buttonClass, onClickFunc) {}
    var button = document.createElement("input");
    button.type = "button";
    button.value = buttonLabel;
    button.classList.add(buttonClass);
    button.addEventListener("click", onClickFunc);
    return button;
}

var PageView = function(element, pages) {
    var self = this; //A variable for helping to reference it from callback scope

    this.element = element;
    this.currentPageIndex = 0;

    //Bring in all the hard typed elements in the html
    var pageElements = this.element.getElementsByClassName(pageClass);
    this.pages = [];
    for(var i = 0; i < pageElements.length; i++) {
        this.pages.push(new Page(pageElements[i]));
    }

    //Turn on the first page by default
    if(this.pages.length > 0) {
        this.activatePage(0);
    }

    this.nextButton = makeNavButton("Next", "next-button", function() {
        self.clearErrors(); // Clear error messages from previous runs

        var errors = self.pages[self.currentPageIndex].nextPageRequirements();
        if(errors.length == 0) {
            //TODO: Clear error messages
            self.nextPage();
        } else {
            // Display the errors
            self.displayErrors(errors);
        }
    });

    this.prevButton = makeNavButton("Prev", "prev-button", function() {
        self.clearErrors(); // Clear error messages from previous runs
        self.prevPage();
    });

    //Add next and prev buttons to the overall page-view element
    this.element.appendChild(this.nextButton);
    this.element.appendChild(this.prevButton);
    this.displayButtons();
};

PageView.prototype.addPage = function(page, index) {
    //TODO: ... insert at the given index
    this.pages.splice(index, 0, page);
    //If "index" is less than this.currentPageIndex then increment thsi.currentPageIndex by 1 because an item is put before it.
    if(index < this.currentPageIndex) {
        this.currentPageIndex++;
    }

    if(this.pages.length == 1) { //If this is the first page added activate it
        this.activatePage(0);
    }
    
    page.pageViewParent = this; //Make the view know its pageview container

    //Insert page into the html, position doesn't really matter (because it's activate via the page not the html)
    this.element.insertBefore(page.element, this.nextButton);
};

PageView.prototype.addPageAtEnd = function(page) {
    var index = this.pages.length;
    this.addPage(page, index);
};

PageView.prototype.displayButtons = function() {
    // Decides what buttons should be displays then enables them if so...
    this.nextButton.style.display = (this.currentPageIndex != this.pages.length - 1) ? "block" : "none";
    this.prevButton.style.display = (this.currentPageIndex != 0) ? "block" : "none";
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

//TODO: Gut this and make a real error printer
PageView.prototype.clearErrors = function() {
    console.log("errors cleared");
};

PageView.prototype.displayErrors = function(errors) {
    for(var i = 0; i < errors.length; i++) {
        console.log("Form error: " + errors[i]);
    }
}

var Page = function(element, nextPageReqsFunc) {
    this.element = element;
    this.element.classList.add(pageClass);
    this.pageViewParent = null;
    if(nextPageReqsFunc != undefined) {
        this.nextPageRequirements = nextPageReqsFunc;
    } else {
        this.nextPageRequirements = function () { return []; };
    }

    this.onNextPageFunc = function() {}; //TODO: Add a constructor optional param
};

Page.prototype.visible = function() {
    this.element.classList.add(activePageClass);
};

Page.prototype.invisible = function() {
    this.element.classList.remove(activePageClass);
};

Page.prototype.setNextPageRequirements = function(nextPageReqsFunc) {
    this.nextPageRequirements = nextPageReqsFunc;
};

Page.prototype.setOnNextPage = function(onNextPageFunc) {
    this.onNextPageFunc = onNextPageFunc;
};*/