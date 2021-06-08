import React from 'react';
import ReactDOM from 'react-dom';
import PropTypes from 'prop-types';
import getData from './../js_helpers/getcomms'; 
import * as bulma from './../../../assets/stylesheets/application.scss';
import DatabaseResult from './database_result';

class DatabaseSearch extends React.Component {
	constructor(props) {
    super(props);
    this.state = { 
    	q: '',
    	items: {items: []}
    };
    this.handleChange = this.handleChange.bind(this);
    this.handleSubmit = this.handleSubmit.bind(this);
  }

  componentDidMount() {
	}

	handleSubmit() {
		var uri =  "/search_db?q[song_name_cont]=" + encodeURI(this.state.q)
		getData(uri)
		.then(data => {this.setState({items: data}), console.log(data)})
	}

	handleChange(e) {
		this.setState({q: e.target.value})
	}

  render() {
  	var songs = [];
  	this.state.items['items'].forEach((e) => {
  		songs.push(
  			<DatabaseResult artist={e.artists} yt={e.img} song_name={e.name} source={e.src} id_no={e.id}/>
  		)
  	})

   	return (
   		<div>
	  		<div className="columns is-mobile py-3">
	  			<div className="column">
            <div className="columns is-centered-middle">
            	<div className="field has-addons">
              	<div className="control">
									<input onChange={this.handleChange} type="text" id="query" name="query" placeholder="Search Database" className="input is-8" ></input>
            		</div>
            		<div className="control">
            			<input className="button is-centered-middle is-2 is-primary input" type="submit" value="Search" onClick={this.handleSubmit}></input>
            		</div>
            	</div>
            </div>
	  			</div>
	  		</div>
	  		{songs}
   		</div>
  	)
  }
}

ReactDOM.render(
  <DatabaseSearch />,
  document.getElementById("dbs")
);