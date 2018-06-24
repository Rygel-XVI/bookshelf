class Book < ApplicationRecord
  belongs_to :author
  has_many :user_books
  has_many :users, through: :user_books

  accepts_nested_attributes_for :author

  validates :author, presence: true

end
