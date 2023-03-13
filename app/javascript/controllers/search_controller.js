import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = [ "q" ];

    lookupParticipants(event) {
	
	let url = '../participants/search.json?q=' + this.qTarget.value;
	let participants = fetch(url)
	    .then(response => response.json())
	    .then(data => this.display(data));
    }
    
    display(data) {
	let results = document.getElementById('site-search-results');
	results.textContent = null;
	data.forEach(function(obj) {
	    let li = document.createElement('li');
	    let a = document.createElement('a');
	    a.setAttribute('href','../participants/' + obj.id);
	    a.innerHTML = obj.label;
	    
	    li.appendChild( a );
	    results.appendChild( li );
	});
	    
    }
    
    connect() {
	//this.element.textContent = "Hello World!"
	//console.log('Hello from stimulus!');
	
    }
}
