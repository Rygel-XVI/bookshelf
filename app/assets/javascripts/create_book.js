// Book obj constructor
function Book(obj) {
  this.title = obj.title;
  this.wordCount = obj.word_count;
  this.description = obj.description;
  this.status = obj.status;
  this.author_id = obj.author_id;
  this.number = obj.number;
  this.id = obj.id;
}

// adds the book to the end fo the filter if appropriate utilizing a handlebars template
Book.prototype.addToList = function() {
  const current_filter = $('#filter').data('filter')  //gives filter name

  // if the filter is 'All' or matches the book status then append to the list
  if (this.status == current_filter || current_filter == "All") {
    var bookTemplate = Handlebars.compile(document.getElementById('book-template').innerHTML)

    var $bookUl = $('#book-list')
    $bookUl.append(bookTemplate(this))

    // if the filter is currently 'All' add the status
    if (current_filter == "All") {
      $('#book-list li:last p').append(` - ${this.status}`)
    };

  };
}

// tuggles whether the book form button and create button are visible
function toggleCreateButtons() {
  $('.create-book-form').toggle();
  $('.create-btn').toggle();
}

// creates listener for submitting the .create-book-form and the function for posting the book
function addCreateBookListener() {
  $newBookForm = $('form#new_book')
  $newBookForm.on('submit', function(e) {
    e.preventDefault();

// posts to admin/books
    var posting = $.post('/admin/books', $(this).serialize());
    posting.done(function(response){

// create a new JS book object and add it to the DOM
      var newBook = new Book(response);
      newBook.addToList();

// change the visibility of the buttons
      toggleCreateButtons();

// allow the form to be resubmitted
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
