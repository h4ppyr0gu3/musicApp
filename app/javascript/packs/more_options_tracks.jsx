import React from 'react';
import ReactDOM from 'react-dom';
import postData from './comms';
import Notification from './notification';

class MoreOptionsTracks extends React.Component {
	constructor(props) {
		super(props);
		this.state = {
			removed: false,
			downloaded: false,
			added: false
		}
		this.handleRemove = this.handleRemove.bind(this)
		this.handleUpdate = this.handleUpdate.bind(this)
		this.handleAdd = this.handleAdd.bind(this)
	}

	handleRemove() {
		fetch('/tracks/' + this.props.id_no, {
		  method: 'DELETE',
		})
		.then(res => res.json())
		.then(res => this.setState({removed_data: res["success"]}, this.setState({removed: true})))
		;
	}

	handleAdd() {
		var data = {id: this.props.id_no}
		console.log(data);
		postData('/tracks', data).then(data => {console.log(data), this.setState({added_data: data["success"]}), this.setState({added: true})})
		// .then(res => res.json())
		// .then(res => this.setState({added_data: res["success"]}, this.setState({added: true})))

		;
	}

	handleUpdate() {
		console.log(update);
	}

	render() {
		var intermediate;
		if (this.props.place == "tracks") {
			if (this.state.removed == true) {
				var info = (<Notification message="removed from your tracks" colour="success"/>)
			} 
			intermediate =  <><a className="dropdown-item" onClick={this.handleRemove}>
							        	Remove from tracks
							        </a>
        	{info}
			</>
		}
		if (this.props.place == "songs") {
			if (this.state.added == true) {
				var info = (<Notification message="added to your tracks" colour="success"/>)
			} 
			intermediate = <> <a className="dropdown-item" onClick={this.handleAdd}>
							        	Add to tracks
							        </a>
        	{info}
			</>
		}
		return(
			<div className="dropdown-content">
        <a href={this.props.file} download className="dropdown-item">
        	Download
        </a>
        
        	{intermediate}

        <a className="dropdown-item" onClick={this.handleUpdate}>
        	Update attributes
        </a>
      </div>
		)
	}

}

export default MoreOptionsTracks;