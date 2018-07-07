class Book < ApplicationRecord
  belongs_to :author
  has_many :user_books
  has_many :users, through: :user_books

  accepts_nested_attributes_for :author, reject_if: :all_blank
  accepts_nested_attributes_for :user_books, reject_if: :all_blank

  validates :author, :title, :word_count, :status, presence: true
  validates_inclusion_of :status, in: ["Checked Out", "Available", "Not Available", "Graveyard"]

  def self.available
    where(status: "Available")
  end

  def self.checked_out
    where(status: "Checked Out")
  end

  def self.not_available
    where(status: "Not Available")
  end

  def self.graveyard
    where(status: "Graveyard")
  end

  def interactable?
    status == "Available" || status == "Checked Out"
  end

  def can_destroy?
    binding.pry
    user_books.empty? || no_users?
  end

  def no_users?
    binding.pry
    !user_books.detect {|ub| User.find(ub.user_id)}
  end

end
