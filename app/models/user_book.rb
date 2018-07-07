class UserBook < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :status, presence: true
  validates_inclusion_of :status, in: ["Checked Out", "Read", "Not Read", "Returned"]

end
