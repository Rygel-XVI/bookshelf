
// gets the json for the author header and appends it to the DOM
function getAuthor(){
  $('#author-header').empty()
  var id = $('#author-header').data("id") //author-id
  $.get(`/author/${id}/author_data`, function(json){
    $('#author-header').append(`<h1>${json["name"]}</h1>`)
  })

  // if the user is an admin then add an edit link
  if ($('#edit-author').data("admin")) {
    $('#edit-author').append(`<a href="/admin/authors/${id}/edit">Edit This Author</a>`)
  };
}

// Obtain and append the author's books to the DOM
function getBooks(){
  var id = $('#author-header').data("id") //author's id
  $.get(`/author/${id}/book_data.json`, function(data) {
    $ul = $(`.show-books`)
    $ul.empty()
    if (data.length > 0) {

      // clear area before adding. make a hide section. add link to book page.
      var bookTemplate = Handlebars.compile(document.getElementById('book-template').innerHTML)
      $ul.append(bookTemplate(data))
    } else {
      $ul.append("No Books Available")
    };
  });

}


$(function() {
  getAuthor();
  getBooks();
})
