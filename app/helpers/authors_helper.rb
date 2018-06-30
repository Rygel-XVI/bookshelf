module AuthorsHelper

  def empty(authors)
    binding.pry
    authors = Author.all
    authors.select {|a| a.books.empty}
  end

end
