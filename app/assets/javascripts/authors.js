
function getAuthors() {
  fetch("/authors.json")
  .then(response => response.json())
  .then(json => addAuthors(json))
}

function addAuthors(json) {
  var authorsTemplate = Handlebars.compile(document.getElementById('authors-template').innerHTML)
  var authorsDiv = $('.authors')

  authorsDiv.append(authorsTemplate(json))
}

function addListeners() {

  $('button#display-books').on("click", function(e) {
    getBooks(e.target)});

  $('button#show-page').on("click",function(e) {
  });
}

function getBooks(target) {
  var id = target.dataset['id'] //id
  fetch(`/author/${id}.json`)
  .then(response => function(response) {
    debugger;
    console.log(response.json())
  })
  // .then(json => console.log(json))
}

$(function() {
  getAuthors();
  addListeners();
})
