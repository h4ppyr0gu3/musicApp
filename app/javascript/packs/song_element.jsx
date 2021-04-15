import React from 'react';
import ReactDOM from 'react-dom';
import postData from './comms';
import SongConfirm from './song_confirm';
import * as more from '../../assets/images/more-options.svg'


class SongElement extends React.Component {
	constructor(props) {
		super(props);
		this.state = {
      handleAdd: 0,
      Artists: 0
    }
    this.handleSubmit = this.handleSubmit.bind(this);
    this.handleAdd = this.handleAdd.bind(this);
	}

  handleAdd() {
    var value = this.state.handleAdd;
    console.log(value);
    this.setState({handleAdd: value + 1});

  }

  handleSubmit(args) {
    args.preventDefault();
    var  artists = [];
    var album;
    var title = args.target.Title.value;
    for (var i = 0; i < this.state.Artists; i++) {
      var id = "Artist" + i;
      artists.push(args.target[id].value);
    }
    // console.log(artists);
    if (this.state.handleAdd != 0) {
      for (var i = 0; i < this.state.handleAdd; i++) {
        var id = "extraselect" + i;
        var value = "extra" + i;
        if (args.target[id].value == "Artist") {
          artists.push(args.target[value].value);
        } else if (args.target[id].value == "Featured Artist") {
          artists.push(args.target[value].value);
        } else if (args.target[id].value == "Album") {
          album = args.target[value].value
        }
      }
    }
    var data = {
      Artists: artists, 
      Album: album, 
      id: this.props.id_no,
      title: title
    }
    postData("/attributes", data).then(data => {console.log(data);})
  }

  componentDidMount() {
    var art = [];
    art = this.props.artists.split(', ');
    this.setState({Artists: art.length});
    var moreOptions = document.getElementById("more");
    moreOptions.addEventListener("click", 
    function() {console.log("moreOptions")});
  }

  render () {
    if (this.props.status == "pending") {
      var art = []
      art = this.props.artists.split(', ');
      var a = [];
      var counter = 0;
      if (this.state.handleAdd != 0) {
        var extra = [];
        for (var i = 0; i < this.state.handleAdd; i++) {
            var name = "extra" + i.toString();
            var select = "extraselect" + i.toString();
            extra.push(<SongConfirm name={name} select={select}/>)
          }
      }
      art.forEach((element) =>  {
        var name = "Artist" + counter.toString();
        a.push(<div class="field is-horizontal">
                <div class="field-label is-normal">
                  <label class="label">Artists</label>
                </div>
                <div class="field-body">
                  <div class="field">
                    <p class="control">
                      <input class="input" type="text" defaultValue={element} name={name}/>
                    </p>
                  </div>
                </div>
              </div>),
        counter ++;
      })
      
      return(
        <>
        <div className="columns">
          <div className="column is-1">
           <img src={this.props.image} ></img>
           </div>
           <div className="column">
           {this.props.yt}<br/>
           {this.props.artists}
           </div>
           </div>
           <div className="columns">
            <div className="column">
           <form onSubmit={this.handleSubmit} className="myForm">
              <div class="field is-horizontal">
                <div class="field-label is-normal">
                  <label class="label">Title</label>
                </div>
                <div class="field-body">
                  <div class="field">
                    <p class="control">
                      <input class="input" type="text" defaultValue={this.props.song_name} name="Title"/>
                    </p>
                  </div>
                </div>
              </div>
              {a}
              {extra}
              <div class="field is-grouped">
                <p class="control">
                    <input class="button is-light" type="button" value="Add Attributes" onClick={this.handleAdd} />
                </p>
                <p class="control">
                  <input class="button is-primary" type="submit" value="Confirm Attributes" />
                </p>
              </div>
              </form>
            </div>
          </div>

           </>
      )
    } else {
      return(
      <div>
        <div className="columns">
          <div className="column is-1">
           <img src={this.props.image} ></img>
          </div>
          <div className="column">
            <div className="is-size-7">
              <p> {this.props.song_name}</p>
              <p> {this.props.artists}</p>
            </div>
          </div>
          <div className="column">
            <img src={more} class="icon" id="more"/>
          </div>
        </div>
      </div>
      )
    }
	}
}

export default SongElement
