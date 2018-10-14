
function getAuthors() {
  fetch("/authors.json")
  .then(response => response.json())
  .then(json => addAuthors(json))
}

function addAuthors(json) {
  var authorsTemplate = Handlebars.compile(document.getElementById('authors-template').innerHTML)
  var authorsDiv = $('.authors')

  authorsDiv.append(authorsTemplate(json))
  addListeners();
}

function addListeners() {
  $('button#display-books').on("click", function(e) {
    getBooks(e.target)
  });

  $('button#show-page').on("click",function(e) {
  });
}

function getBooks(target) {
  var id = target.dataset['id'] //id
  $.get(`/author/${id}/book_data.json`, function(data) {
    $ul = $(`.show-books[data-author-id=${id}]`)
    $ul.empty()
    if (data.length > 0) {
      // clear area before adding. make a hide section. add link to book page.
      var bookTemplate = Handlebars.compile(document.getElementById('book-details-template').innerHTML)
      $ul.append(bookTemplate(data))
    } else {
      $ul.append("No Books Available")
    };
  });
}


function showBooks(json) {
  debugger;
  $ul = $(`.show-books[data-author-id=${id}]`)
  debugger;
  if (json.length > 0) {

  } else {
    $ul.append("No Books Available")
  }
}

$(function() {
  getAuthors();
})
