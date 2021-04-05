import React from 'react';
import ReactDOM from 'react-dom';

class DownloadNotification extends React.Component {

	
	render() {
		return(
			<div className="notification is-primary">
				<button className="delete" ></button>
				Download has started!
			</div>
		)
	}
}

export default DownloadNotification