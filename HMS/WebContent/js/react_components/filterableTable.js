$('body').on("click", ".dropdown-menu.multidropdown-menu" , function(event){
    // This stops the default behavior of pages closing when the inside of the dropdown is click from occuring
    event.stopPropagation();
});

//Returns a subset of an array with all duplicates removed
function uniq(a) {
    var seen = {};
    return a.filter(function(item) {
        return seen.hasOwnProperty(item) ? false : (seen[item] = true);
    });
}

function range(start, end) {
	var output = [];
	for(var i = start; i <= end; i++) {
		output.push(i);
	}
	return output;
}

class FilterComponent extends React.Component {
    constructor(props) {
        super(props);
    }

    filterUpdatedListener() {
        if("onFilterUpdated" in this.props) {
            this.props.onFilterUpdated();
        }
    }

    getFilter() {
        // Returns a function to be used in filter, user a closure to hold state
        return function(row) {
            return true
        };
    }
}

class ExactFilterDropdown extends FilterComponent {
    constructor(props) {
        super(props);

        this.listRef = React.createRef();

        this.state = {
            columnData: this.getColumnData()
        };
    }

    componentDidMount() {
        var _this = this;

        //Setup listeners for when filter dropdown items are clicked
		Array.from(this.listRef.current.children).forEach(function(element) {
			element.onclick = function(e) {
				var checkbox = element.children[0];
				checkbox.checked = !checkbox.checked;

				_this.filterUpdatedListener();
			};
		});
    }

    getColumnData() {
        var _this = this;

        //Get only the data within the column
        var columnData = this.props.data.map(function(row) {
            return row[_this.props.column.name];
        });
        //Remove duplicates
        columnData = uniq(columnData);
        //Alphabetical sort
        return columnData.sort();
    }

    render() {
        var itemArray = this.state.columnData.map(function(columnVal) {
            return (
                <a key={columnVal} className="dropdown-item">
					<input type="checkbox" />
					<span>{columnVal}</span>
				</a>
            );
        });

        var id = this.props.column.name + "ExactFilter";
        return (
            <div className="dropdown">
                <button className="btn btn-secondary dropdown-toggle" type="button" id={id} data-toggle="dropdown">{this.props.column.displayName}</button>
                <div ref={this.listRef} className="multidropdown-menu dropdown-menu pre-scrollable" style={{'maxHeight': '200px'}} aria-labelledby={id}>
                    {itemArray}
                </div>
            </div>
        );
    }

    getFilter() {
        var _this = this;
        return function(row) {
            var selectedInputs = _this.listRef.current.querySelectorAll("input:checked");
            if(selectedInputs.length == 0)
                return true;
            
            var val = row[_this.props.column.name];
            var selectedColumns = Array.from(selectedInputs).map(function(input) {
                return input.parentElement.children[1].innerHTML;
            });

            //Row is already sorted so if localeCompare returns 1 then stop
            for(var i = 0; i < selectedColumns.length; i++) {
                var columnVal = selectedColumns[i];
                var cmp = val.localeCompare(columnVal);
                
                if(cmp == -1) return false;
                if(cmp == 0) return true;
            }

            return false;
        };
    }
}

class MinMaxFilter extends FilterComponent {
    constructor(props) {
        super(props);

        this.minVal = this.maxVal = null;
        this.maxRef = React.createRef();
        this.minRef = React.createRef();
    }

    componentDidMount() {
        var _this = this;
        var minInputElement = this.minRef.current;
        var maxInputElement = this.maxRef.current;
        
        const minEvent = function(e) {
            _this.minVal = parseInt(minInputElement.value);
            _this.filterUpdatedListener();
        };
        const maxEvent = function(e) {
            _this.maxVal = parseInt(maxInputElement.value);
            _this.filterUpdatedListener();
        };

        minInputElement.addEventListener("change", minEvent);
        minInputElement.addEventListener("keyup", minEvent);
        minInputElement.addEventListener("click", minEvent);
        maxInputElement.addEventListener("change", maxEvent);
        maxInputElement.addEventListener("keyup", maxEvent);
        maxInputElement.addEventListener("click", maxEvent);
    }

    render() {
        var id = this.props.column.name + "Btn";
		return (
			<div className="dropdown">
				<button className="btn btn-secondary dropdown-toggle" type="button" data-toggle="dropdown" id={id}>{this.props.column.displayName}</button>
				<div className="multidropdown-menu dropdown-menu pre-scrollable" aria-labelledby={id}>
					<form style={{"paddingLeft": ".5em", "paddingRight": ".5em"}}>
						<div className="form-group">
							<label htmlFor={this.props.column.name+"MinimumValue"}>Minimum Value</label>
							<input ref={this.minRef} type="number" className="form-control" id={this.props.column.name+"MinimumValue"} />
						</div>
						<div className="form-group">
							<label htmlFor={this.props.column.name+"MaximumValue"}>Maximum Value</label>
							<input ref={this.maxRef} type="number" className="form-control" id={this.props.column.name+"MaximumValue"} />
						</div>
					</form>
				</div>
			</div>
		);
    }

    getFilter() {
        var _this = this;

        //Filters rows based on if the value is great or less than given values
        return function(row) {
	    //unlimited always false if max value is set
	    if(row[_this.props.column.name] == "unlimited")
	    	return _this.maxVal == null;
	  
	    //Check if parsed value is within min-max range
	    var val = parseInt(row[_this.props.column.name]);
            if(_this.minVal != null && _this.minVal > val) return false;
            if(_this.maxVal != null && _this.maxVal < val) return false;

            return true;
        };
    }
}

class PageNav extends React.Component {
    constructor(props) {
        super(props);

        this.state = {
            maxPagesVisible: ("maxPagesVisible" in this.props) ? parseInt(this.props.maxPagesVisible) : 7, //Default to 7 if not supplied
            pageCount: parseInt(this.props.pageCount),
            currPage: 1
        };
    }

    //Updates the page count and the UI
    updatePageCount(pageCount) { this.setState(() => { pageCount: pageCount }); }
    
    //Update the current page and the UI
    updatePage(pageNum) {
        if(pageNum == this.state.currPage)
            return; //Don't update if page hasn't changed

        this.setState(() => ({ currPage: pageNum })); // Updates state and causes redraw

        if("onPageChanged" in this.props) {
            this.props.onPageChanged(pageNum); // Make parent aware that page has changed
        }
    }

    //pageArray - an array of page numbers to draw
    makePageBtns(pageArray) {
        var _this = this;

        return (
            pageArray.map(function(i) {
                var classList = "page-item";
                if(i == _this.state.currPage) classList += " active"; //classList.push("active");

                return(
                    <li key={i.toString()} className={classList} onClick={() => {_this.updatePage(i);}}>
                        <a className="page-link"><span>{i}</span></a>
                    </li>
                );
            })
        );
    }

    render() {
        var _this = this;

        //Shorthand names
        const currPage = this.state.currPage;
        const pageCount = this.state.pageCount;
        const maxPagesVisible = this.state.maxPagesVisible;

        if(pageCount <= 1) //If only 0 or 1 page then print no pages
            return <div></div>; //Render nothing 

        //Get pages centered around the current page, or get pages from a side to make it add up to maxPagesVisible
        const roundedUpPageCount = Math.ceil(maxPagesVisible / 2.0);
        const roundedDownPageCount = Math.floor(maxPagesVisible / 2.0);
        var visiblePages = [];
        if(pageCount < maxPagesVisible) { //Show as many as possible
            visiblePages = range(1, pageCount);
        }
        else if(currPage < roundedUpPageCount) { //current page through the max page visible
            visiblePages = range(1, maxPagesVisible);
        }
        else if(currPage > pageCount - roundedDownPageCount) {
            visiblePages = range(pageCount - maxPagesVisible + 1, pageCount);
        }
        else {
            visiblePages = range(currPage-roundedDownPageCount, currPage+roundedDownPageCount);
        }
        
        return  (
            <nav aria-label="Page navigation example">
                <ul className="pagination pg-blue justify-content-center">
                    <li onClick={() => _this.updatePage(1)}><a className="page-link"><span>First</span></a></li>
                    { this.makePageBtns(visiblePages) }
                    <li onClick={() => _this.updatePage(pageCount)}><a className="page-link"><span>Last</span></a></li>
                </ul>
            </nav>
        );
    }
}

//id - required

//alphabetical - formats as string
//numerical    - formats as number

// sortable - annotates that the table can be sorted by this column
// ... default behavior sort by first column with this annotation
// ... if none annotated, then columns not sorted
// ... give sortable rows a little arrow to click to sort by them
// exactFilter  - == filter
// minMaxFilter - <= >= filter

// name - the name of the data in the json to pull out
// displayName - the  - defaults to name if it doesnt exist

class FilterableTable extends React.Component {
    constructor(props) {
        super(props);

        var rowCount = this.props.data.length;
        var rowsPerPage = ("rowsPerPage" in this.props) ? this.props.rowsPerPage : 10;

        this.state = {
            currPage: 1,
            rowCount: rowCount,
            rowsPerPage: rowsPerPage,
            pageCount: Math.ceil(rowCount / rowsPerPage),
            selectedRow: -1,
            filters: {},
            filteredData: this.props.data
        };

        this.pageNavRef = React.createRef();
        this.filterRefs = [];
    }

    //Returns the original json used to build 
    getRowData(rowIndex) {
        return this.state.filteredData[rowIndex];
    }

    updateFilteredData() {
        var filteredData = this.props.data;
        var _this = this;
        
        console.log("filters", this.state.filters);
        Object.keys(this.state.filters).forEach(key => {
            var filter = _this.state.filters[key];
            filteredData = filteredData.filter(filter);
        });

        this.setState(() => ({
            currPage: 1,
            filteredData: filteredData,
            rowCount: filteredData.length,
            pageCount: Math.ceil(filteredData.length / this.state.rowsPerPage)
        }));
    }

    setupFilterRefs() {
        var _this = this;
        this.filterRefs.forEach(function(filterRef) {
            var filterElem = filterRef.current;
            _this.state.filters[filterElem.props.column.name] = filterElem.getFilter();
        });
    }

    componentDidMount() {
        var _this = this;

        this.setupFilterRefs(); //Setup pulling filters and callbacks
        
        //Enable rows to be seleted and fire onRowSelected callback
        var idSelector = "#" + this.props.id;
        $(idSelector).on("click", "tr td:not(.empty)", function(e) {
            var rowElement = this.parentElement;
            var rowIndex = $(idSelector+" tr").index(rowElement) + (_this.state.currPage - 1) * _this.state.rowsPerPage - 1;

            if(rowIndex == _this.state.selectedRow)
                return; //If already selected then stop

            //Update the selected row
            _this.setState({ selectedRow : rowIndex});
            
            //Call row changed callback
            if("onRowSelected" in _this.props) {
                _this.props.onRowSelected(_this.getRowData(rowIndex));
            }
        });
    }

    componentDidUpdate() {
        var _this = this;
        this.pageNavRef.current.setState({pageCount: this.state.pageCount});
    }

    //Makes headers using displayName if it exists and 
    drawFilterRow() {
        var _this = this;
        //Create th items in an array
        var tdItems = this.props.columns.map(function(column) {
            var displayName = ("displayName" in column) ? column.displayName : column.name; //if no display name then default to "name"

            var tdItem = undefined;

            if(column.exactFilter) {
                var filterRef = React.createRef();
                tdItem = <td><ExactFilterDropdown ref={filterRef} column={column} onFilterUpdated={() => (_this.updateFilteredData())} data={_this.props.data} /></td>;
                _this.filterRefs.push(filterRef);
            }
            else if(column.minMaxFilter) {
                var filterRef = React.createRef();
                tdItem = <td><MinMaxFilter ref={filterRef} column={column} onFilterUpdated={() => (_this.updateFilteredData())} data={_this.props.data} /></td>;
                _this.filterRefs.push(filterRef);
            }
            else {
                tdItem = <td><button className="btn">{displayName}</button></td>;
            }

            return tdItem;
        });

        return (<tr>{ tdItems }</tr>);
    }

    //Draw the visible data rows
    drawDataRows() {
        var _this = this;

        // Create td elements for each row, store each row as an array of td in tdRows
        var minRow = (this.state.currPage - 1) * this.state.rowsPerPage;
        var maxRealRow = minRow + this.state.rowsPerPage < this.state.rowCount-1 ? minRow + this.state.rowsPerPage-1 : this.state.rowCount-1;
	var maxRow = minRow + this.state.rowsPerPage - 1;

        var rows = range(minRow, maxRow).map(function(rowIndex) {
	    if(rowIndex <= maxRealRow) {
       	     var activeClass = rowIndex == _this.state.selectedRow ? "active" : "";
       	     var row = _this.state.filteredData[rowIndex];

       	     return (
       	         <tr key={rowIndex} className={activeClass}>
       	             {
       	                 _this.props.columns.map(column => {
				 if(column.forceSpaceAfterComma) {
				 	row[column.name] = row[column.name].replace(/, /g, ",").replace(/,/g, ", ");
				 }
				 var tdItem = column.render != undefined ? column.render(row[column.name]) : row[column.name];
       	                         return <td scope="col">{tdItem}</td>;
       	                 })
       	             }
       	         </tr>
	            );
	    } else {
	    	return (
		<tr key={rowIndex}>
			{ _this.props.columns.map(column => (<td className="empty">&nbsp;</td>)) }
		</tr>
	        );
	    }
        });
        return rows;
    }

    updatePage(pageNum) {
        if(pageNum == this.state.currPage)
            return; //If page not changed then stop

        this.setState(() => ({ currPage: pageNum }));
    }

    render() {
        this.filterRefs = []; //Clear out old refs
        return (
            <div>
                <table id={this.props.id} className="table table-bordered table-striped table-responsive unselectable-text">
                    <tbody> 
                        {this.drawFilterRow()}
                        {this.drawDataRows()} 
                    </tbody>
                </table>
                <PageNav 
                    ref={this.pageNavRef}
                    pageCount={ this.state.pageCount }
                    onPageChanged={ (pageNum) => (this.updatePage(pageNum)) } />
            </div>
        );
    }
}
