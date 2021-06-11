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
      name: '',
      users: []
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
    	this.setState( {results: {items: data['items']}, name: data['name'], users: data['users']})
    })
  }

  handleClick() {
    var pathname = window.location.pathname;
    var a = pathname.split("/")
    var playlist_id = a[3];
    window.location.href = '/friends/playlists/' + playlist_id
  }

  render() {
    var users = [];
    this.state.users.forEach((element) => {
      users.push(
        <>
        <div class="column">
          <p class="is-size-7">{element["first_name"]}</p>
          <p class="is-size-7">{element["last_name"]}</p>
        </div>
        </>
      )
    })
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
        <div class="columns">
          <div class="column">
            <p className="is-size-3">{this.state.name}</p>
          </div>
          <div class="column">
            <button class="button is-success" onClick={this.handleClick}>Add Friends</button>
          </div>
        </div>
        <div class="columns">
          <div class="column">
            <p class="is-size-6">Members:</p>
          </div>
        {users}
        </div>
   			{songs}
   		</div>
  	)
  }
}

ReactDOM.render(
  <SongsIndex />,
  document.getElementById("root")
);