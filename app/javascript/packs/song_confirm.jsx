import React from 'react';
import ReactDOM from 'react-dom';
import postData from './comms';

class SongConfirm extends React.Component {
	constructor(props) {
		super(props);
		this.handleOnChange = this.handleOnChange.bind(this)
	}

	handleOnChange(event) {
		console.log("value changed !!!!!");
		console.log(event.target.value)
	}

	render() {
		return( 
			<div >
				  <p class="control">
				    <span class="select">
				     <select  name={this.props.select} >
						  <option value="Featured Artist">Featured artist</option>
						  <option value="Artist">Artist</option>
						  <option value="Album">Album</option>
						</select>
				    </span>
				  </p>
				  <p class="control">
				    <input class="input" type="text" name={this.props.name}/>
				  </p>
				</div>
			

		)
	}
}

export default SongConfirm;