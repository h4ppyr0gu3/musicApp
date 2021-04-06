import React from 'react';
import ReactDOM from 'react-dom';

export default class Video extends React.Component {
	constructor(props) {
    super(props);
	}
	render () {
		return (
			<iframe width="100%" height="340" src={this.props.source} title="YouTube video player" 
		    frameBorder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowFullScreen>
		  </iframe>

   )}

}