import React from 'react';
import ReactDOM from 'react-dom';
import PropTypes from 'prop-types';
import getData from './../js_helpers/getcomms'; // takes url and json data that it submits, returns data async
import deleteData from './../js_helpers/deletecomms'; // takes url and json data that it submits, returns data async
import postData from './../js_helpers/comms'; // takes url and json data that it submits, returns data async
import Notification from './../js_helpers/notification'; // takes url and json data that it submits, returns data async
import * as bulma from './../../../assets/stylesheets/application.scss';


class SongsIndex extends React.Component {
	constructor(props) {
    super(props);
    this.state = {
      response: {playlists: []},
      add: false,
      playlist_name: ''
    };
    this.handleDelete = this.handleDelete.bind(this);
    this.handleEdit = this.handleEdit.bind(this);
    this.handleNew = this.handleNew.bind(this);
    this.handlePlaylist = this.handlePlaylist.bind(this);
    this.handleChange = this.handleChange.bind(this);
    this.handleAdd = this.handleAdd.bind(this);
    this.handleUpdate = this.handleUpdate.bind(this);
  }

  componentDidMount() {
    getData('/playlists/playlists_api').then(data =>{console.log(data), this.setState({response: data}),
      this.state.response['playlists'].forEach((element) => {
        this.setState({[element['playlist_id']]: false})
      })
    })
  }

  handleDelete(playlist_id, e) {
    console.log("delete");
    console.log(playlist_id);
    var url = "/playlists/playlists/" + playlist_id.toString();
    var data = {id: playlist_id}; 
    deleteData(url, data).then(data => console.log(data));
  }

  handleEdit(playlist_id, e) {
    this.setState({[playlist_id]: !this.state.[playlist_id]})
  }

  handlePlaylist(playlist_id, e) {
    console.log("playlist");
    var url = 'playlists/' + playlist_id.toString()
    window.location.replace(url);
  }

  handleNew() {
    console.log(this.state.add);
    this.setState({add: !this.state.add});
  }

   handleChange(event) {
    this.setState({value: event.target.value});
  }

  handleAdd() {
    var data = {name: this.state.value};
    postData('/playlists/playlists', data).then(data => console.log(data));
  }

  handleUpdate(playlist_id, e) {
    var data = {
      id: playlist_id,
      name: this.state.value
    }; 
    postData('/playlists/update_playlist', data).then(data => console.log(data));
  }


  render() {
    var playlists = [];
    var a = 1;
    this.state.response['playlists'].forEach((element) =>  {
    var source = "https://source.unsplash.com/random/200x200?sig=" + a
    var edit;
    if (this.state.[element['playlist_id']] == true) {
      edit = (
        <div>
          <form>
            <div class="field">

              <div class="control">
                <input class="input" type="text" placeholder="Playlist name" onChange={this.handleChange}/>
              </div>
            </div>
            <div class="field">
              <div class="control">
                <button class="button is-link" onClick={this.handleUpdate.bind(this, element["playlist_id"])}>Submit</button>
              </div>
            </div>
          </form>
        </div>

      )
    }
    playlists.push(
    <div class="column is-narrow">
      <div class="card">
        <div onClick={this.handlePlaylist.bind(this, element["playlist_id"])}>
          <img src={source}/>
        </div>
        <div onClick={this.handlePlaylist.bind(this, element["playlist_id"])}>
          <p>{element['name']}</p>
        </div>
        <div >
          <a class="icon" onClick={this.handleEdit.bind(this, element["playlist_id"])}>
            <svg version="1.1" id="Layer_1" x="0px" y="0px" viewBox="0 0 122.88 122.88" ><g><path d="M61.44,0c16.97,0,32.33,6.88,43.44,18c11.12,11.12,18,26.48,18,43.44c0,16.97-6.88,32.33-18,43.44 c-11.12,11.12-26.48,18-43.44,18S29.11,116,18,104.88C6.88,93.77,0,78.41,0,61.44C0,44.47,6.88,29.11,18,18 C29.11,6.88,44.47,0,61.44,0L61.44,0z M77.05,36.16c-0.6-0.56-1.28-0.85-2.05-0.81c-0.77,0-1.45,0.3-2.01,0.9l-4.53,4.7L81.15,53.2 l4.57-4.78c0.56-0.55,0.77-1.28,0.77-2.05c0-0.77-0.3-1.49-0.85-2.01L77.05,36.16L77.05,36.16L77.05,36.16z M53.31,82.11 c-1.67,0.56-3.37,1.07-5.04,1.62c-1.67,0.56-3.33,1.11-5.04,1.67c-3.97,1.28-6.15,2.01-6.62,2.14c-0.47,0.13-0.17-1.71,0.81-5.55 l3.16-12.09l0.26-0.27L53.31,82.11L53.31,82.11L53.31,82.11L53.31,82.11z M45.45,64.83L65.04,44.5l12.68,12.21L57.92,77.3 L45.45,64.83L45.45,64.83z M101.08,21.8C90.93,11.66,76.92,5.39,61.44,5.39S31.95,11.66,21.8,21.8 C11.66,31.95,5.39,45.96,5.39,61.44c0,15.48,6.27,29.49,16.42,39.64c10.14,10.14,24.16,16.42,39.64,16.42s29.49-6.27,39.64-16.42 c10.14-10.14,16.42-24.16,16.42-39.64C117.49,45.96,111.22,31.95,101.08,21.8L101.08,21.8z"/></g></svg>
          </a>
        </div>
        {edit}
        <div >
          <p>Songs: {element['song_count']}</p>
        </div>
        <div>
          <a class="icon" onClick={this.handleDelete.bind(this, element["playlist_id"])}>
            <svg version="1.1" id="Layer_1" x="0px" y="0px" viewBox="0 0 108.294 122.88" enable-background="new 0 0 108.294 122.88" ><g><path d="M4.873,9.058h33.35V6.2V6.187c0-0.095,0.002-0.186,0.014-0.279c0.075-1.592,0.762-3.037,1.816-4.086l-0.007-0.007 c1.104-1.104,2.637-1.79,4.325-1.806l0.023,0.002V0h0.031h19.884h0.016c0.106,0,0.207,0.009,0.309,0.022 c1.583,0.084,3.019,0.76,4.064,1.81c1.102,1.104,1.786,2.635,1.803,4.315l-0.003,0.021h0.014V6.2v2.857h32.909h0.017 c0.138,0,0.268,0.014,0.401,0.034c1.182,0.106,2.254,0.625,3.034,1.41l0.004,0.007l0.005-0.007 c0.851,0.857,1.386,2.048,1.401,3.368l-0.002,0.032h0.014v0.032v10.829c0,1.472-1.195,2.665-2.667,2.665h-0.07H2.667 C1.195,27.426,0,26.233,0,24.762v-0.063V13.933v-0.014c0-0.106,0.004-0.211,0.018-0.315v-0.021 c0.089-1.207,0.624-2.304,1.422-3.098l-0.007-0.002C2.295,9.622,3.49,9.087,4.81,9.069l0.032,0.002V9.058H4.873L4.873,9.058z M77.79,49.097h-5.945v56.093h5.945V49.097L77.79,49.097z M58.46,49.097h-5.948v56.093h5.948V49.097L58.46,49.097z M39.13,49.097 h-5.946v56.093h5.946V49.097L39.13,49.097z M10.837,31.569h87.385l0.279,0.018l0.127,0.007l0.134,0.011h0.009l0.163,0.023 c1.363,0.163,2.638,0.789,3.572,1.708c1.04,1.025,1.705,2.415,1.705,3.964c0,0.098-0.009,0.193-0.019,0.286l-0.002,0.068 l-0.014,0.154l-7.393,79.335l-0.007,0.043h0.007l-0.016,0.139l-0.051,0.283l-0.002,0.005l-0.002,0.018 c-0.055,0.331-0.12,0.646-0.209,0.928l-0.007,0.022l-0.002,0.005l-0.009,0.018l-0.023,0.062l-0.004,0.021 c-0.118,0.354-0.264,0.698-0.432,1.009c-1.009,1.88-2.879,3.187-5.204,3.187H18.13l-0.247-0.014v0.003l-0.011-0.003l-0.032-0.004 c-0.46-0.023-0.889-0.091-1.288-0.202c-0.415-0.116-0.818-0.286-1.197-0.495l-0.009-0.002l-0.002,0.002 c-1.785-0.977-2.975-2.882-3.17-5.022L4.88,37.79l-0.011-0.125l-0.011-0.247l-0.004-0.116H4.849c0-1.553,0.664-2.946,1.707-3.971 c0.976-0.955,2.32-1.599,3.756-1.726l0.122-0.004v-0.007l0.3-0.013l0.104,0.002V31.569L10.837,31.569z M98.223,36.903H10.837 v-0.007l-0.116,0.004c-0.163,0.022-0.322,0.106-0.438,0.222c-0.063,0.063-0.104,0.132-0.104,0.179h-0.007l0.007,0.118l7.282,79.244 h-0.002l0.002,0.012c0.032,0.376,0.202,0.691,0.447,0.825l-0.002,0.004l0.084,0.032l0.063,0.012h0.077h72.695 c0.207,0,0.399-0.157,0.518-0.377l0.084-0.197l0.054-0.216l0.014-0.138h0.005l7.384-79.21L98.881,37.3 c0-0.045-0.041-0.111-0.103-0.172c-0.12-0.118-0.286-0.202-0.451-0.227L98.223,36.903L98.223,36.903z M98.334,36.901h-0.016H98.334 L98.334,36.901z M98.883,37.413v-0.004V37.413L98.883,37.413z M104.18,37.79l-0.002,0.018L104.18,37.79L104.18,37.79z M40.887,14.389H5.332v7.706h97.63v-7.706H67.907h-0.063c-1.472,0-2.664-1.192-2.664-2.664V6.2V6.168h0.007 c-0.007-0.22-0.106-0.433-0.259-0.585c-0.137-0.141-0.324-0.229-0.521-0.252h-0.082h-0.016H44.425h-0.031V5.325 c-0.213,0.007-0.422,0.104-0.576,0.259l-0.004-0.004l-0.007,0.004c-0.131,0.134-0.231,0.313-0.259,0.501l0.007,0.102V6.2v5.524 C43.554,13.196,42.359,14.389,40.887,14.389L40.887,14.389z"/></g></svg>
          </a>
        </div>
      </div>
    </div>
    )
    a++;
    })
    var add;
    if (this.state.add == true) {
      add = (
      <div class="column is-narrow">
        <div class="card">
          <img src="https://picsum.photos/200"/>
          <form>
            <div class="field">

              <div class="control">
                <input class="input" type="text" placeholder="Playlist name" onChange={this.handleChange}/>
              </div>
            </div>
            <div class="field">
              <div class="control">
                <button class="button is-link" onClick={this.handleAdd}>Submit</button>
              </div>
            </div>
          </form>
        </div>
      </div>
      )
    }

    
   	return (
     <div>
      <div class="level">
        <div class="level-left">
          <p class="is-size-3"> Playlists</p>
        </div>
        <div class="level-right">
          <div onClick={this.handleNew}>
            <div class="icon">
             <button class="button is-success">
              <span class="icon is-small">
              <svg version="1.1" id="Layer_1" x="0px" y="0px" viewBox="0 0 122.879 122.88" enable-background="new 0 0 122.879 122.88"><g><path d="M17.995,17.995C29.992,5.999,45.716,0,61.439,0s31.448,5.999,43.445,17.995c11.996,11.997,17.994,27.721,17.994,43.444 c0,15.725-5.998,31.448-17.994,43.445c-11.997,11.996-27.722,17.995-43.445,17.995s-31.448-5.999-43.444-17.995 C5.998,92.888,0,77.164,0,61.439C0,45.716,5.998,29.992,17.995,17.995L17.995,17.995z M57.656,31.182 c0-1.84,1.492-3.332,3.333-3.332s3.333,1.492,3.333,3.332v27.383h27.383c1.84,0,3.332,1.492,3.332,3.332 c0,1.841-1.492,3.333-3.332,3.333H64.321v27.383c0,1.84-1.492,3.332-3.333,3.332s-3.333-1.492-3.333-3.332V65.229H30.273 c-1.84,0-3.333-1.492-3.333-3.333c0-1.84,1.492-3.332,3.333-3.332h27.383V31.182L57.656,31.182z M61.439,6.665 c-14.018,0-28.035,5.348-38.731,16.044C12.013,33.404,6.665,47.422,6.665,61.439c0,14.018,5.348,28.036,16.043,38.731 c10.696,10.696,24.713,16.044,38.731,16.044s28.035-5.348,38.731-16.044c10.695-10.695,16.044-24.714,16.044-38.731 c0-14.017-5.349-28.035-16.044-38.73C89.475,12.013,75.457,6.665,61.439,6.665L61.439,6.665z"/></g></svg>
              </span>
              <span>New</span>
            </button>
            </div> 
          </div>
        </div>
      </div>

      <div class="columns is-multiline is-centered">
        {add}
        {playlists}


      </div>
    </div>
  	)
  }
}

ReactDOM.render(
  <SongsIndex />,
  document.getElementById("root")
);