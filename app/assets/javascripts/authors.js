// gets json for the authors via fetch
function getAuthors() {
  fetch("/authors.json")
  .then(response => response.json())
  .then(json => addAuthors(json))
}

// appends the json for each of the authors to the DOM
function addAuthors(json) {
  var authorsTemplate = Handlebars.compile(document.getElementById('authors-template').innerHTML)
  var $authorsDiv = $('.authors')
  $authorsDiv.empty();
  $authorsDiv.append(authorsTemplate(json))

  // calls addListeners to create listeners for the added elements
  addListeners();
}

// adds listeners to the newly created buttons
function addListeners() {
  $('button.display-books').on("click", function(e) {
    getBooks(e.target)
  });

  $('button.show-page').on("click",function(e) {
    showBook(e.target)
  });
}

// uses jQuery to get book json for the specified author
function getBooks(target) {
  var id = target.dataset['id'] //author-id
  $.get(`/author/${id}/book_data.json`, function(data) {

    // targets the <ul> for the specified author
    $ul = $(`.show-books[data-author-id=${id}]`)
    $ul.empty()

    // if author has books append them to the DOM
    if (data.length > 0) {

      var bookTemplate = Handlebars.compile(document.getElementById('book-details-template').innerHTML)
      $ul.append(bookTemplate(data))

      // calls function to set listeners for the show button for the books
      setBookListener($('button.show-description'));
    } else {
      $ul.append("No Books Available")
    };
  });

// toggles whether the user can see the book list or not after the data has been rendered
  $(`button.display-books[data-id=${id}]`).on('click', function() {
    $(`ul.show-books[data-author-id=${id}]`).toggle();
  });

}

// sets a listener so the user can toggle seeing the book description
function setBookListener($buttons) {
  $buttons.on('click', function(e){
    var id = e.target.dataset["id"];
    $(`.show-desc-paragraph[data-id=${id}]`).toggle();
  })
}

$(function() {
  getAuthors();
})
