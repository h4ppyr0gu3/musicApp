import React from 'react';
import ReactDOM from 'react-dom';

export default class Video extends React.Component {
	constructor(props) {
    super(props);
	}
	render () {
		return (
			<iframe width="560" height="315" src={this.props.source} title="YouTube video player" 
		    frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen>
		  </iframe>

   )}

}