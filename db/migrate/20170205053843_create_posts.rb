class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :content
      t.string :url
      t.integer :user_id
      t.integer :book_id
    
      t.timestamps null: false
    end
  end
end
