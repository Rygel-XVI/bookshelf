class UserBook < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :status, presence: true
  validates_inclusion_of :status, in: ["Checked Out", "Read", "Not Read", "Returned"]

  # def has_valid_user?
  #   @userbooks.detect {|ub| User.find(ub.user_id)}
  # end
end
