import React from 'react';
import ReactDOM from 'react-dom';
import PropTypes from 'prop-types';
import getData from './getcomms'; // takes url and json data that it submits, returns data async
import * as bulma from './../../assets/stylesheets/application.scss';
import SongElement from './song_element';
import Playlist from './intouch-mp3-player/dist/index';


class TracksIndex extends React.Component {
	constructor(props) {
    super(props);
    this.state = { results: {items: []}
    };
  }

  componentDidMount() {
  	console.log("all mounted");
    getData("/all_tracks").then(data => {console.log(data);
    	this.setState( {results: data})
  })
}

  render() {
  	var songs = [];
  	this.state.results["items"].forEach((element) =>  {
  		songs.push(<SongElement yt={element["yt"]}
    	  song_name={element["name"]}
    	  artists={element["artists"]}
    		key={element["yt"]}
    		image={element["img"]}
    	  file={element["src"]}
        status={element["status"]}
        id_no={element["id"]} />)
  	}
    )
    
    var player;
    if (this.state.results["items"][0] != null) {
      player = (<Playlist tracks={this.state.results["items"]} />)}

   	return (
   		<>
        <div class="is-centered-middle is-size-7 p-3"> Please help us by confirming tracks the way you would want them</div>
   			{songs}
        {player}

   		</>
  	)
  }
}

ReactDOM.render(
  <TracksIndex />,
  document.getElementById("root")
);