class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.title :string
      t.description :text
      t.word_count :integer
      t.string :status
      t.author_id :integer

      t.timestamps
    end
  end
end
