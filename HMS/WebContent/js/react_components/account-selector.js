'use strict';

class AccountButton extends React.Component {
    constructor(props) {
        super(props);
    }

    render() {
	const buttonTextStyle = {'whiteSpace': 'normal'};
        const iconStyle = "fas fa-" + this.props.icon;

	const element = <button onClick={this.props.onClick} type="button" className="btn btn-block" style={{color: '#000', margin: 0}}><i className={iconStyle}></i> <span style={buttonTextStyle}>{this.props.accountType}</span></button>
        
        return element;
    }
}

class AccountSelector extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            accountType: "",
            selectedButton: ""
        };
	this.selectedBtnClass = "btn-primary";
    }

    //Returns a function that fires when a new account button is clicked
    makeHandleClick(accountType) {
        var self = this;

        return function(e) {
            if(accountType != self.state.accountType) {
                //Remove active from old button
                if(self.state.selectedButton) {
                    self.state.selectedButton.classList.remove(self.selectedBtnClass);
                }
                //Add active to newly clicked button
                self.state.selectedButton = e.currentTarget;
                self.state.selectedButton.classList.add(self.selectedBtnClass);

                self.state.accountType = accountType;
                self.props.onAccountSelected(accountType);
            }
        };
    }

    render() {
        const element = (
            <div>
                    <div className="btn-group-vertical col" role="group">                    
                    <AccountButton accountType="Patient" icon="user" onClick={this.makeHandleClick("Patient")} />
                    <AccountButton accountType="Doctor" icon="user-md" onClick={this.makeHandleClick("Doctor")} />
                    <AccountButton accountType="Insurance Provider" icon="user-tie" onClick={this.makeHandleClick("Insurance Provider")} />
                </div>
            </div>
        );
        return element;
    }
}

