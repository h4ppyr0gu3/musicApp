import React from 'react';
import ReactDOM from 'react-dom';

class DownloadNotification extends React.Component {
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
			<div className="notification is-success">
				<button className="delete" onClick={this.handleClick}></button>
				Download has started!
			</div>
		)
	}
}

export default DownloadNotification