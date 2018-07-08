class UserBook < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :status, presence: true
  validates_inclusion_of :status, in: ["Checked Out", "Read", "Not Read", "Returned"]

  scope :checked_out, -> { where(status: "Checked Out") }
  scope :read, -> { where(status: "Read") }

  def get_books_by_user_id
    Book.get_by_user_id(user_id)
  end

end
