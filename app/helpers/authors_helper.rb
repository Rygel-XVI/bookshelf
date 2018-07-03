module AuthorsHelper

  # def empty(authors)
  #   binding.pry
  #   authors = Author.all
  #   authors.select {|a| a.books.empty}
  # end

  def author_name(author)
    author.name
  end

  def no_books?(author)
    author.books.empty?
  end

end
