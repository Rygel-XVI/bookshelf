module AuthorsHelper

  # def empty(authors)
  #   binding.pry
  #   authors = Author.all
  #   authors.select {|a| a.books.empty}
  # end

  # Returns the authors name
  # Need to input variable because used in partials
  def author_name(author)
    author.name
  end

  # Returns true or false if the author has any books associated with it
  # Need to input variable because used in partials
  def no_books?(author)
    author.books.empty?
  end

end
