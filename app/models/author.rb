class Author < ApplicationRecord
  has_many :books

  validates :name, presence: true
  validates :name, uniqueness: true

  def destroy_if_empty
    self.destroy if books.empty?
  end

end
