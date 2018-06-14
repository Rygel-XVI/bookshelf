class CreateUserBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :user_books do |t|
      t.user_id :integer
      t.book_id :integer
      t.status :string

      t.timestamps
    end
  end
end
