import React from 'react';
import ReactDOM from 'react-dom';
import * as bulma from './../../assets/stylesheets/application.scss';
import postData from './comms'; // takes url and json data that it submits, returns data async
// import Playlist from 'react-mp3-player';

class Player extends React.Component {
	constructor(props) {
    super(props);
    this.state = { items: [{src: ''}]}
    // this.getCookie = this.getCookie.bind(this);
  }

  getCookie = (cname) => {
    var name = cname + "=";
    var decodedCookie = decodeURIComponent(document.cookie);
    var ca = decodedCookie.split(';');
    for(var i = 0; i <ca.length; i++) {
      var c = ca[i];
      while (c.charAt(0) == ' ') {
        c = c.substring(1);
      }
      if (c.indexOf(name) == 0) {
        return c.substring(name.length, c.length);
      }
    }
    return "";
  }

  componentDidMount() {
  	console.log("Prev");
    console.log(this.props);
    console.log(document.cookie);
    var x = this.getCookie("player");
    console.log(x);

    this.setState({items: x["items"]},
    console.log(this.state.items));

	}

  





  render() {
  	var player;
  	if (this.state.items[0]["src"] != null) {
  		player = <Playlist tracks={this.state.items} />
  	}
  	
   	return (
   		<div>
   		<span className="icon button"><i className="fas fa-play"></i></span>
   		{player}
      <p> owrpgihiwer[8h] </p>
   		</div>
  	)
  }
}

ReactDOM.render(
  <Player />,
  document.getElementById("player")
);
