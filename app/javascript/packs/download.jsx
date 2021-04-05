import React from 'react';
import ReactDOM from 'react-dom';
import postData from './comms';

class Download extends React.Component {

	constructor(props) {
		super(props);
		this.state = {clicked: false};
	}

	handleClick = (e) => {
		if (this.state.clicked != true) {
		console.log(this.props);
		console.log(this.props.thumbnailUrl);
		var query = {};
		query = {"video": this.props.videoUrl.toString(),
						"thumbnail": this.props.thumbnailUrl.toString(),
						"title": this.props.name.toString()};
		postData("/songs", query)
		.then(data => {console.log(data);
			if (data["state"] == "Download started") {
				this.setState({clicked: true})
			}
			});
	};		
	}

	render() {
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
			</div>
		)
	}
}


export default Download