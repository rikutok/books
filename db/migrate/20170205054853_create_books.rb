class CreateBooks < ActiveRecord::Migration[5.0]
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.string :url
      t.text :contents
      t.string :image
    
      t.timestamps null: false
    end
  end
end
