class Book < ApplicationRecord
  belongs_to :author
  has_many :user_books
  has_many :users, through: :user_books

  accepts_nested_attributes_for :author, reject_if: :all_blank
  accepts_nested_attributes_for :user_books, reject_if: :all_blank

  validates :author, :title, :word_count, :status, :number, presence: true
  validates_inclusion_of :status, in: ["Checked Out", "Available", "Not Available", "Graveyard"]

 scope :available, -> { where(status: "Available") }
 scope :checked_out, -> { where(status: "Checked Out") }
 scope :not_available, -> { where(status: "Not Available") }
 scope :graveyard, -> { where(status: "Graveyard") }

# Return the number of books with their title and increments it by 1
  def self.get_highest_number(title)
    book = Book.where(title: title).order(number: :desc).first
    !!book ? book.number + 1 : 1
  end

  def self.alphabetize(book_array)
    book_array.order(title: :asc)
  end

  def self.get_by_user_id(id)
    Book.find_by(id: id)
  end

  # In the future can implement multiple filters here
  def self.set_books_scope_to_status(status)
    case status
      when "Available"
        Book.available
      when "Not Available"
        Book.not_available
      when "Checked Out"
        Book.checked_out
      else
        Book.all
      end
  end

############## User Statistics

  def self.avg_words(books)
    words = 0
    if books.size > 0
      books.map {|book| words += book.word_count}
      words =  words/books.size
    else
      words
    end
  end

###### Determining if it can be moved between library and user

  def interactable?
    status == "Available" || status == "Checked Out"
  end


############### Deleting Books

  def can_destroy?
    user_books.empty? || no_users?
  end

  def no_users?
    !user_books.detect {|ub| User.where(id: ub.user_id).exists? }
  end


end
