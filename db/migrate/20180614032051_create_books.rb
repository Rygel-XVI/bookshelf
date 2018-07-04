class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.string :title
      t.text :description
      t.integer :word_count
      t.string :status, default: "Not Read"
      t.integer :author_id

      t.timestamps
    end
  end
end
