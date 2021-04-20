import React from 'react';
import ReactDOM from 'react-dom';
import postData from './comms';
import SongConfirm from './song_confirm';
import * as more from '../../assets/images/more-options.svg'
import MoreOptionsTracks from './more_options_tracks';


class SongElement extends React.Component {
	constructor(props) {
		super(props);
		this.state = {
      handleAdd: 0,
      Artists: 0,
      more: false
    }
    this.handleSubmit = this.handleSubmit.bind(this);
    // this.handleAdd = this.handleAdd.bind(this);
    // this.handleDownload = this.handleDownload.bind(this);
    this.onclickmore = this.onclickmore.bind(this);
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
  }

  onclickmore() {
    console.log("more options");
    this.setState({more: !this.state.more });
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
    }
    if (this.state.more == true) {
      var options = (<div className="column">
          <MoreOptionsTracks file={this.props.file} id_no={this.props.id_no} place={this.props.place}/>
          </div>)
    }
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
            <svg onClick={ this.onclickmore } version="1.1" x="0px" y="0px" viewBox="0 0 122.88 122.88" className="icon">
              <path d="M61.44,0c16.96,0,32.33,6.88,43.44,18c11.12,11.12,18,26.48,18,43.44s-6.88,32.33-18,43.44c-11.12,11.12-26.48,18-43.44,18 c-16.96,0-32.33-6.88-43.44-18C6.88,93.77,0,78.41,0,61.44C0,44.48,6.88,29.12,18,18C29.11,6.88,44.47,0,61.44,0L61.44,0z M61.44,92.3c-3.99,0-7.23-3.24-7.23-7.22s3.24-7.22,7.23-7.22c3.99,0,7.23,3.24,7.23,7.22C68.67,89.07,65.43,92.3,61.44,92.3 L61.44,92.3L61.44,92.3z M61.44,43.99c-3.99,0-7.23-3.23-7.23-7.22c0-3.99,3.24-7.22,7.23-7.22c3.99,0,7.23,3.23,7.23,7.22 S65.43,43.99,61.44,43.99L61.44,43.99L61.44,43.99z M61.44,68.15c-3.99,0-7.23-3.24-7.23-7.22c0-3.99,3.24-7.22,7.23-7.22 c3.99,0,7.23,3.24,7.23,7.22C68.67,64.91,65.43,68.15,61.44,68.15L61.44,68.15L61.44,68.15z M97.67,25.2 C88.4,15.93,75.59,10.2,61.44,10.2c-14.15,0-26.96,5.74-36.23,15.01C15.93,34.48,10.2,47.29,10.2,61.44 c0,14.15,5.74,26.96,15.01,36.24c9.27,9.27,22.08,15.01,36.24,15.01s26.96-5.74,36.23-15.01c9.27-9.27,15.01-22.08,15.01-36.24 C112.68,47.29,106.95,34.48,97.67,25.2L97.67,25.2z"> </path>
            </svg>
          </div>
          {options}
        </div>
      </div>
      )
    }
	}


export default SongElement
