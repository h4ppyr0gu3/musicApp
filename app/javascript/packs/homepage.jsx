import React from 'react';
import ReactDOM from 'react-dom';
import PropTypes from 'prop-types';
import postData from './comms'; // takes url and json data that it submits, returns data async
import Results from './results';
import * as bulma from './../../assets/stylesheets/application.scss';


class Search extends React.Component {
	constructor(props) {
    super(props);
    this.state = {
      submitted: '',
      results: {"items": []}
    };
  }

  componentDidMount() {
    console.log('asd');
  }

  renderResults() {
      return <Results /> ;
    }

  onSubmit = (e) => { 
    e.preventDefault();  // Here we prevent the default browser behavior
    this.setState({submitted: true}, () => {
    console.log(this.state.submitted);
    console.log(e.target.query.value);
    console.log("something searched");
    var query = '';
    query = {"query": e.target.query.value}
    postData("/search_music", query)
    .then(data => {console.log(data);
    var x = data;
    this.setState({results: x});
    })
   }); 
  }

  decodeHtml(html) {
    var txt = document.createElement("textarea");
    txt.innerHTML = html;
    return txt.value;
	}

  render() {
    var searchResults = [];
    this.state.results["items"].forEach((element) =>  {
      if(element == "") return;
      console.log(element["snippet"]);
      console.log(element["snippet"]["thumbnails"]["medium"]["url"]);
      searchResults.push(<Results name={this.decodeHtml(element["snippet"]["title"])} videoUrl={element["id"]["videoId"]} 
      key={element["id"]["videoId"]} thumbnailUrl={element["snippet"]["thumbnails"]["medium"]["url"]} />)
    })

   	return (
   		<div className="container">
	  		<div className="columns is-mobile">
	  			<div className="column">
	  				<form onSubmit={this.onSubmit}>
	            <div className="columns is-centered-middle">
	            	<div className="field has-addons">
	              	<div className="control">
										<input /*onChange={this.handleChange}*/ type="text" id="query" name="query" placeholder="Search" className="input is-8" ></input>
	            		</div>
	            		<div className="control">
	            			<input className="button is-centered-middle is-2 is-primary input" type="submit" value="Search"></input>
	            		</div>
	            	</div>
	            </div>
	  				</form>
	  				<ul>
	        		{ searchResults }
	        	</ul>
	  			</div>
	  		</div>
	  	</div>
  	)
  }
}

ReactDOM.render(
  <Search />,
  document.getElementById("root")
);

