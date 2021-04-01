import React from 'react';
import ReactDOM from 'react-dom';
import postData from './comms';

class Download extends React.Component {

	constructor(props) {
		super(props);
	}

	handleClick = (e) => {
		console.log(this.props);
		console.log(this.props.thumbnailUrl);
		var data = {};
		data = {"video": this.props.videoUrl.toString(),
						"thumbnail": this.props.thumbnailUrl.toString()};
		postData("/songs", data)
		.then(data => {console.log(data)});
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