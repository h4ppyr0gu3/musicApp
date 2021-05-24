import React from 'react';
import ReactDOM from 'react-dom';
import getData from './../js_helpers/getcomms';
import postData from './../js_helpers/comms';
import Notification from './../js_helpers/notification';

class Playlist extends React.Component {

	constructor(props) {
		super(props);
		this.state = {response: {playlists: []}};
		this.handleClick = this.handleClick.bind(this)
	}

	componentDidMount() {
		getData('/playlists/playlists_api').then(data =>{console.log(data), this.setState({response: data})})
	}

	handleClick(playlist, e) {
		var number = "number" + playlist;
		var data = {playlist_id: playlist, song_id: this.props.id_no};
		postData('/playlists/add_song', data).then(data => {console.log(data), this.setState({[number]: true})})
	}

	render() {
		var playlist = []
		this.state.response['playlists'].forEach((element) =>  {
			var number = "number" + element["playlist_id"]
			if (this.state.[number] == true) {
			var notification = (<Notification message={"added to " + element['name']} colour="success"/>)
			}
			playlist.push(<><a className="dropdown-item" key={'playlist_id'} onClick={this.handleClick.bind(this, element["playlist_id"])}>
			{element["name"]}
			</a>
			{notification}
			</>
			)
		})
		return(
			<>
			{playlist}
			</>
		)
	}
}


export default Playlist