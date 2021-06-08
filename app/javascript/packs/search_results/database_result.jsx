import React from 'react';
import ReactDOM from 'react-dom';
import postData from './../js_helpers/comms';
import Notification from './../js_helpers/notification';

class DatabaseResult extends React.Component {

  constructor(props) {
    super(props);
    this.state = {clicked: false,
      data: {something: "nil"}};
      this.handleSubmit = this.handleSubmit.bind(this);
  }

  handleSubmit() {
    var data = {id: this.props.id_no}
    postData('/create_tracks', data)
    this.setState({clicked: !this.state.clicked})
  }

  render() {
    if (this.state.clicked == true) {
      var notification = <Notification message="Added to tracks" colour="success"/>
    }
    return(
      <div>
        <div className="columns">
          <div className="column">
            <img className="" src={this.props.yt}/>
          </div>
          <div className="column">
            <div className="columns">
              <div className="column">
                <p> {this.props.song_name}</p>
              </div>
              <div className="column">
                <p> {this.props.artist}</p>
              </div>
            </div>
            <div className="columns">
              <div className="column">
                <a className="button" href={this.props.source}>Download</a>
              </div>
              <div className="column">
                <a className="button" onClick={this.handleSubmit}>Add to tracks</a>
              </div>
            </div>
            <div className="columns">
              <div className="column">
              {notification}
              </div>
            </div>
          </div>
        </div>
       {/* <div className="columns">
          <div className="column is-centered-middle">
            <button type="button" value="Download" className="button is-centered-middle" onClick={this.handleClick}>Download</button>
          </div>
        </div>
        {notification}*/}
      </div>
    )
  }
}


export default DatabaseResult