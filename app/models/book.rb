class Book < ApplicationRecord
  belongs_to :author
  has_many :user_books
  has_many :users, through: :user_books

  accepts_nested_attributes_for :author, reject_if: :all_blank
  accepts_nested_attributes_for :user_books, reject_if: :all_blank

  validates :author, :title, :word_count, :status, presence: true
  validates_inclusion_of :status, in: ["Checked Out", "Available", "Not Available"]

end
