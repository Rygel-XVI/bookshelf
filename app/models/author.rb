class Author < ApplicationRecord
  has_many :books

  validates :name, presence: true
  validates :name, uniqueness: true
end
