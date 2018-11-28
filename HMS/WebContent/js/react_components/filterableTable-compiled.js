"use strict";

var _createClass = function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; }();

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _possibleConstructorReturn(self, call) { if (!self) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return call && (typeof call === "object" || typeof call === "function") ? call : self; }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function, not " + typeof superClass); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, enumerable: false, writable: true, configurable: true } }); if (superClass) Object.setPrototypeOf ? Object.setPrototypeOf(subClass, superClass) : subClass.__proto__ = superClass; }

$('body').on("click", ".dropdown-menu.multidropdown-menu", function (event) {
    // This stops the default behavior of pages closing when the inside of the dropdown is click from occuring
    event.stopPropagation();
});

//Returns a subset of an array with all duplicates removed
function uniq(a) {
    var seen = {};
    return a.filter(function (item) {
        return seen.hasOwnProperty(item) ? false : seen[item] = true;
    });
}

function range(start, end) {
    var output = [];
    for (var i = start; i <= end; i++) {
        output.push(i);
    }
    return output;
}

var FilterComponent = function (_React$Component) {
    _inherits(FilterComponent, _React$Component);

    function FilterComponent(props) {
        _classCallCheck(this, FilterComponent);

        return _possibleConstructorReturn(this, (FilterComponent.__proto__ || Object.getPrototypeOf(FilterComponent)).call(this, props));
    }

    _createClass(FilterComponent, [{
        key: "filterUpdatedListener",
        value: function filterUpdatedListener() {
            if ("onFilterUpdated" in this.props) {
                this.props.onFilterUpdated();
            }
        }
    }, {
        key: "getFilter",
        value: function getFilter() {
            // Returns a function to be used in filter, user a closure to hold state
            return function (row) {
                return true;
            };
        }
    }]);

    return FilterComponent;
}(React.Component);

var ExactFilterDropdown = function (_FilterComponent) {
    _inherits(ExactFilterDropdown, _FilterComponent);

    function ExactFilterDropdown(props) {
        _classCallCheck(this, ExactFilterDropdown);

        var _this3 = _possibleConstructorReturn(this, (ExactFilterDropdown.__proto__ || Object.getPrototypeOf(ExactFilterDropdown)).call(this, props));

        _this3.listRef = React.createRef();

        _this3.state = {
            columnData: _this3.getColumnData()
        };
        return _this3;
    }

    _createClass(ExactFilterDropdown, [{
        key: "componentDidMount",
        value: function componentDidMount() {
            var _this = this;

            //Setup listeners for when filter dropdown items are clicked
            Array.from(this.listRef.current.children).forEach(function (element) {
                element.onclick = function (e) {
                    var checkbox = element.children[0];
                    checkbox.checked = !checkbox.checked;

                    _this.filterUpdatedListener();
                };
            });
        }
    }, {
        key: "getColumnData",
        value: function getColumnData() {
            var _this = this;

            //Get only the data within the column
            var columnData = this.props.data.map(function (row) {
                return row[_this.props.column.name];
            });
            //Remove duplicates
            columnData = uniq(columnData);
            //Alphabetical sort
            return columnData.sort();
        }
    }, {
        key: "render",
        value: function render() {
            var itemArray = this.state.columnData.map(function (columnVal) {
                return React.createElement(
                    "a",
                    { key: columnVal, className: "dropdown-item" },
                    React.createElement("input", { type: "checkbox" }),
                    React.createElement(
                        "span",
                        null,
                        columnVal
                    )
                );
            });

            var id = this.props.column.name + "ExactFilter";
            return React.createElement(
                "div",
                { className: "dropdown" },
                React.createElement(
                    "button",
                    { className: "btn btn-secondary dropdown-toggle", type: "button", id: id, "data-toggle": "dropdown" },
                    this.props.column.displayName
                ),
                React.createElement(
                    "div",
                    { ref: this.listRef, className: "multidropdown-menu dropdown-menu pre-scrollable", style: { 'maxHeight': '200px' }, "aria-labelledby": id },
                    itemArray
                )
            );
        }
    }, {
        key: "getFilter",
        value: function getFilter() {
            var _this = this;
            return function (row) {
                var selectedInputs = _this.listRef.current.querySelectorAll("input:checked");
                if (selectedInputs.length == 0) return true;

                var val = row[_this.props.column.name];
                var selectedColumns = Array.from(selectedInputs).map(function (input) {
                    return input.parentElement.children[1].innerHTML;
                });

                //Row is already sorted so if localeCompare returns 1 then stop
                for (var i = 0; i < selectedColumns.length; i++) {
                    var columnVal = selectedColumns[i];
                    var cmp = val.localeCompare(columnVal);

                    if (cmp == -1) return false;
                    if (cmp == 0) return true;
                }

                return false;
            };
        }
    }]);

    return ExactFilterDropdown;
}(FilterComponent);

var MinMaxFilter = function (_FilterComponent2) {
    _inherits(MinMaxFilter, _FilterComponent2);

    function MinMaxFilter(props) {
        _classCallCheck(this, MinMaxFilter);

        var _this4 = _possibleConstructorReturn(this, (MinMaxFilter.__proto__ || Object.getPrototypeOf(MinMaxFilter)).call(this, props));

        _this4.minVal = _this4.maxVal = null;
        _this4.maxRef = React.createRef();
        _this4.minRef = React.createRef();
        return _this4;
    }

    _createClass(MinMaxFilter, [{
        key: "componentDidMount",
        value: function componentDidMount() {
            var _this = this;
            var minInputElement = this.minRef.current;
            var maxInputElement = this.maxRef.current;

            var minEvent = function minEvent(e) {
                _this.minVal = parseInt(minInputElement.value);
                _this.filterUpdatedListener();
            };
            var maxEvent = function maxEvent(e) {
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
    }, {
        key: "render",
        value: function render() {
            var id = this.props.column.name + "Btn";
            return React.createElement(
                "div",
                { className: "dropdown" },
                React.createElement(
                    "button",
                    { className: "btn btn-secondary dropdown-toggle", type: "button", "data-toggle": "dropdown", id: id },
                    this.props.column.displayName
                ),
                React.createElement(
                    "div",
                    { className: "multidropdown-menu dropdown-menu pre-scrollable", "aria-labelledby": id },
                    React.createElement(
                        "form",
                        { style: { "paddingLeft": ".5em", "paddingRight": ".5em" } },
                        React.createElement(
                            "div",
                            { className: "form-group" },
                            React.createElement(
                                "label",
                                { htmlFor: this.props.column.name + "MinimumValue" },
                                "Minimum Value"
                            ),
                            React.createElement("input", { ref: this.minRef, type: "number", className: "form-control", id: this.props.column.name + "MinimumValue" })
                        ),
                        React.createElement(
                            "div",
                            { className: "form-group" },
                            React.createElement(
                                "label",
                                { htmlFor: this.props.column.name + "MaximumValue" },
                                "Maximum Value"
                            ),
                            React.createElement("input", { ref: this.maxRef, type: "number", className: "form-control", id: this.props.column.name + "MaximumValue" })
                        )
                    )
                )
            );
        }
    }, {
        key: "getFilter",
        value: function getFilter() {
            var _this = this;

            //Filters rows based on if the value is great or less than given values
            return function (row) {
                var val = parseInt(row[_this.props.column.name]);

                if (_this.minVal != null && _this.minVal > val) return false;
                if (_this.maxVal != null && _this.maxVal < val) return false;

                return true;
            };
        }
    }]);

    return MinMaxFilter;
}(FilterComponent);

var PageNav = function (_React$Component2) {
    _inherits(PageNav, _React$Component2);

    function PageNav(props) {
        _classCallCheck(this, PageNav);

        var _this5 = _possibleConstructorReturn(this, (PageNav.__proto__ || Object.getPrototypeOf(PageNav)).call(this, props));

        _this5.state = {
            maxPagesVisible: "maxPagesVisible" in _this5.props ? parseInt(_this5.props.maxPagesVisible) : 7, //Default to 7 if not supplied
            pageCount: parseInt(_this5.props.pageCount),
            currPage: 1
        };
        return _this5;
    }

    //Updates the page count and the UI


    _createClass(PageNav, [{
        key: "updatePageCount",
        value: function updatePageCount(pageCount) {
            this.setState(function () {
                pageCount: pageCount;
            });
        }

        //Update the current page and the UI

    }, {
        key: "updatePage",
        value: function updatePage(pageNum) {
            if (pageNum == this.state.currPage) return; //Don't update if page hasn't changed

            this.setState(function () {
                return { currPage: pageNum };
            }); // Updates state and causes redraw

            if ("onPageChanged" in this.props) {
                this.props.onPageChanged(pageNum); // Make parent aware that page has changed
            }
        }

        //pageArray - an array of page numbers to draw

    }, {
        key: "makePageBtns",
        value: function makePageBtns(pageArray) {
            var _this = this;

            return pageArray.map(function (i) {
                var classList = "page-item";
                if (i == _this.state.currPage) classList += " active"; //classList.push("active");

                return React.createElement(
                    "li",
                    { key: i.toString(), className: classList, onClick: function onClick() {
                            _this.updatePage(i);
                        } },
                    React.createElement(
                        "a",
                        { className: "page-link" },
                        React.createElement(
                            "span",
                            null,
                            i
                        )
                    )
                );
            });
        }
    }, {
        key: "render",
        value: function render() {
            var _this = this;

            //Shorthand names
            var currPage = this.state.currPage;
            var pageCount = this.state.pageCount;
            var maxPagesVisible = this.state.maxPagesVisible;

            if (pageCount <= 1) //If only 0 or 1 page then print no pages
                return React.createElement("div", null); //Render nothing 

            //Get pages centered around the current page, or get pages from a side to make it add up to maxPagesVisible
            var roundedUpPageCount = Math.ceil(maxPagesVisible / 2.0);
            var roundedDownPageCount = Math.floor(maxPagesVisible / 2.0);
            var visiblePages = [];
            if (pageCount < maxPagesVisible) {
                //Show as many as possible
                visiblePages = range(1, pageCount);
            } else if (currPage < roundedUpPageCount) {
                //current page through the max page visible
                visiblePages = range(1, maxPagesVisible);
            } else if (currPage > pageCount - roundedDownPageCount) {
                visiblePages = range(pageCount - maxPagesVisible + 1, pageCount);
            } else {
                visiblePages = range(currPage - roundedDownPageCount, currPage + roundedDownPageCount);
            }

            return React.createElement(
                "nav",
                { "aria-label": "Page navigation example" },
                React.createElement(
                    "ul",
                    { className: "pagination pg-blue justify-content-center" },
                    React.createElement(
                        "li",
                        { onClick: function onClick() {
                                return _this.updatePage(1);
                            } },
                        React.createElement(
                            "a",
                            { className: "page-link" },
                            React.createElement(
                                "span",
                                null,
                                "First"
                            )
                        )
                    ),
                    this.makePageBtns(visiblePages),
                    React.createElement(
                        "li",
                        { onClick: function onClick() {
                                return _this.updatePage(pageCount);
                            } },
                        React.createElement(
                            "a",
                            { className: "page-link" },
                            React.createElement(
                                "span",
                                null,
                                "Last"
                            )
                        )
                    )
                )
            );
        }
    }]);

    return PageNav;
}(React.Component);

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

var FilterableTable = function (_React$Component3) {
    _inherits(FilterableTable, _React$Component3);

    function FilterableTable(props) {
        _classCallCheck(this, FilterableTable);

        var _this6 = _possibleConstructorReturn(this, (FilterableTable.__proto__ || Object.getPrototypeOf(FilterableTable)).call(this, props));

        var rowCount = _this6.props.data.length;
        var rowsPerPage = "rowsPerPage" in _this6.props ? _this6.props.rowsPerPage : 10;

        _this6.state = {
            currPage: 1,
            rowCount: rowCount,
            rowsPerPage: rowsPerPage,
            pageCount: Math.ceil(rowCount / rowsPerPage),
            selectedRow: -1,
            filters: {},
            filteredData: _this6.props.data
        };

        _this6.pageNavRef = React.createRef();
        _this6.filterRefs = [];
        return _this6;
    }

    //Returns the original json used to build 


    _createClass(FilterableTable, [{
        key: "getRowData",
        value: function getRowData(rowIndex) {
            return this.state.filteredData[rowIndex];
        }
    }, {
        key: "updateFilteredData",
        value: function updateFilteredData() {
            var _this7 = this;

            var filteredData = this.props.data;
            var _this = this;

            console.log("filters", this.state.filters);
            Object.keys(this.state.filters).forEach(function (key) {
                var filter = _this.state.filters[key];
                filteredData = filteredData.filter(filter);
            });

            this.setState(function () {
                return {
                    currPage: 1,
                    filteredData: filteredData,
                    rowCount: filteredData.length,
                    pageCount: Math.ceil(filteredData.length / _this7.state.rowsPerPage)
                };
            });
        }
    }, {
        key: "setupFilterRefs",
        value: function setupFilterRefs() {
            var _this = this;
            this.filterRefs.forEach(function (filterRef) {
                var filterElem = filterRef.current;
                _this.state.filters[filterElem.props.column.name] = filterElem.getFilter();
            });
        }
    }, {
        key: "componentDidMount",
        value: function componentDidMount() {
            var _this = this;

            this.setupFilterRefs(); //Setup pulling filters and callbacks

            //Enable rows to be seleted and fire onRowSelected callback
            var idSelector = "#" + this.props.id;
            $(idSelector).on("click", "tr td", function (e) {
                var rowElement = this.parentElement;
                var rowIndex = $(idSelector + " tr").index(rowElement) + (_this.state.currPage - 1) * _this.state.rowsPerPage - 1;

                if (rowIndex == _this.state.selectedRow) return; //If already selected then stop

                //Update the selected row
                _this.setState({ selectedRow: rowIndex });

                //Call row changed callback
                if ("onRowSelected" in _this.props) {
                    _this.props.onRowSelected(_this.getRowData(rowIndex));
                }
            });
        }
    }, {
        key: "componentDidUpdate",
        value: function componentDidUpdate() {
            var _this = this;
            this.pageNavRef.current.setState({ pageCount: this.state.pageCount });
        }

        //Makes headers using displayName if it exists and 

    }, {
        key: "drawFilterRow",
        value: function drawFilterRow() {
            var _this = this;
            //Create th items in an array
            var tdItems = this.props.columns.map(function (column) {
                var displayName = "displayName" in column ? column.displayName : column.name; //if no display name then default to "name"

                var tdItem = undefined;
                if (column.exactFilter) {
                    var filterRef = React.createRef();
                    tdItem = React.createElement(
                        "td",
                        null,
                        React.createElement(ExactFilterDropdown, { ref: filterRef, column: column, onFilterUpdated: function onFilterUpdated() {
                                return _this.updateFilteredData();
                            }, data: _this.props.data })
                    );
                    _this.filterRefs.push(filterRef);
                } else if (column.minMaxFilter) {
                    var filterRef = React.createRef();
                    tdItem = React.createElement(
                        "td",
                        null,
                        React.createElement(MinMaxFilter, { ref: filterRef, column: column, onFilterUpdated: function onFilterUpdated() {
                                return _this.updateFilteredData();
                            }, data: _this.props.data })
                    );
                    _this.filterRefs.push(filterRef);
                } else {
                    tdItem = React.createElement(
                        "td",
                        null,
                        displayName
                    );
                }

                return tdItem;
            });

            return React.createElement(
                "tr",
                null,
                tdItems
            );
        }

        //Draw the visible data rows

    }, {
        key: "drawDataRows",
        value: function drawDataRows() {
            var _this = this;

            // Create td elements for each row, store each row as an array of td in tdRows
            var minRow = (this.state.currPage - 1) * this.state.rowsPerPage;
            var maxRow = minRow + this.state.rowsPerPage < this.state.rowCount - 1 ? minRow + this.state.rowsPerPage - 1 : this.state.rowCount - 1;

            var rows = range(minRow, maxRow).map(function (rowIndex) {
                var activeClass = rowIndex == _this.state.selectedRow ? "active" : "";
                var row = _this.state.filteredData[rowIndex];
                return React.createElement(
                    "tr",
                    { key: rowIndex, className: activeClass },
                    _this.props.columns.map(function (column) {
                        if (column.display == undefined || column.display) {
                            //If defined and not a falsey value
                            var tdItem = column.render != undefined ? column.render(row[column.name]) : row[column.name];
                            return React.createElement(
                                "td",
                                { scope: "col" },
                                tdItem
                            );
                        }
                        return React.createElement("td", null); /* Show nothing */
                    })
                );
            });
            return rows;
        }
    }, {
        key: "updatePage",
        value: function updatePage(pageNum) {
            if (pageNum == this.state.currPage) return; //If page not changed then stop

            this.setState(function () {
                return { currPage: pageNum };
            });
        }
    }, {
        key: "render",
        value: function render() {
            var _this8 = this;

            this.filterRefs = []; //Clear out old refs
            return React.createElement(
                "div",
                null,
                React.createElement(
                    "table",
                    { id: this.props.id, className: "table table-bordered table-striped unselectable-text" },
                    React.createElement(
                        "tbody",
                        null,
                        this.drawFilterRow(),
                        this.drawDataRows()
                    )
                ),
                React.createElement(PageNav, {
                    ref: this.pageNavRef,
                    pageCount: this.state.pageCount,
                    onPageChanged: function onPageChanged(pageNum) {
                        return _this8.updatePage(pageNum);
                    } })
            );
        }
    }]);

    return FilterableTable;
}(React.Component);