import React from 'react';
import ReactDOM from 'react-dom';
import postData from './../js_helpers/comms';
import Notification from './../js_helpers/notification';
import Playlist from './playlist';

class MoreOptionsTracks extends React.Component {
	constructor(props) {
		super(props);
		this.state = {
			removed: false,
			downloaded: false,
			added: false,
			playlist: false,
			favourites: false,
			attributes: false
		}
		this.handleRemove = this.handleRemove.bind(this)
		this.handleUpdate = this.handleUpdate.bind(this)
		this.handleAdd = this.handleAdd.bind(this)
		this.handleFavourites = this.handleFavourites.bind(this)
		this.handlePlaylists = this.handlePlaylists.bind(this)
	}

	handleRemove() {
		fetch('/tracks/' + this.props.id_no, {
			method: 'DELETE',
		})
		.then(res => res.json())
		.then(res => this.setState({removed_data: res["success"]}, this.setState({removed: true}), console.log(res)))
		;
	}

	handleAdd() {
		var data = {id: this.props.id_no}
		console.log(data);
		postData('/create_tracks', data).then(data => {console.log(data), this.setState({added_data: data["success"]}), this.setState({added: true})})
	}

	handleUpdate() {
		var data = {id: this.props.id_no}
		console.log(data);
		postData('/edit_again', data).then(data => {console.log(data), this.setState({attributes: true})})
	}

	handleFavourites() {
		var data = {id: this.props.id_no}
		console.log(data);
		postData('/playlists/update_favourites', data).then(data => {console.log(data), this.setState({favourites: true})})
	}

	handlePlaylists() {
		this.setState({playlist: !this.state.playlist})
	}

	render() {
		var intermediate;
		if (this.props.place == "tracks") {
			if (this.state.removed == true) {
				var infoTracks = (<Notification message="removed from your tracks" colour="success"/>)} 
			intermediate =  <><a className="dropdown-item" onClick={this.handleRemove}>
			Remove from tracks
			</a>
			{infoTracks}
			</>
		}
		if (this.props.place == "songs") {
			if (this.state.added == true) {
				var infoTracks = (<Notification message="added to your tracks" colour="success"/>)} 
			intermediate = <> <a className="dropdown-item" onClick={this.handleAdd}>
			Add to tracks
			</a>
			{infoTracks}
			</>
		}
		if (this.state.favourites == true) {
			var infoFavourites = (<Notification message="added to favourites" colour="success"/>)
		}
		if (this.state.playlist == true) {
			var playlist = (<Playlist id_no={this.props.id_no} colour="success"/>)
		}
		return(
			<div className="dropdown-menu is-active">
			<div className="dropdown-content">
			<a href={this.props.file} download className="dropdown-item">
			Download
			</a>
			{intermediate}
			<a className="dropdown-item" onClick={this.handleUpdate}>
			Update attributes
			</a>
			<a className="dropdown-item" onClick={this.handleFavourites}>
			Add to Favourites
			</a>
			{infoFavourites}
			<a className="dropdown-item" onClick={this.handlePlaylists}>
			Add to Playlist
			</a>
			{playlist}
			</div>
			</div>
			)
	}

}

export default MoreOptionsTracks;