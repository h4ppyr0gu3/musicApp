var query = '';
var load_json = document.getElementById("load_json");


document.getElementById("search_form").onsubmit = function(event){

	get_res(event);
};

function get_res(event) {
	event.preventDefault();
	query = { "query": event.target.children[1].value };
	post_response(query);
}

function removeAllChildNodes(parent) {
    while (parent.firstChild) {
        parent.removeChild(parent.firstChild);
    }
}

function post_response(query) {

	postData("/search_music", query).then(data => {
		removeAllChildNodes(load_json);
		
    console.log(data);
    data["items"].forEach((element) => {
    	load_json.appendChild(
    		create_element(
    			element
    		)
    	);
    })
  });
}

function create_element(data) {
	console.log(data);
  var element = document.createElement("div");
  var image = document.createElement("img");
  var title = document.createElement("h1");
  var description = document.createElement("p");
  var form = document.createElement("form");
  var video = document.createElement("input");
  var download = document.createElement("input");

  // form.action = "";
  video.type = "hidden";
  video.value = data["id"]["videoId"];
  // download.textContent = "download";
  download.value = "Download";
  download.type = "submit";
  title.textContent = data["snippet"]["title"];
  description.textContent = data["snippet"]["description"];
  image.src = data["snippet"]["thumbnails"]["default"]["url"];

  element.appendChild(title);
  element.appendChild(image);
  element.appendChild(description);
  element.appendChild(form);
  form.appendChild(video);
  form.appendChild(download);


	return element;
}

async function postData(url = '', data = {}) {
  const response = await fetch(url, {
    method: 'POST', 
    mode: 'cors',
    cache: 'no-cache',
    credentials: 'same-origin',
    headers: {
      'Content-Type': 'application/json'
    },
    redirect: 'follow',
    referrerPolicy: 'no-referrer',
    body: JSON.stringify(data)
  });
  return response.json();
}
