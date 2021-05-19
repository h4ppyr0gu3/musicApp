import React from 'react';
import ReactDOM from 'react-dom';
import PropTypes from 'prop-types';
import getData from './../js_helpers/getcomms'; // takes url and json data that it submits, returns data async
import * as bulma from './../../../assets/stylesheets/application.scss';
import SongElement from './song_element_confirmed';
import Playlist from './../intouch-mp3-player/dist/index';


class TracksIndex extends React.Component {
	constructor(props) {
    super(props);
    this.state = { results: {items: []}
    };
  }

  componentDidMount() {
  	console.log("all mounted");
    getData("/playlists/favourites_api").then(data => {console.log(data);
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
        id_no={element["id"]}
        place="tracks" />)
  	}
    )
    
    // var player;
    // if (this.state.results["items"][0] != null) {
    //   player = (<Playlist tracks={this.state.results["items"]} />)} player rendered with {player}

   	return (
   		<>
        <div class="is-centered-middle is-size-7 p-3"> Please help us by confirming tracks the way you would want them</div>
   			{songs}
   		</>
  	)
  }
}

ReactDOM.render(
  <TracksIndex />,
  document.getElementById("root")
);