import React from 'react';
import ReactDOM from 'react-dom';

class Download extends React.Component {

	constructor(props) {
		super(props);
	}

	render() {
		return(
			<form action="songs" method="POST">
				<input type="text" className="input" id="title" name="title" placeholder="title"></input>
				<input type="text" className="input" id="artist" name="artist" placeholder="artist"></input>
				<input type="text" className="input" id="featured_artist" name="featured_artist" placeholder="featured artist"></input>
				<input type="text" className="input" id="album" name="album" placeholder="album"></input>
				<input type="hidden" value={this.props.videoUrl} name="videoUrl" id="videoUrl"></input>
				<input type="hidden" value={this.props.thumbnailUrl} name="thumbnailUrl" id="thumbnailUrl"></input>
				<input type="submit" value="submit" className="button"></input>
			</form>
		)
	}
}


export default Download