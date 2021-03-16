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
  var column = document.createElement("div");
  var element = document.createElement("div");
  var header = document.createElement("div");
  var card_image = document.createElement("div");
  var card_content = document.createElement("div");
  var card_footer = document.createElement("div");
  var image = document.createElement("img");
  var title = document.createElement("h1");
  var description = document.createElement("p");
  var form = document.createElement("form");
  var video = document.createElement("input");
  var download = document.createElement("input");

  column.classList.add(["column"], ["is-4"]);
  element.classList.add(["card"], ["p-5"], ["mx-5"]);
  header.classList.add(["card-header"]);
  download.classList.add(["button"]);
  card_image.classList.add(["card-image"], ["is-centered-middle"]);
  card_content.classList.add(["card-content"]);
  card_footer.classList.add(["card-footer"], ["is-centered-middle"]);

  form.action = "songs";
  form.method = "POST";
  // form.method = POST;
  video.type = "hidden";
  video.name = "video";
  video.id = "video";
  video.value = data["id"]["videoId"];
  // download.textContent = "download";
  download.value = "Download";
  download.type = "submit";
  title.textContent = data["snippet"]["title"];
  // description.textContent = data["snippet"]["description"];
  image.src = data["snippet"]["thumbnails"]["default"]["url"];

  column.appendChild(element);
  element.appendChild(header);
  header.appendChild(title);
  element.appendChild(card_image);
  card_image.appendChild(image);
  element.appendChild(card_content);
  card_content.appendChild(description);
  element.appendChild(card_footer);
  card_footer.appendChild(form);
  form.appendChild(video);
  form.appendChild(download);


	return column;
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
