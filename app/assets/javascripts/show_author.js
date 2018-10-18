function getAuthor(){
  $('#author-header').empty()
  var id = $('#author-header').data("id")
  $.get(`/author/${id}/author_data`, function(json){
    $('#author-header').append(`<h1>${json["name"]}</h1>`)
  })
  if ($('#edit-author').data("admin")) {
    $('#edit-author').append(`<a href="/admin/authors/${id}/edit">Edit This Author</a>`)
  };
}

function getBooks(){
  var id = $('#author-header').data("id")
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


// <h1><%= @author.name %></h1>
// <%= link_to "Edit this author", edit_admin_author_path(@author) if is_admin? %>
//
// <% else %>
//
//   <div class="show-books"></div>
//
//   <ul>
//   <% @books.each do |book| %>
//     <li>
//       <p><%= link_to "#{book.title}", book_path(book) %></p>
//     </li>
//   <% end %>
//   </ul>
