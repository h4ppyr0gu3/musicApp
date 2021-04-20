import React from 'react';
import ReactDOM from 'react-dom';
import postData from './comms';
import Notification from './notification';

class Download extends React.Component {

	constructor(props) {
		super(props);
		this.state = {clicked: false,
			data: {something: "nil"}};
	}

	handleClick = (e) => {
		if (this.state.clicked != true) {
		console.log(this.props);
		console.log(this.props.thumbnailUrl);
		var query = {};
		query = {"video": this.props.videoUrl,
						"thumbnail": this.props.thumbnailUrl,
						"title": this.props.name};
		postData("/songs", query)
		.then(data => {console.log(data),
			this.setState({data: data}, console.log(this.state.data));
			
				this.setState({clicked: true}, console.log(this.state.data))
			
			});
	};		
	}

	render() {
		if (this.state.clicked == true && this.state.data["success"] != null) {
			var notification = <Notification message={this.state.data["success"]} colour="success"/>
		}
		if (this.state.clicked == true && this.state.data["error"] != null) {
			var notification = <Notification message={this.state.data["error"]} colour="danger"/>
		}
		return(
			<div>
				<div className="columns">
					<div className="column">
						<p className="is-centered-middle"> Are you sure you want to download this song?</p>
						<p className="is-centered-middle"> The file will be downloaded and you will be informed when it is done</p>
					</div>
				</div>
				<div className="columns">
					<div className="column is-centered-middle">
						<button type="button" value="Download" className="button is-centered-middle" onClick={this.handleClick}>Download</button>
					</div>

				</div>
				<div className="columns">
					<div className="column">
						{notification}
					</div>
				</div>
			</div>
		)
	}
}


export default Download