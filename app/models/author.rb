class Author < ApplicationRecord
  has_many :books

  validates :name, presence: true
  validates :name, uniqueness: true

  # def self.no_books(authors)
  #   authors = Author.all
  #   authors.select { |a| a.books.empty? }
  # end

end
