function Book(obj) {
  this.title = obj.title;
  this.wordCount = obj.word_count;
  this.description = obj.description;
  this.status = obj.status;
  this.author_id = obj.author_id;
  this.number = obj.number;
  this.id = obj.id;
}

Book.prototype.addToList = function() {
  const current_filter = $('#filter').data('filter')  //gives filter name
  if (this.status == current_filter || current_filter == "All") {
    // add to list
    $('ul#book-list').append(document.createElement("li"));
    $('ul#book-list li:last').attr("data-id", this.id);
    $('ul#book-list li:last').append(document.createElement("p"))

    $('ul#book-list li:last p').html(`<a href='/books/${this.id}'>${this.title}</a>`)

    if (current_filter == "All") {
      $('ul#book-list li:last p').append(` - ${this.status}`)
    };

  };
}


function toggleCreateButtons() {
  $('.create-book-form').toggle();
  $('.create-btn').toggle();
}

function addCreateBookListener() {
  $newBookForm = $('form#new_book')
  $newBookForm.on('submit', function(e) {
    e.preventDefault();

    var posting = $.post('/admin/books', $(this).serialize());
    posting.done(function(response){

      var newBook = new Book(response);
      newBook.addToList();

      toggleCreateButtons();

      $('form#new_book input[type=submit]').removeAttr("disabled")
      addCreateButtonListener();
    });
  });
}

// Clears the create book form
function addClearFormListener() {
  $('#clear-form').on('click', function(e) {
    $('form#new_book')[0].reset();
  })
}

// Make create button listener if the button exists
function addCreateButtonListener() {
  if ($('.create-btn')) {
    $('.create-btn').on('click', function(e) {
      toggleCreateButtons();
      $('.create-btn').unbind('click') //allows for resubmitting
    });
  };
}

$(function() {
  addCreateBookListener(); //has to stay here so it doesn't end up double submitting
  addCreateButtonListener();
  addClearFormListener();
});
