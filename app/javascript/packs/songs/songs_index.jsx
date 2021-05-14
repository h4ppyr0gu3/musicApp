import React from 'react';
import ReactDOM from 'react-dom';
import PropTypes from 'prop-types';
import getData from './../js_helpers/getcomms'; // takes url and json data that it submits, returns data async
import * as bulma from './../../../assets/stylesheets/application.scss';
import SongElement from './song_element_confirmed';

class SongsIndex extends React.Component {
	constructor(props) {
    super(props);
    this.state = { results: {items: []}
    };
  }

  componentDidMount() {
  	console.log("all mounted");
    var data = {page: 1};
    getData("/all_songs", data)
    .then(data => {console.log(data);
    	this.setState( {results: data})
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
        status={element["status"]}
        id_no={element["id"]} 
        place="songs"/>
      )
  	}
    )

   	return (
   		<div>
   			{songs}

   		</div>
  	)
  }
}

ReactDOM.render(
  <SongsIndex />,
  document.getElementById("root")
);