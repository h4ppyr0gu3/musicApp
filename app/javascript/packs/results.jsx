import React from 'react';
import ReactDOM from 'react-dom';
import Video from './embedded';
import * as bulma from './../../assets/stylesheets/application.scss';
import Download from './download';


class Results extends React.Component {
  constructor(props) {
    super(props);
    this.state = {embed: false,
                  download_form: false};
  }

  componentDidMount() {
    console.log("results mounted");
  }

  render() {
    var source = "https://www.youtube.com/embed/" + this.props.videoUrl;
    var video;
    var download;
    this.state.embed ? video = <Video source={source} key={source}/> : video = ''
    this.state.download_form ? download = <Download thumbnailUrl={this.props.thumbnailUrl} key={this.props.videoUrl} videoUrl={this.props.videoUrl} /> : download = ''


    return(

      <div className="columns is-centered-middle" >
        <div className="column is-8">
          <div className="box py-5 my-5">
            <div className="columns">
              <div className="column is-centered-middle">
                <p>{this.props.name}</p>
              </div>
            </div>
            <div className="columns">
              <div className="column is-centered-middle">
                <div className="is-centersed-middle field is-grouped">
                  <p className="control">
                    <input type="button" value="DOWNLOAD" className="button" onClick={() => this.setState({download_form: !this.state.download_form})}></input>
                  </p>
                  <p className="control">
                    <input className="button" type="button" value="PLAY" onClick={() => this.setState({embed: !this.state.embed})}></input>
                  </p>
                </div>
              </div>
            </div>
            <div className="columns">
              <div className="column is-centered-middle">
                {download}
              </div>
            </div>
            <div className="columns">
              <div className="column is-centered-middle">
                {video}
              </div>
            </div>
          </div>
        </div>
      </div>
    )
  }
}

export default Results