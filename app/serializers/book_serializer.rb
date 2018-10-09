class BookSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :word_count, :status, :author_id,
  belongs_to :author
end
