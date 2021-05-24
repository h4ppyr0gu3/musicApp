import React from 'react';
import ReactDOM from 'react-dom';
import PropTypes from 'prop-types';
import getData from './../js_helpers/getcomms'; // takes url and json data that it submits, returns data async
import * as bulma from './../../../assets/stylesheets/application.scss';
import SongElement from './../songs/song_element_confirmed';

class SongsIndex extends React.Component {
	constructor(props) {
    super(props);
    this.state = { 
      results: {items: []},
      name: ''
    };
  }

  componentDidMount() {
  	console.log("all mounted");
    var pathname = window.location.pathname;
    console.log(pathname);
    var a = pathname.split("/")
    console.log(a);
    var playlist_id = a[3];
    var data = {page: 1};
    getData("/playlists/show_api/" + playlist_id, data)
    .then(data => {console.log("here"), console.log(data);
    	this.setState( {results: {items: data['items']}, name: data['name']})
  })
}

  render() {
  	var songs = [];
  	this.state.results["items"].forEach((element) =>  {
  		// console.log(element);
  		console.log(element["file"]);
  		songs.push(<SongElement yt={element["yt"]}
    	  song_name={element["name"]}
    	  artists={element["artists"]}
    		key={element["yt"]}
    		image={element["img"]}
    	  file={element["src"]}
        id_no={element["id"]} 
        place="playlists"/>
      )
  	}
    )

   	return (
   		<div>
        <p>{this.state.name}</p>
   			{songs}

   		</div>
  	)
  }
}

ReactDOM.render(
  <SongsIndex />,
  document.getElementById("root")
);