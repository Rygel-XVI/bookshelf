class UserBook < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :status, presence: true
  validates_inclusion_of :status, in: ["Checked Out", "Read", "Not Read", "Returned"]

  scope :checked_out, -> { where(status: "Checked Out") }
  scope :read, -> { where(status: "Read") }

  def self.get_books_by_user_id(userbooks)
    userbooks.map {|userbook| Book.get_by_user_id(userbook.book_id)}
  end

end
