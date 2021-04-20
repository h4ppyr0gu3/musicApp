import React from 'react';
import ReactDOM from 'react-dom';

class Notification extends React.Component {
	constructor(props) {
		super(props);
		this.state = {clicked: false};
	}

	handleClick = e => {
		this.setState({clicked: true})
	}
	
	render() {
		if (this.state.clicked == true) {
			return null;
		}
		return(
			<div className={"notification is-" + this.props.colour}>
				<button className="delete" onClick={this.handleClick}></button>
				{this.props.message}
			</div>
		)
	}
}

export default Notification;