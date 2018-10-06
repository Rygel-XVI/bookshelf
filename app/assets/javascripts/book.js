function Book(title, word_count, description, status, author_id, number, id) {
  this.title = title;
  this.wordCount = word_count;
  this.description = description;
  this.status = status;
  this.author_id = author_id;
  this.number = number;
  this.id = id;
}

Book.prototype.addToList = () => {
  // console.log("in the function")
  debugger; //currently have to refilter to get it to show up.
  const current_filter = $('#filter').data('filter')  //gives filter name
  if (this.status == current_filter) {
    debugger;
    // add to list
    // $('#book-list').append()
  }
  debugger;
}

// function Parent(gender){
//   this.gender = gender;
// }
//
// // Attach the common function to prototype.
//
// Parent.prototype.yellAtChild = function(){
//   console.log('Somebody gonna get a hurt real bad!');
// };

function toggleCreateButtons() {
  $('.create-book-form').show();
  $('.create-btn').hide();
}

function addCreateBookListener(){
  $('form#new_book').submit(function(e) {
    e.preventDefault();
    var posting = $.post('/admin/books', $(this).serialize());
    posting.done(function(response){
      // debugger; //gives json object YEAY!!
      var newBook = new Book(response);
      console.log(newBook)
      newBook.addToList();
    });
  });
}

$(function() {
  if ($('.create-btn')) {
    // add a get to the admin/books/new || new_admin_book_path to get @book
    $('.create-btn').on('click', function() {
      toggleCreateButtons()
      addCreateBookListener()
    });
  };
});
